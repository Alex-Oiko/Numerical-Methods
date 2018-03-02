S0 = 100; r = 0.04; sigma = 0.3; K = [90 100 110]; T = 1; n = [4 12 50]; M = 1E5; alpha = 0.95;

%% Question 3
expected_asian_lower_bound = [];
geometric_asian_option_expected = [];

for i=1:size(n,2)
    for k=1:size(K,2)
        expected_asian_lower_bound(i,k) = asianExpectedLowerBound(S0,K(k),sigma,r,T,n(i));
        geometric_asian_option_expected(i,k) = geometricAsianExpectedLowerBound(S0,K(k),sigma,r,T,n(i));
    end
end

%% Question 5
continuous_monitoring = expectationContinuousMonitoring(S0,K(2),sigma,r,T);
for i=1:20
    continuous_monitoring_approx(i) = expectationContinuousMonitoringApprox(S0,K(2),sigma,r,T,2^i);
end

%% Question 4
geo_simulations = [];
lb_simulations = [];
epsilon = [];

for i=1:size(n,2)
    for k = 1:size(K,2)
        dt = T/n(i); 

        [correlcoef_lb, bstarhat_lb,correlcoef_geo, bstarhat_geo] = controlVariateCoefficients(S0, K(k), sigma, r, T, dt, M);
        
        [lb_std, lb_asian_price, lb_conf_int,lb_exec_time] = asianMCCtrVarLB(S0, K(k), sigma, r, T, dt, n(i), M, bstarhat_lb, alpha);
        [geo_std, geo_asian_price, geo_conf_int,geo_exec_time] = asianMCCtrVarGeo(S0, K(k), sigma, r, T, dt, n(i), M, bstarhat_geo, alpha);
        
        lb_simulations(i,k,:) = [lb_std, lb_asian_price, lb_conf_int];
        geo_simulations(i,k,:) = [geo_std, geo_asian_price, geo_conf_int];
        
        epsilon(i,k) = (lb_exec_time*lb_std^2)/(geo_exec_time*geo_std^2);
    end
end