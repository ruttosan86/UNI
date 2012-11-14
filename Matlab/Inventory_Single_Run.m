function [ APpT, PCnS, RappSpInvSpTot, Guadagno, pSteady ] = Inventory_Single_Run( s, S, r, h, c , L, MAX, lambda, epsilon, stampa)
%[ APpT, Guadagno ] Inventory_Single_Run ( s, S, r, h, c , L, lambda)
%   Esegue un singolo run della simulazione del modello dell'inventario.
%INPUT:
% s : soglia minima dell'inventario
% S : soglia massima dell'inventario
% r : ricavo per unit�
% h : costo per unit� di tempo per unit� di stoccaggio
% c : costo d'acquisto di un'unit�
% L : tempo d'esecuzione dell'ordine
% MAX : quantit� massima ordinabile da un cliente. questa quantit� dovr�
%       essere determinata in base a delle osservazioni (in generale qual �
%       la quantit� ordinata?)
% lambda: parametro della distribuzione esponenziale
% epsilon : precisione per determinare quando il sistema entra in uno stato
% stazionario
% stampa : Variabile booleana: se true stampa il grafico delle medie,
%           altrimenti no.
%OUTPUT:
% APpT : Profitto medio per unit� di tempo
%PCnS : Probabilit� di insoddisfazione dei clienti (n clienti
%insoddisfatti/n totali)
%RappSpInvSpTot : Rapporto tra le spese dovute allo stoccaggio e le spese
%totali
% Guadagno : Profitto netto totale
% pSteady : percentuale di tempo nel quale il sistema si trova in uno stato
%           stazionario
t = 0; %tempo della simulazione
C = 0; %Costo totale degli ordini
H = 0; %Costo totale dello stoccaggio
R = 0; %Ricavo totale

NC = 0;%Numero totale dei clienti
Steady = zeros(1,NC);   %indica se al tempo t il sistema soddisfa il vincolo
                        % media
APpTm = zeros(1,NC);    %array delle medie del guadagno/t fino al tempo t
NCnS = 0; %Numero dei clienti non soddisfatti, ovvero il numero di utenti
          %i quali ordini sono stati soddisfatti parzialmente  
t0 = -(1/lambda)*log(rand); %inizializzo il tempo di arrivo del primo 
                            %cliente
t1 = inf; %tempo di arrivo dell'ultimo ordine. (inizializzo a +inf)
x = S;  %quantit� nell'inventario
y = 0;  %quantit� in ordine
T = 5000; %tempo di chiusura del "negozio"

while(min(t0, t1) < T)
    if(t0 < t1)                 %SERVO IL CLIENTE
        H = H + (t0 - t) * x * h; %incremento il costo di magazzino
        t = t0;                 %sposto il tempo di simulazione su t0
        NC= NC + 1;             %incremento il numero di clienti
        d = fix(rand * (MAX)) + 1;  %genero casualmente la domanda del cliente
                                %La domanda � distribuita uniformemente ed
                                %� definita in [1, MAX + 1]
        w = min(d, x);          %w � la quantit� prelevabile dal cliente
        if w<d                  %se l'ordine del cliente � maggiore della
            NCnS = NCnS + 1;    %disponibilit� del magazzino, incremento il numero
        end                     %di clienti non soddisfatti
        x = x - w;              %aggiorno x
        R = R + w * r;          %aggiorno il ricavo totale
        APpTm(NC)=(R - C - H)/t;  %Calcolo il guadagno medio per unit� di tempo
                                   %fino al cliente NC
        if(NC>1)                %Verifico se il sistema si trova in uno stato
            if(abs(APpTm(NC-1)-APpTm(NC))<epsilon)  %stazionario. Se la condizione
                Steady(NC)=1;   %� verificata metto '1' nell'array steady, a significare
            else                %che si � in uno stato in cui la media da un passo all'altro
                Steady(NC)=0;   %varia di un valore <epsilon. Se la condizione non �
            end                 %verificata metto 0.
        else
            Steady(1)=0;        %All'arrivo del primo cliente non posso dire se sono in
        end                     %uno stato statico.
        if((x < s) && (y == 0)) %se l'inventario � sceso sotto la soglia s
            y = S - x;          %e non ho fatto altri ordini eseguo un ordine
            t1 = t + L;         % e setto il tempo di arrivo dell'ordine
        end
        t0 = t + (-(1/lambda)*log(rand)); %calcolo l'arrivo del prossimo cliente
    else                        %ARRIVA UN ORDINE
        H = H + (t1 - t) * h * x;%incremento il costo di magazzino
        t= t1;                  %sposto il tempo di simulazione su t0
        C = C + c * y;          %aggiorno il costo totale
        x = x + y;              %aggiorno l'inventario
        y = 0;                  %setto y a 0 e t1 a +inf, ovvero non vi 
        t1 = inf;               %sono altri ordini in arrivo
    end
end

%TROVO LA POSIZIONE IN CUI IL SISTEMA ENTRA IN UNO STATO STAZIONARIO
x=NC;            %x indicher� il cliente dopo il quale il sistema entra in uno
nZero=0;         %stato stazionario. per fare ci� scorriamo all'indietro l'array Steady
while(x>1)       %fino a che non troviamo uno 0 (che indica una differenza >epsilon)
    if(Steady(x)==0)    %Da diverse prove ho visto che in realt� un risultato migliore lo
       if(nZero<2)      %si otteneva fermandosi quando si trova il 3o '0'. Questo 'trucco'
           nZero=nZero+1; %consente di trovare un punto pi� realistico, escludendo piccole
       else             %eventuali fluttuazioni della media.
           break;
       end   
    end    
    x=x-1;
end
%PLOT DEL GRAFICO DELLE MEDIE
if(stampa==true)    %questa parte viene eseguita solamente se il parametro 'stampa'
    if(x<NC)        %� settato a 'true'. il grafico sar� di colore blu per la 
        P=x;        %parte in cui il sistema sar� in uno stato transitorio e rosso
        Y1=zeros;   %altrimenti.
        X1=zeros;
        Y2=zeros;
        X2=zeros;
        for c=1:P
            Y1(c)=APpTm(c);
            X1(c)=c;
        end
        for c=P:NC
            Y2(c-P+1)=APpTm(c);
            X2(c-P+1)=c;
        end
            plot(X1,Y1,'b',X2,Y2,'r');
            grid on;
    else
            plot(APpTm);
            grid on;
    end
end
%CALCOLO DEGLI INDICI
APpT = (R - C - H)/T;           %calcolo il guadagno medio per unit� di tempo
                                %di tutto il run
pSteady=1-(x/NC);               %Calcolo la percentuale di tempo per il quale il sistema � stazionario
PCnS = NCnS / NC;               %probabilit� di insoddisfazione del cliente
Guadagno = R - C - H;           %Guadagno totale del run
RappSpInvSpTot = H/(C + H);     %Rapporto tra le spese dell'inventario e quelle totali
end

