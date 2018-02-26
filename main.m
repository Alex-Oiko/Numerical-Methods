S0 = 100; r = 0.04; sigma = 0.3; K = [90 100 110]; T = 1; n = [4 12 50];

%% Question 3
expected_asian = asianExpectedLowerBound(S0,r,sigma,K,T,n)
geometric_asian_option = geometricAsianExpectedLowerBound(S0,r,sigma,K,T,n)

continuous_monitoring = expectationContinuousMonitoring(S0,r,sigma,K(2),T)


%% Question 5
for i=1:20
    continuous_monitoring_approx(i) = expectationContinuousMonitoringApprox(S0,r,sigma,K(2),T,2^i);
end

