function expected_value = expectationContinuousMonitoringApprox(S0,K,sigma,r,T,n)
    gamma = (log(K/S0)-(r-sigma^2/2)*(T/2))/sigma;
    
    delta = T/n;
    sum = 0;
    fun = @(t) exp(-r*(T-t)).*normcdf((-gamma + sigma*t - (sigma*t.^2)/(2*T))/(sqrt(T/3)));
    for i=0:delta:T
        sum = sum + fun(i)*delta;
    end

    expected_value = (S0/T)*sum-K*exp(-r*T)*normcdf(-gamma/(sqrt(T/3)));
end
