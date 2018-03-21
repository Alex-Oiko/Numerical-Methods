function [UOCstd,UOCPrice,UOCConfInt]=Fuoc(T,S0,K,U,sigma,r,n,alpha) 
% function of discretely monitored up-and-out barrier call option
M=1E6;
b = r-sigma^2/2;
UOC = zeros(1,M);% pre-define vector of discounted payoff samples
dt=T/n;
UOCAnt = zeros(1,M);% pre-define vector of ANTITHETIC discounted payoff samples
for j = 1:M
    S = [S0 zeros(1,n)]; % pre-difined vector of stock price
    SAnt = [S0 zeros(1,n)]; % pre-difined vector of ANTITHETIC  stock price
    Z = randn(1,n);
    for i = 1:n
        S(i+1) = S(i)*exp(b*dt+sigma*sqrt(dt)*Z(i)); % simulation of stock price trajectory (exact method)
        SAnt(i+1) = SAnt(i)*exp(b*dt+sigma*sqrt(dt)*(-Z(i))); % ANTITHETIC stock price trajectory (exact method)
    end
    UOC(j)=exp(-r*T)*max(S(n+1)-K,0)*(max(S(1:n+1))<U); % compute the UOC payoff
    UOCAnt(j)=exp(-r*T)*max(SAnt(n+1)-K,0)*(max(SAnt(1:n+1))<U); % the antithetic UOC payoff
    
end
UOCPrice=mean((UOC+UOCAnt)/2);% computes the AV price estimate of the arithmetic up-and-out option
UOCstd=std((UOC+UOCAnt)/2)/sqrt(M); % compute the standar deviation
format long g 
UOCConfInt = UOCPrice + norminv(0.5+alpha/2)*UOCstd*[-1 1]; % 100*alpha% confidence interval
end