function [LBCstd,LBCPrice,LBCConfInt]=Flbc(T,S0,K,sigma,r,n,alpha)
% function of discretely monitored look-back barrier call
M=1E6; % number of AV Monte Carlo Simulation 
b = r-sigma^2/2;
LBC = zeros(1,M);% pre-define vector of discounted payoff samples
dt=T/n;
LBCAnt = zeros(1,M);% pre-define vector of ANTITHETIC discounted payoff samples
for j = 1:M
    S = [S0 zeros(1,n)]; % pre-define vector for stock price 
    SAnt = [S0 zeros(1,n)]; % pre-define vector for ANTITHETIC stock price 
    Z = randn(1,n); 
    for i = 1:n
        S(i+1) = S(i)*exp(b*dt+sigma*sqrt(dt)*Z(i)); % simulation of stock price trajectory (exact method)
        SAnt(i+1) = SAnt(i)*exp(b*dt+sigma*sqrt(dt)*(-Z(i))); % simulate  ANTITHETIC stock price trajectory (exact method)
    end
    LBC(j)=exp(-r*T)*max(max(S(1:n+1))-K,0);
    LBCAnt(j)=exp(-r*T)*max(max(SAnt(1:n+1))-K,0);
    
end
LBCPrice=mean((LBC+LBCAnt)/2); % return the look back call option price
LBCstd=std((LBC+LBCAnt)/2)/sqrt(M); % return the standard deviation 
format long g 
LBCConfInt = LBCPrice + norminv(0.5+alpha/2)*LBCstd*[-1 1]; % 100*alpha% confidence interval

end