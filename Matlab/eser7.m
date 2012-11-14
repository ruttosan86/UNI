function [ p0, p4 ] = eser7(  )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
P=[0.1, 0.15, 0.05, 0.3, 0.25, 0.15];
Pg = [0.025, 0.03, 0.07, 0.0025, 0.015, 0.02];
vet = mnrnd(100,P,1);
res = zeros(1,1);
prob0 = zeros(1,1);
prob4 = zeros(1,1);
for k=1:1000
    for i=1:length(P)
        res(i) = binornd(vet(i),Pg(i));
    end
    totG = sum(res);
    if(totG == 0)
        prob0(k)=1;
    else
        prob0(k)=0;
    end
    if(totG<4)
        prob4(k) = 1;
    else
        prob4(k) = 0;
    end
end
p0 = sum(prob0);
p4 = sum(prob4);
p0=p0/1000;
p4 = p4/1000;
end

