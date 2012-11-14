function [ f ] = F1( x1, x2, x3 )
%F1 calcola una funzione lunga da scrivere.
if(x1>0 && x2>0 && x3>0)
    f=3*x1 + 0.5*x2^2 - 0.2*x3^2;
else
    f=-x1^2 + 2.5*x2 + 0.1*x3;
end
end

