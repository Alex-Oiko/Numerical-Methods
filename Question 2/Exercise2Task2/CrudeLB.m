function [CrudeLBstd, CrudeLBPrice, CrudeLBConfInt] = CrudeLB(T,S0,K,sigma,r,n,alpha)
M=2E6; % number of Crude Monte Carlo Simulation 
b = r-sigma^2/2;
LBC = zeros(1,M); % pre-define vector of discounted payoff samples
dt=T/n;

for j = 1:M
    S = [S0 zeros(1,n)];
    
    Z = randn(1,n); % generate vector of standard normals for use in generating the stock price trajectory
    for i = 1:n
        S(i+1) = S(i)*exp(b*dt+sigma*sqrt(dt)*Z(i)); % simulation of stock price trajectory (exact method)
        
    end
    LBC(j)=exp(-r*T)*max(max(S(1:n+1))-K,0); % look back option payoff
    
end

CrudeLBPrice = mean(LBC); % computes the price of look back call option
CrudeLBstd = std(LBC)/sqrt(M); % computes the standard error of look back option 
format short g
CrudeLBConfInt = CrudeLBPrice + norminv(0.5+alpha/2)*CrudeLBstd*[-1 1]; % compute the confidence interval of discrete look back option 