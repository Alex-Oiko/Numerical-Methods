%%% Computes the precise expected lower bound value for the asian call
%%% option and its delta

function [expected_asian,expected_asian_delta] = asianExpectedLowerBound(S0,K,sigma,r,T,n)

    sum_result = 0;
    sum_result_pdf = 0;

    delta = T/n;
    T_hat = ((n+1)*delta)/2;
    sigma_hat = sigma*sqrt((2*n+1)/(3*n));
    b = (log(S0/K)+(r-sigma^2/2)*T_hat)/(sigma_hat*sqrt(T_hat));

    for k=1:n
        m_k = (r-sigma^2/2)*k*delta;
        sigma_k = sigma*sqrt(k*delta);
        a_k_num = k*(n+1-((k+1)/2));
        a_k_den = sqrt((n*(n+1)*(2*n+1))/6);
        a_k = sigma*sqrt(delta)*(a_k_num/a_k_den);

        sum_result = sum_result + (exp(m_k+sigma_k^2/2))*normcdf(b+a_k);
        sum_result_pdf = sum_result_pdf + (exp(m_k+sigma_k^2/2))*normpdf(b+a_k);
    end
    expected_asian = ((S0*exp(-r*T))/n)*sum_result-K*exp(-r*T)*normcdf(b); %the expected value for the lower bound of the asian call
    
    expected_asian_delta = ((exp(-r*T))/n)*sum_result ...
    + (S0*exp(-r*T)/n)*sum_result_pdf*(1/S0)*(1/(sigma_hat*sqrt(T_hat))) ...
    - K*exp(-r*T)*normpdf(b)*(1/S0)*(1/(sigma_hat*sqrt(T_hat))); % the first sensitivity with respect to S0
end

