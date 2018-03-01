function [MCstd, MCAsianArithPrice, MCConfInt] = asianArithMCCtrlVarLB(S0, K, sigma, r, T, n, M, bstarhat_lb, alpha)

dt = T/n;
C = zeros(1,M);
LB = zeros(1,M);
for j = 1:M
    S = [S0 zeros(1,n)];
    for i = 1:n
        S(i+1) = S(i)*exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn);
    end
    C(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0); 
    LB(j) = exp(-r*T)*(mean(S(2:n+1))-K).*(geomean(S(2:n+1))>K);
end
GTrue = asianGeometricCall(S0, K, r, T, n, sigma); % calls the true pricing formula of the geometric Asian option
LB
Cb = C - bstarhat_lb*(LB-GTrue); % computes the sample of CV discounted payoffs of the arithmetic Asian option
MCAsianArithPrice = mean(Cb); % computes the CV price estimate of the arithmetic Asian option
MCstd = std(Cb)/sqrt(M); % computes the standard error of the CV price estimate of the arithmetic Asian option
format short g
MCConfInt = MCAsianArithPrice + norminv(0.5+alpha/2)*MCstd*[-1 1]; % 100*alpha% confidence interval
