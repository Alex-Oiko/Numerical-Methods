function [correlcoef_lb, bstarhat_lb,correlcoef_geo, bstarhat_geo] = controlVariateCoefficients(S0, K, sigma, r, T, dt, Mb)

n = T/dt;
C = zeros(1,Mb);  
P = zeros(1,Mb);
LB = zeros(1,Mb);
for j = 1:Mb
    S = [S0 zeros(1,n)];
    for i = 1:n
        S(i+1) = S(i)*exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn); 
    end
    C(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0); 
    P(j) = exp(-r*T)*max(geomean(S(2:n+1))-K,0);
    LB(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0)*(geomean(S(2:n+1))>K);
end

bstarhat_lb = sum((C-mean(C)).*(LB-mean(LB)))/sum((LB-mean(LB)).^2); 
correlcoef_lb = sum((C-mean(C)).*(LB-mean(LB)))/sqrt(sum((C-mean(C)).^2)*sum((LB-mean(LB)).^2)); 
bstarhat_geo = sum((C-mean(C)).*(P-mean(P)))/sum((P-mean(P)).^2); 
correlcoef_geo = sum((C-mean(C)).*(P-mean(P)))/sqrt(sum((C-mean(C)).^2)*sum((P-mean(P)).^2)); 