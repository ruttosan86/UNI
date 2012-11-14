function [ V ] = randomVector( n )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    V = zeros(n,1);
    for I=1:n
        V(I)= fix((rand*99))+1;
    end
    
    

end

