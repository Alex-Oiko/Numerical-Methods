S0 = 100; r = 0.04; sigma = 0.3; K = [90 100 110]; T = 1; n = [4 12 50]; M = 1E5; alpha = 0.95;
%% Nothing should be printed on the command window. If the results are needed to be shown, one would need to print the variable
%% Question 3
expected_asian_lower_bound = [];
expected_asian_lower_bound_delta = [];
geometric_asian_option_expected = [];
geometric_asian_option_expected_delta = [];
ELBprice = [];
ELBdelta =[];
GeoAEprice =[];
GeoAEdelta =[];


for i=1:size(n,2)
    for k=1:size(K,2)
        [ELBprice, ELBdelta] = asianExpectedLowerBound(S0,K(k),sigma,r,T,n(i));
        expected_asian_lower_bound(i,k) = ELBprice;
        expected_asian_lower_bound_delta(i,k) = ELBdelta;
        [GeoAEprice, GeoAEdelta] = geometricAsianExpected(S0,K(k),sigma,r,T,n(i));
        geometric_asian_option_expected(i,k) = GeoAEprice;
        geometric_asian_option_expected_delta(i,k) = GeoAEdelta;
    end
end

%% Question 4 Price as Control Variate
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

%% Question 4 Delta as Control Variate
geo_delta_simulations = [];
lb_delta_simulations = [];
epsilon_delta = [];

for i=1:size(n,2)
   for k = 1:size(K,2)
       dt = T/n(i); 

       [correlcoef_lb_delta, bstarhat_lb_delta,correlcoef_geo_delta, bstarhat_geo_delta] = Delta_CV_Coeff(S0, K(k), sigma, r, T, dt, M);
        
       [lb_std_delta, lb_asian_delta, lb_conf_int_delta,lb_exec_delta_time] = asianMCCtrVarLBDelta(S0, K(k), sigma, r, T, dt, n(i), M, bstarhat_lb_delta, alpha);
       [geo_std_delta, geo_asian_delta, geo_conf_int_delta,geo_exec_delta_time] = asianMCCtrVarGeoDelta(S0, K(k), sigma, r, T, dt, n(i), M, bstarhat_geo_delta, alpha);
        
       lb_delta_simulations(i,k,:) = [lb_std_delta, lb_asian_delta, lb_conf_int_delta];
       geo_delta_simulations(i,k,:) = [geo_std_delta, geo_asian_delta, geo_conf_int_delta];
        
       epsilon_delta(i,k) = (lb_exec_delta_time*lb_std_delta^2)/(geo_exec_delta_time*geo_std_delta^2);
   end
end



%% Question 5
continuous_monitoring = expectationContinuousMonitoring(S0,K(2),sigma,r,T);
for i=1:20
    continuous_monitoring_approx(i) = asianExpectedLowerBound(S0,K(2),sigma,r,T,2^i);
end

plot(1:20,ones(size(1:20))*continuous_monitoring,1:20,continuous_monitoring_approx)