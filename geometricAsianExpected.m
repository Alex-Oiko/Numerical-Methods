%%% Takes values as parameters. NOT arrays.
%%% Calculates the values of the Expected price value of the asian call
%%% option
function [geometric_asian_expected_asian] = geometricAsianExpected(S0,K,sigma,r,T,n)
    delta = T/n;
    T_hat = ((n+1)*delta)/2;
    sigma_hat = sigma*sqrt((2*n+1)/(3*n));
    d = (log(S0/K)+(r-sigma^2/2+sigma_hat^2)*T_hat)/(sigma_hat*sqrt(T_hat));

    geometric_asian_expected_asian = S0*exp((r-sigma^2/2+sigma_hat^2/2)*T_hat-r*T)*normcdf(d) - K*exp(-r*T)*normcdf(d-sigma_hat*sqrt(T_hat));
end
