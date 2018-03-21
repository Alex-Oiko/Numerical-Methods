function VUOC=Fuocon(T,S0,K,U,sigma,r)
% Continuous price for up-and-out call option 
d1S0K=(log(S0/K)+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d1S0U=(log(S0/U)+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d2S0K=(log(S0/K)+(r-sigma^2/2)*T)/(sigma*sqrt(T));
d2S0U=(log(S0/U)+(r-sigma^2/2)*T)/(sigma*sqrt(T));
over=U^2/(K*S0);
d1over=(log(over)+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d2over=(log(over)+(r-sigma^2/2)*T)/(sigma*sqrt(T));
d1US0=(log(U/S0)+(r+sigma^2/2)*T)/(sigma*sqrt(T));
d2US0=(log(U/S0)+(r-sigma^2/2)*T)/(sigma*sqrt(T));
%formula for compute the price 
VUOC=S0*(normcdf(d1S0K)-normcdf(d1S0U))-K*exp(-r*T)*(normcdf(d2S0K)-normcdf(d2S0U)) ...
    - U*(S0/U)^(-2*r/sigma^2)*(normcdf(d1over)-normcdf(d1US0)) ...
    + K*exp(-r*T)*(S0/U)^(1-2*r/sigma^2)*(normcdf(d2over)-normcdf(d2US0));

end