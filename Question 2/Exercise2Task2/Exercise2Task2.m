% set the paramaters
S0=100;r=0.05;sigma=0.1;
K1=100;K2=105;K3=110;
T=2;
%pre-define vector before loop
LBprice1=zeros(1,14);LBstd1=zeros(1,14);LBConfInt1=zeros(1,28);% Discrete Price, Standar deviation and confidence interval for K=100
LBprice2=zeros(1,14);LBstd2=zeros(1,14);LBConfInt2=zeros(1,28);% Discrete Price, Standar deviation and confidence interval for K=105
LBprice3=zeros(1,14);LBstd3=zeros(1,14);LBConfInt3=zeros(1,28);% Discrete Price, Standar deviation and confidence interval for K=110
VLBC1=zeros(1,14);VLBC2=zeros(1,14);VLBC3=zeros(1,14); % continuous price 
Exactime2_1=zeros(1,14);Exactime2_2=zeros(1,14);Exactime2_3=zeros(1,14); % CPU time 
for i =2:1:15
    % K1=100
    tic
    [LBCstd1,LBCPrice1,LBCConfInt1]=Flbc(T,S0,K1,sigma,r,2^i,0.95); %Flbc is the function for calculating the discrete price for LB
    LBprice1(i-1)=LBCPrice1; % save discrete  price in array 
    LBstd1(i-1)=LBCstd1;% save std in array
    LBConfInt1(i-1)=LBCConfInt1(1);% save confidence interval in array
    LBConfInt1(i)=LBCConfInt1(2);
    Exactime2_1(i-1)=toc; % save time in array
    VLBC1(i-1)=Flccon(T,S0,K1,sigma,r); % save continuous price in array
    % K2=105
    tic
    [LBCstd2,LBCPrice2,LBCConfInt2]=Flbc(T,S0,K2,sigma,r,2^i,0.95);
    LBprice2(i-1)=LBCPrice2;
    LBstd2(i-1)=LBCstd2;
    LBConfInt2(i-1)=LBCConfInt2(1);
    LBConfInt2(i)=LBCConfInt2(2);
    Exactime2_2(i-1)=toc;
    VLBC2(i-1)=Flccon(T,S0,K2,sigma,r);
    %K3=110
    tic
    [LBCstd3,LBCPrice3,LBCConfInt3]=Flbc(T,S0,K3,sigma,r,2^i,0.95);
    LBprice3(i-1)=LBCPrice3;
    LBstd3(i-1)=LBCstd3;
    LBConfInt3(i-1)=LBCConfInt3(1);
    LBConfInt3(i)=LBCConfInt3(2);
    Exactime2_3(i-1)=toc;
    VLBC3(i-1)=Flccon(T,S0,K3,sigma,r);
    i % show the power of 2 in every loop 
    % show the result in table 
    table([LBCPrice1;LBCPrice2;LBCPrice3],[LBCstd1;LBCstd2;LBCstd3],[LBCConfInt1;LBCConfInt2;LBCConfInt3],[VLBC1(i-1);VLBC2(i-1);VLBC3(i-1)],[VLBC1(i-1)-LBCPrice1;VLBC2(i-1)-LBCPrice2;VLBC3(i-1)-LBCPrice3],[Exactime2_1(i-1);Exactime2_2(i-1);Exactime2_3(i-1)],'VariableNames',{'DiscretePrice','Std','ConfidenceInterval','ContinuousPrice','Difference','CPUTime'},'RowNames',{'K1=100','K2=105','K3=110'})
    
end
%Crude Monte Carlo Simulation for n=2^12
tic  % start compute time 
[CrudeLBCstd1,CrudeLBCPrice1,CrudeLBCConfInt1]=CrudeLB(T,S0,K1,sigma,r,2^12,0.95);
exactime1_C=toc;
tic  % start compute time 
[CrudeLBCstd2,CrudeLBCPrice2,CrudeLBCConfInt2]=CrudeLB(T,S0,K2,sigma,r,2^12,0.95);
exactime2_C=toc;
tic
[CrudeLBCstd3,CrudeLBCPrice3,CrudeLBCConfInt3]=CrudeLB(T,S0,K3,sigma,r,2^12,0.95);
exactime3_C=toc;

% print out the result of Crude Monte Carlo Simulation in table  
Table1=table([CrudeLBCPrice1;CrudeLBCPrice2;CrudeLBCPrice3],[CrudeLBCstd1;CrudeLBCstd2;CrudeLBCstd3],[CrudeLBCConfInt1;CrudeLBCConfInt2;CrudeLBCConfInt3],[VLBC1(1);VLBC2(1);VLBC3(1)],[VLBC1(1)-CrudeLBCPrice1;VLBC2(1)-CrudeLBCPrice2;VLBC3(1)-CrudeLBCPrice3],[exactime1_C;exactime2_C;exactime2_C],'VariableNames',{'DiscretePrice','Std','ConfidenceInterval','ContinuousPrice','Difference','CPUTime'},'RowNames',{'K1=100','K2=105','K3=110'})

%plot the convergence for K=100
plot([2:15],LBprice1,'--');
hold on
plot([2:15],VLBC1);
title('Look Back Option Price:K=100');
xlabel('Power of 2');
ylabel('Option Price')
legend('Discrete Price','Continuous Price:16.856213','Location','southeast')

%plot the convergence for K=105
figure
plot([2:15],LBprice2,'--');
hold on
plot([2:15],VLBC2);
title('Look Back Option Price:K=105');
xlabel('Power of 2');
ylabel('Option Price')
legend('Discrete Price','Continuous Price:12.617208','Location','southeast')

%plot the convergence for K=110
figure
plot([2:15],LBprice3,'--');
hold on
plot([2:15],VLBC3);
title('Look Back Option Price:K=110');
xlabel('Power of 2');
ylabel('Option Price')
legend('Discrete Price','Continuous Price:9.044172','Location','southeast')