function [ integrale ] = Integrale( n, a, b )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
diff=b-a;
integrale=0;
for I=1:n
    X=rand*diff+a;
    integrale = integrale + (1 - X^2)^(3/2);
end
integrale = integrale/n;

end

