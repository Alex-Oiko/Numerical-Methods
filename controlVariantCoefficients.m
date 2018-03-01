function [correlcoef_lb,bstarhat_lb,correlcoef_geo,bstarhat_geo] = controlVariantCoefficients(S0,r,sigma,K,T,n,M)

dt = T/n; 
C = zeros(1,M);  
LB = zeros(1,M);
G = zeros(1,M);
for j = 1:M
    S = [S0 zeros(1,n)];
    for i = 1:n
        S(i+1) = S(i)*exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn); 
    end
    C(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0);
    G(j) = exp(-r*T)*max(geomean(S(2:n+1))-K,0);
    LB(j) = exp(-r*T)*(mean(S(2:n+1))-K).*(geomean(S(2:n+1))>K);
end
% scatter(P,C,10,'b')
% h = lsline;
% set(h,'color','b')
% regress_coefs = regress(C', [ones(Mb,1) P']); % regresses C samples on P samples
bstarhat_geo = sum((C-mean(C)).*(G-mean(G)))/sum((G-mean(G)).^2); % computes the estimate of the optimal coefficient b*
correlcoef_geo = sum((C-mean(C)).*(G-mean(G)))/sqrt(sum((G-mean(G)).^2)*sum((G-mean(G)).^2)); % computes the correlation coef

bstarhat_lb = sum((C-mean(C)).*(LB-mean(LB)))/sum((LB-mean(LB)).^2); % computes the estimate of the optimal coefficient b*
correlcoef_lb = sum((C-mean(C)).*(LB-mean(LB)))/sqrt(sum((LB-mean(LB)).^2)*sum((LB-mean(LB)).^2)); % computes the correlation coef
% between samples of discounted payoffs of the arithmetic and geometric Asian options
end

