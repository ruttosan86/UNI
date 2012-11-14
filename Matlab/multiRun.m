function [ intAWT, intPCW, intAWTW, intATCS ] = multiRun( nRun, lambda, mu ,confidenza)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
AWT = zeros(1,nRun);
PCW = zeros(1,nRun);
AWTW = zeros(1,nRun);
ATCS = zeros(1,nRun);
i=1;
alfa = 1-confidenza;
alfa = alfa/2;
Gradi = nRun-1;
while(i<=nRun)
    [ATCS(i),PCW(i),AWTW(i),AWT(i)]=coda(lambda,mu);
    i=i+1;
end
AWTm = mean(AWT);
PCWm = mean(PCW);
AWTWm = mean(AWTW);
ATCSm = mean(ATCS);
AWTv = var(AWT);
PCWv = var(PCW);
AWTWv = var(AWTW);
ATCSv = var(ATCS);
intAWT = [AWTm+tinv(alfa,Gradi)*sqrt(AWTv/nRun),AWTm-tinv(alfa,Gradi)*sqrt(AWTv/nRun)];
intPCW = [PCWm+tinv(alfa,Gradi)*sqrt(PCWv/nRun),PCWm-tinv(alfa,Gradi)*sqrt(PCWv/nRun)];
intAWTW = [AWTWm+tinv(alfa,Gradi)*sqrt(AWTWv/nRun),AWTWm-tinv(alfa,Gradi)*sqrt(AWTWv/nRun)];
intATCS = [ATCSm+tinv(alfa,Gradi)*sqrt(ATCSv/nRun),ATCSm-tinv(alfa,Gradi)*sqrt(ATCSv/nRun)];
end

