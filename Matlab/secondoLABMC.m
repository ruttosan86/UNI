function [ x1, x2 ] = secondoLABMC( a,b,c )
%secondoLABMC calcola le radici x1 e x2
%   dell'eq di secondo grado ax^2+bx+c=0
delta = b^2 - 4*a*c;
x1=(-b+sqrt(delta))/(2*a);
x2=(-b-sqrt(delta))/(2*a);

end

