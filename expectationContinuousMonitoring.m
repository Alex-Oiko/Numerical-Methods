function expected_value = expectationContinuousMonitoring(S0,K,sigma,r,T)
    gamma = (log(K/S0)-(r-sigma^2/2)*(T/2))/sigma;
    fun = @(t) exp(-r*(T-t)).*normcdf((-gamma + sigma*t - (sigma*t.^2)/(2*T))/(sqrt(T/3)));

    expected_value = (S0/T)*integral(fun,0,T)-K*exp(-r*T)*normcdf(-gamma/(sqrt(T/3)));
end

