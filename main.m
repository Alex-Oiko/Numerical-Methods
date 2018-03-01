S0 = 100; r = 0.04; sigma = 0.3; K = [90 100 110]; T = 1; n = [4 12 50]; M = 1E5; alpha = 0.95;

%% Question 3
expected_asian = asianExpectedLowerBound(S0,r,sigma,K,T,n)
geometric_asian_option = geometricAsianExpectedLowerBound(S0,r,sigma,K,T,n)

continuous_monitoring = expectationContinuousMonitoring(S0,r,sigma,K(2),T)


%% Question 4

[correlcoef_lb,bstarhat_lb,correlcoef_geo,bstarhat_geo] = controlVariantCoefficients(S0,r,sigma,K(2),T,n(2),M);
[MCstd, MCAsianArithPrice, MCConfInt] = asianArithMCCtrlVarGeo(S0,r,sigma,K(2),T,n(2),M,bstarhat_geo,alpha);
[LBMCstd, LBMCAsianArithPrice, LBMCConfInt] = asianArithMCCtrlVarLB(S0,r,sigma,K(2),T,n(2),M,bstarhat_lb,alpha);
AsianPrice = asianGeometricCall(S0, K(2), r, T, n(2), sigma);

%% Question 5
for i=1:20
    continuous_monitoring_approx(i) = expectationContinuousMonitoringApprox(S0,r,sigma,K(2),T,2^i);
end