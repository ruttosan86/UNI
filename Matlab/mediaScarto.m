function [ m, s ] = mediaScarto( n, a, b )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    V = zeros(n,1);
    int=3*pi/16;
    s= 0;
    for I=1:n
        V(I)=Integrale(100,a,b);
        s = s + (V(I)-int)^2;
    end
    m = sum(V);
    m = m/n;
    s = s/n;
end

