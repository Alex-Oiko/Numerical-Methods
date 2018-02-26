function [expected_asian] = asianExpectedLowerBound(S0,r,sigma,K,T,n)

    sum_result = 0;

    for j=1:size(n,2)
        delta = T/n(j);
        for i=1:size(K,2)
            T_hat = ((n(j)+1)*delta)/2;
            sigma_hat = sigma*sqrt((2*n(j)+1)/(3*n(j)));
            b = (log(S0/K(i))+(r-sigma^2/2)*T_hat)/(sigma_hat*sqrt(T_hat));

            for k=1:n(j)
                m_k = (r-sigma^2/2)*k*delta;
                sigma_k = sigma*sqrt(k*delta);
                a_k_num = k*(n(j)+1-((k+1)/2));
                a_k_den = sqrt((n(j)*(n(j)+1)*(2*n(j)+1))/6);
                a_k = sigma*sqrt(delta)*(a_k_num/a_k_den);

                sum_result = sum_result + (exp(m_k+sigma_k^2/2))*normcdf(b+a_k);
            end
            expected_asian(j,i) = ((S0*exp(-r*T))/n(j))*sum_result-K(i)*exp(-r*T)*normcdf(b);
            sum_result = 0;
        end
    end
end

