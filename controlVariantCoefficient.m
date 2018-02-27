function [coefficient] = controlVariantCoefficient(S0,r,sigma,K,T,M)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
RS = randn(1,M);
mewS = (r-sigma^2/2)*T;
ST = S0*epx(mewS + sigma*RS);
A
end

