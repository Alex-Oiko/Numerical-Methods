function [CrudeUOCstd, CrudeUOCPrice, CrudeUOCConfInt] = CrudeUOC(T,S0,K,U,sigma,r,n,alpha)
%Crude Monte Carlo Simulation
M=2E6; % number of Monte Carlo Simulation 
b = r-sigma^2/2;
UOC = zeros(1,M); % pre-define vector of UOC payoff samples
dt=T/n;

for j = 1:M
    S = [S0 zeros(1,n)];
    
    Z = randn(1,n); % generate vector of standard normals for use in generating the stock price trajectory
    for i = 1:n
        S(i+1) = S(i)*exp(b*dt+sigma*sqrt(dt)*Z(i)); % simulation of stock price trajectory (exact method)
        
    end
    UOC(j)=exp(-r*T)*max(S(n+1)-K,0)*(max(S(1:n+1))<U); % compute the UOC payoff
    
end

CrudeUOCPrice = mean(UOC); % computes the price from crude Monte Carlo
CrudeUOCstd = std(UOC)/sqrt(M); % computes the standard error 
format short g
CrudeUOCConfInt = CrudeUOCPrice + norminv(0.5+alpha/2)*CrudeUOCstd*[-1 1]; % compute the confidence interval