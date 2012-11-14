function [ res ] = main( x )
%MAIN secondo esercizio
scelta=-1;
while (scelta~=1 || scelta~=0)
scelta = input('1 se vuoi la somma dei moduli, 0 se vuoi quella dei quadrati: SCELTA= ');
if scelta==0
    res=sommaModuli(x);
elseif scelta == 1
    res=sommaQuadrati(x);
else
    fprintf('non sai leggere!!!');
end
end
end

