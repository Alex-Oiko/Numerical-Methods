%%% Computes the approximation of the Asian call option price using Monte
%%% Carlo and the geometric asian call option of the asian call option as a control variate

function [MCstd, MCAsianArithPrice, MCConfInt,exec_time] = asianMCCtrVarGeo(S0, K, sigma, r, T, dt, n, M, bstarhat, alpha)

tic;
C = zeros(1,M); 
G = zeros(1,M);
for j = 1:M
    S = [S0 zeros(1,n)];
    for i = 1:n
        S(i+1) = S(i)*exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn); 
    end
    C(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0); % Asian Call option Monte Carlo values
    G(j) = exp(-r*T)*max(geomean(S(2:n+1))-K,0); % Geometric Asian option Monte Carlo values
end

GTrue = asianGeometricCall(S0, K, r, T, n, sigma); 
Cb = C - bstarhat*(G-GTrue); %the control variate estimates
MCAsianArithPrice = mean(Cb);
exec_time = toc; %execution time
MCstd = std(Cb)/sqrt(M); % standard error
format short g
MCConfInt = MCAsianArithPrice + norminv(0.5+alpha/2)*MCstd*[-1 1]; %confidence intervals