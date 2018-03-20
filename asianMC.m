%%% Computes the approximation of the Asian call option price using Monte
%%% Carlo and the lower bound of the asian call option as a control variate

function [MCstd, MCAsianArithPrice, MCConfInt,exec_time] = asianMC(S0, K, sigma, r, T, dt, n, M,alpha)

tic;
C = zeros(1,M); 
for j = 1:M
    S = [S0 zeros(1,n)];
    for i = 1:n
        S(i+1) = S(i)*exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn); 
    end
    C(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0); % Asian Call option Monte Carlo values
end
MCAsianArithPrice = mean(C);
exec_time = toc; %execution time
MCstd = std(C)/sqrt(M); %standard error
format short g
MCConfInt = MCAsianArithPrice + norminv(0.5+alpha/2)*MCstd*[-1 1]; %confidence interval