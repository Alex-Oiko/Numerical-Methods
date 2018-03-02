function [MCstd, MCAsianArithPrice, MCConfInt,exec_time] = asianMCCtrVarLB(S0, K, sigma, r, T, dt, n, M, bstarhat, alpha)

tic;
C = zeros(1,M); 
LB = zeros(1,M);
for j = 1:M
    S = [S0 zeros(1,n)];
    for i = 1:n
        S(i+1) = S(i)*exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn); 
    end
    C(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0); 
    LB(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0)*(geomean(S(2:n+1))>K);
end

LB_expected = asianExpectedLowerBound(S0, K, sigma, r, T, n); 
Cb = C - bstarhat*(LB-LB_expected); 
MCAsianArithPrice = mean(Cb);
exec_time = toc;
MCstd = std(Cb)/sqrt(M);
format short g
MCConfInt = MCAsianArithPrice + norminv(0.5+alpha/2)*MCstd*[-1 1]; 