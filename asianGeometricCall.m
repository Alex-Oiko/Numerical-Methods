%%% Computes the precise value of the geomteric Asian Call option

function Gprice = asianGeometricCall(S0, K, r, T, n, sigma)

    Tbar = mean((1:n)*T/n);
    sigmabar = sqrt(sigma^2/(n^2*Tbar)*sum((2*(1:n)-1).*(n:-1:1)*T/n));
    q = (sigma^2-sigmabar^2)/2;
    aux1 = log(S0/K)+(r-q+sigmabar^2/2)*Tbar;
    aux2 = sqrt(sigmabar^2*Tbar);
    d1 = aux1/aux2;
    d2 = d1-aux2;
    Gprice = exp(-r*T)*(S0*exp((r-q)*Tbar)*normcdf(d1)-K*normcdf(d2));
end