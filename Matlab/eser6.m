function [ res ] = eser6( )
%ESER6 realizzare un programma che consenta di campionare secondo il
%seguente schema; si estrae un numero a caso da una distribuzione 
%multinomiale data (si assuma una distribuzione con supporto (1,2,3,4)), 
%in base alla realizzazione della variabile di estragga un campione da una
%distribizione gaussiana con media e varianza specificate dall'utente, 
%media e varianza dipendono dal particolare valore estratto della variabile
%multinomiale. Si proceda in questo modo per un numero di campioni fissato.
%Infine si computi l'istogramma della variabile aleatoria ottenuta in base 
%allo schema di campionamento.
    mu=input('media ');
    sigma = input('varianza ');
    vet = mnrnd(1000,[0.2,0.3,0.1,0.4],1);
    res= zeros(1,1);
    k=1;
    for i=1:4
        temp=normrnd(mu * i, sigma, 1, vet(i));
        for j=1:vet(i)
            res(k)=temp(j);
            k=k+1;
        end
    end
    hist(res,100);
end

