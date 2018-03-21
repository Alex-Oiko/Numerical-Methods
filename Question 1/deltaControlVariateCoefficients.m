%%% Calculates the best control variate coefficients and their respective
%%% bstarhats which will be used later on to approximate the prices of the
%%% call options. It calculates both the geometic mean delta and the lower
%%% bound delta
%%% coefficients

function [correlcoef_lb_delta, bstarhat_lb_delta,correlcoef_geo_delta, bstarhat_geo_delta] = deltaControlVariateCoefficients(S0, K, sigma, r, T, dt, Mb)

n = T/dt;
C = zeros(1,Mb);  
P = zeros(1,Mb);
LB = zeros(1,Mb);
for j = 1:Mb
    S = [S0 zeros(1,n)];
    for i = 1:n
        S(i+1) = S(i)*exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn); 
    end
    C(j) = exp(-r*T)*max(mean(S(2:n+1))-K,0)*(log(S(2)/S0)...
        - (r-0.5*sigma^2)*dt)/(S0*sigma^2*dt);  % Arithematic Option Delta using LR method
    P(j) = exp(-r*T)*max(geomean(S(2:n+1))-K,0)*(log(S(2)/S0)...
        - (r-0.5*sigma^2)*dt)/(S0*sigma^2*dt);    % Geometric Option Delta    
    LB(j) = exp(-r*T)*(mean(S(2:n+1))-K)*(geomean(S(2:n+1)) > K)...
    *(log(S(2)/S0)- (r-0.5*sigma^2)*dt)/(S0*sigma^2*dt); %Lowerbound Delta
end

bstarhat_lb_delta = sum((C-mean(C)).*(LB-mean(LB)))/sum((LB-mean(LB)).^2); 
correlcoef_lb_delta = sum((C-mean(C)).*(LB-mean(LB)))/sqrt(sum((C-mean(C)).^2)*sum((LB-mean(LB)).^2)); 
bstarhat_geo_delta = sum((C-mean(C)).*(P-mean(P)))/sum((P-mean(P)).^2); 
correlcoef_geo_delta = sum((C-mean(C)).*(P-mean(P)))/sqrt(sum((C-mean(C)).^2)*sum((P-mean(P)).^2)); 