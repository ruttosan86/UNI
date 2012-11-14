function [ V ] = permuta( V )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
K=length(V)-1;
n=K;
    for I=1:n
        U=fix((rand*K))+1;
        temp=V(K);
        V(K)=V(U);
        V(U)=temp;
        K=K-1;
    end
end

