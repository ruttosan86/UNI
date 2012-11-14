function [ intAPpT , APpTm, intPCnS, PCnSm, intRappSpInvSpTot, RappSpInvSpTotm, intGuad, Guadm, intSteady,  Steadym ] = Inventory_Multi_Run( nRun, confidenza, s, S, r, h, c , L, MAX, lambda, epsilon)
%[ intAPpT , intPCnS, intRappSpInvSpTot, intGuad ] = Inventory_Multi_Run(
%nRun, confidenza, s, S, r, h, c , L, MAX, lambda)
%   Esegue più run della simulazione del modello dell'inventario e calcola
%   gli intervalli di confidenza dei vari indici.
%INPUT:
% nRun : numero di singoli run da valutare
% confidenza : percentuale di confidenza dell'intervallo degli indici
% s : soglia minima dell'inventario
% S : soglia massima dell'inventario
% r : ricavo per unità
% h : costo per unità di tempo per unità di stoccaggio
% c : costo d'acquisto di un'unità
% L : tempo d'esecuzione dell'ordine
% MAX : quantità massima ordinabile da un cliente. questa quantità dovrà
%       essere determinata in base a delle osservazioni (in generale qual è
%       la quantità ordinata?)
% lambda: parametro della distribuzione esponenziale
% epsilon : precisione per determinare quando il sistema entra in uno stato
% stazionario
%OUTPUT:
% intAPpT : intervallo di confidenza per il profitto medio per unità di tempo
% APpTm : Valore mesio del profitto medio per unità di tempo
% intPCnS : intervallo di confidenza per la probabilità di insoddisfazione dei clienti (n clienti
%insoddisfatti/n totali)
% PCnSm : Valore medio della probabilità di insoddisfazione dei clienti
% intRappSpInvSpTot : intervallo di confidenza per il rapporto tra le spese dovute allo stoccaggio e le spese
%totali
% intRappSpInvTotm : Valore medio del rapporto tra spese di stoccaggio e
% spese totali
% intGuadagno : intervallo di confidenza per il profitto netto totale
% intGuadagnom : Valore medio del profitto netto totale
% intSteady : Intervallo di confidenza della percentuale di tempo nel quale
% il sistema è in uno stato stazionario
% Steadym: Valore medio della percentuale di tempo nel quale il sistema si
% trova in uno stato stazionario
APpT = zeros(1,nRun);   %inizializzo gli array che conterranno i risultati
PCnS = zeros(1,nRun);   % di goni indice per tutti i run
RappSpInvSpTot = zeros(1,nRun);
Guadagno = zeros(1,nRun);
Steady = zeros(1,nRun);
i=1;    %indice della posizione negli array (serve per salvare i dati dei run)
alfa = 1-confidenza;    
alfa = alfa/2;
Gradi = nRun-1;
while(i<=nRun)  %eseguo i vari run (nRun) e salvo i risultati di ogni run.
    [APpT(i), PCnS(i), RappSpInvSpTot(i), Guadagno(i), Steady(i)]= Inventory_Single_Run( s, S, r, h, c , L, MAX, lambda,epsilon,false);
    i=i+1;
end
APpTm = mean(APpT); %Calcolo media e varianza di ogni indice. 
APpTv = var(APpT);
PCnSm = mean(PCnS);
PCnSv = var(PCnS);
RappSpInvSpTotm = mean(RappSpInvSpTot);
RappSpInvSpTotv = var(RappSpInvSpTot);
Guadm = mean(Guadagno);
Guadv = var(Guadagno);
Steadym = mean(Steady);
Steadyv = var(Steady);
%Costruisco l'intervallo di confidenza come 
%[Xmedio - t((1-alfa)/2;%nRun-1)*radq(varX/nRun) ; Xmedio + t((1-alfa)/2;%nRun-1)*radq(varX/nRun)]
intAPpT = [APpTm+tinv(alfa,Gradi)*sqrt(APpTv/nRun),APpTm-tinv(alfa,Gradi)*sqrt(APpTv/nRun)];
intPCnS = [PCnSm+tinv(alfa,Gradi)*sqrt(PCnSv/nRun),PCnSm-tinv(alfa,Gradi)*sqrt(PCnSv/nRun)];
intRappSpInvSpTot = [RappSpInvSpTotm+tinv(alfa,Gradi)*sqrt(RappSpInvSpTotv/nRun),RappSpInvSpTotm-tinv(alfa,Gradi)*sqrt(RappSpInvSpTotv/nRun)];
intGuad = [Guadm+tinv(alfa,Gradi)*sqrt(Guadv/nRun),Guadm-tinv(alfa,Gradi)*sqrt(Guadv/nRun)];
intSteady = [Steadym+tinv(alfa,Gradi)*sqrt(Steadyv/nRun),Steadym-tinv(alfa,Gradi)*sqrt(Steadyv/nRun)];
end

