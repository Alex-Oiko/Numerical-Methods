function [geometric_asian_expected_asian] = geometricAsianExpectedLowerBound(S0,r,sigma,K,T,n)
    for j=1:size(n,2)
        delta = T/n(j);
        for i=1:size(K,2)
            T_hat = ((n(j)+1)*delta)/2;
            sigma_hat = sigma*sqrt((2*n(j)+1)/(3*n(j)));
            d = (log(S0/K(i))+(r-sigma^2/2+sigma_hat^2)*T_hat)/(sigma_hat*sqrt(T_hat));

            geometric_asian_expected_asian(j,i) = S0*exp((r-sigma^2/2+sigma_hat^2/2)*T_hat-r*T)*normcdf(d) - K(i)*exp(-r*T)*normcdf(d-sigma_hat*sqrt(T_hat));
        end
    end
end
