function Plccon=Flccon(T,S0,K,sigma,r)
% compute the continuous price of look back call option 
d1S0K=(log(S0/K)+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d2S0K=(log(S0/K)+(r-sigma^2/2)*T)/(sigma*sqrt(T));
Plccon=S0*normcdf(d1S0K)-K*exp(-r*T)*normcdf(d2S0K)+S0*exp(-r*T)*sigma^2/(2*r) ...
    *(-(S0/K)^(-2*r/sigma/sigma)*normcdf(d1S0K-2*r*sqrt(T)/sigma)+exp(r*T)*normcdf(d1S0K));

end
