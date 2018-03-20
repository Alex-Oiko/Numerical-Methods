%%% Calculates the best control variate coefficients and their respective
%%% bstarhats which will be used later on to approximate the prices of the
%%% call options. It calculates both the geometic mean delta and the lower
%%% bound delta
%%% coefficients

function [correlcoef_lb_delta, bstarhat_lb_delta,correlcoef_geo_delta, bstarhat_geo_delta] = Delta_CV_Coeff(S0, K, sigma, r, T, dt, Mb)

n = T/dt;
C = zeros(1,Mb);  
P = zeros(1,Mb);
LB = zeros(1,Mb);
for j = 1:Mb
    S = [S0 zeros(1,n)];
    for i = 1:n
        S(i+1) = S(i)*exp((r-sigma^2/2)*dt+sigma*sqrt(dt)*randn); 
    end
    C(j) = exp(-r*T)*(mean(S(2:n+1))/S0)*(mean(S(2:n+1)) > K);       % Arithematic Option Delta using pathwise method
    P(j) = exp(-r*T)*(geomean(S(2:n+1))/S0)*(geomean(S(2:n+1)) > K);    % Geometric Option Delta    
    LB(j) = exp(-r*T)*(mean(S(2:n+1))-K)*(geomean(S(2:n+1)) > K)...
    *(log(S(2)/K)- (r-0.5*sigma^2)*dt)/(S0*sigma^2*dt); %Lowerbound Delta
end

bstarhat_lb_delta = sum((C-mean(C)).*(LB-mean(LB)))/sum((LB-mean(LB)).^2); 
correlcoef_lb_delta = sum((C-mean(C)).*(LB-mean(LB)))/sqrt(sum((C-mean(C)).^2)*sum((LB-mean(LB)).^2)); 
bstarhat_geo_delta = sum((C-mean(C)).*(P-mean(P)))/sum((P-mean(P)).^2); 
correlcoef_geo_delta = sum((C-mean(C)).*(P-mean(P)))/sqrt(sum((C-mean(C)).^2)*sum((P-mean(P)).^2)); 