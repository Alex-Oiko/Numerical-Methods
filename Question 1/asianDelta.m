%%% Computes the approximation of the Asian call option delta using Monte
%%% Carlo and the geometric asian call option delta as a control variate

function [MCstd, MCAsianArithDelta, MCConfInt,exec_time] = asianDelta(S0, K, sigma, r, T, dt, n, M, alpha)

tic;
LB = zeros(1,M);
for j = 1:M
    S = [S0 zeros(1,n)];
    for i = 1:n
        S(i+1) = S(i)*exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn); 
    end
    LR_ADelta(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0)*(log(S(2)/S0)...
        - (r-0.5*sigma^2)*dt)/(S0*sigma^2*dt); % simulates samples of the LR arithematic delta
  
end

MCAsianArithDelta = mean(LR_ADelta);
exec_time = toc; %execution time
MCstd = std(LR_ADelta)/sqrt(M); %standard error
format short g
MCConfInt = MCAsianArithDelta + norminv(0.5+alpha/2)*MCstd*[-1 1]; %the confidence intervals
