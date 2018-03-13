%%% Computes the approximation of the Asian call option delta using Monte
%%% Carlo and the geometric asian call option delta as a control variate

function [MCstd, MCAsianArithDelta, MCConfInt,exec_time] = asianMCCtrVarGeoDelta(S0, K, sigma, r, T, dt, n, M, bstarhat, alpha)

tic;
C = zeros(1,M); 
LB = zeros(1,M);
for j = 1:M
    S = [S0 zeros(1,n)];
    for i = 1:n
        S(i+1) = S(i)*exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn); 
    end
    PWDelta(j) = exp(-r*T)*(mean(S(2:n+1))/S0)*(mean(S(2:n+1)) > K); % simulates samples of the PW arithematic delta
    Geo_sim(j) = exp(-r*T)*(geomean(S(2:n+1))/S0)*(geomean(S(2:n+1)) > K); % simulates samples of the lowerbound delta
end

[Geo_expected, Geo_expected_delta]  = geometricAsianExpected(S0, K, sigma, r, T, n);
Cb = PWDelta - bstarhat*(Geo_sim-Geo_expected_delta); %calculates the control variate samples
MCAsianArithDelta = mean(Cb);
exec_time = toc; %execution time
MCstd = std(Cb)/sqrt(M); %standard error
format short g
MCConfInt = MCAsianArithDelta + norminv(0.5+alpha/2)*MCstd*[-1 1]; %the confidence intervals
