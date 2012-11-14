function [ AverageWaitingTimeSystem, ProbCostumerWait, awtotww, AverageWaitingTimeQueue] = coda(lambda, mu)

t = 0;
Na = 0;
w = 0;
Nd = 0;
%SS = 0;
n = 0;
T = 5000;     %tempo sportello chiuso



tA = -(1/lambda)*log(rand);
tD = inf;
p = zeros(1,Na);
tmA = zeros(1,Na);
tcA = zeros(1,Na);
tcqW = zeros(1,Na);
A = zeros(1,Na);
D = zeros(1,Nd);

while (min(tA,tD) < T) 
    if (tA<tD)
        t = tA;
        n = n+1;
        Na = Na +1;
        p(Na) = n/Na;
        A(Na) = t;
        tA = t + (-(1/lambda)*log(rand));
        if (n == 1)
            tD = t + (-(1/mu)*log(rand));
            tcqW(Na) = 0;
        else
            w = w + 1;
        end
    else
        t = tD;
        Nd = Nd +1;
        n = n-1;
        D(Nd) = t;
        tcA(Nd) = D(Nd)-A(Nd);
        
        tmA(Nd)=mean(tcA);
        if (n == 0)
            tD = inf;
        else
            tD = t +(-(1/mu)*log(rand));
            if(Na>Nd)
            tcqW(Nd + 1) = D(Nd)-A(Nd+1);
            end
        end
    end    
end

while(n > 0)
    t = tD;
    Nd = Nd+1;
    n = n-1;
    tD = t + (-(1/mu)*log(rand));
    D(Nd) = t;
end

Tp = max(t-T,0);
AverageWaitingTimeSystem = mean(tcA);
%plot(tmA)
ProbCostumerWait = w/Na;
awtotww = sum(tcqW)/w;
AverageWaitingTimeQueue = mean(tcqW);

end