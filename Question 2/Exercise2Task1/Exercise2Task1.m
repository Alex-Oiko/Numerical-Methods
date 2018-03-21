% Set parameters
S0=110;r=0.05;sigma=0.1;K=100;
U1=160;U2=170;
M=1E6;T=2;
%pre-allocating arrays before for loops
UOCprice1_1=zeros(1,14);UOCstd1_1=zeros(1,14);UOCConfInt1_1=zeros(1,28);% Discrete Price, Standar deviation and confidence interval for U1=160
UOCprice1_2=zeros(1,14);UOCstd1_2=zeros(1,14);UOCConfInt1_2=zeros(1,28);% Discrete Price, Standar deviation and confidence interval for U2=170
VUOC1=zeros(1,14);VUOC2=zeros(1,14); %Continuous price for UOC
Exactime1_1=zeros(1,14);Exactime1_2=zeros(1,14);% CPU time 
for i=2:1:15
    %U1=160
    tic % start computing time: U1=160
    [UOCstd1,UOCPrice1,UOCConfInt1]=Fuoc(T,S0,K,U1,sigma,r,2^i,0.95);% Fuoc is the function for calculating the discrete price of UOC
    UOCprice1_1(i-1)=UOCPrice1; % save discrete  price in array 
    UOCstd1_1(i-1)=UOCstd1; % save std in array
    UOCConfInt1_1(i-1)=UOCConfInt1(1);% save confidence interval in array
    UOCConfInt1_1(i)=UOCConfInt1(2);
    Exactime1_1(i-1)=toc; % save time in array
    VUOC1(i-1)=Fuocon(T,S0,K,U1,sigma,r); % save continuous price in array
    
    %U2=170
    tic % start computing time: U2=170
    [UOCstd2,UOCPrice2,UOCConfInt2]=Fuoc(T,S0,K,U2,sigma,r,2^i,0.95);
    UOCprice1_2(i-1)=UOCPrice2; % save discrete price in array 
    UOCstd1_2(i-1)=UOCstd2; % save std in array
    UOCConfInt1_2(i-1)=UOCConfInt2(1); % save confidence interval in array
    UOCConfInt1_2(i)=UOCConfInt2(2); 
    Exactime1_2(i-1)=toc; %save time in array 
    VUOC2(i-1)=Fuocon(T,S0,K,U2,sigma,r); % save continuous price in array 
    i % show the power of 2 in every loop 
    % use table to show the result in every loop
    table([UOCPrice1;UOCPrice2],[UOCstd1;UOCstd2],[UOCConfInt1;UOCConfInt2],[VUOC1(i-1);VUOC2(i-1)],[VUOC1(i-1)-UOCPrice1;VUOC2(i-1)-UOCPrice2],[Exactime1_1(i-1);Exactime1_2(i-1)],'VariableNames',{'DiscretePrice','Std','ConfidenceInterval','ContinuousPrice','Difference','CPUTime'},'RowNames',{'U1=160','U2=170'})
end
% Crude Monte Carlo Simulation 
tic % start computing time: U1=160
[CrudeUOCstd1,CrudeUOCPrice1,CrudeUOCConfInt1]=CrudeUOC(T,S0,K,U1,sigma,r,2^12,0.95); % CrudeUOC is a function for 
exactime1_U=toc;
tic% start computing time: U2=170
[CrudeUOCstd2,CrudeUOCPrice2,CrudeUOCConfInt2]=CrudeUOC(T,S0,K,U2,sigma,r,2^12,0.95);
exactime2_U=toc;
% print the result of Crude Monte Carlo simulation in table
table([CrudeUOCPrice1;CrudeUOCPrice2],[CrudeUOCstd1;CrudeUOCstd2],[CrudeUOCConfInt1;CrudeUOCConfInt2],[VUOC1(1);VUOC2(2)],[VUOC1(1)-CrudeUOCPrice1;VUOC2(2)-CrudeUOCPrice2],[exactime1_U;exactime2_U],'VariableNames',{'DiscretePrice','Std','ConfidenceInterval','ContinuousPrice','Difference','CPUTime'},'RowNames',{'U1=160','U2=170'})

%plot the convergence for U1=160
plot([2:15],UOCrice1_1,'--');
hold on
plot([2:15],VUOC1);
title('Up-and-Out Call Option Price:U=160');
xlabel('Power of 2');
ylabel('Option Price')
legend('Discrete Price','Continuous Price:17.954235')
%plot the convergence for U2=170
figure
plot([2:15],UOCrice1_2,'--');
hold on
plot([2:15],VUOC2);
title('Up-and-Out Call Option Price:U=170');
xlabel('Power of 2');
ylabel('Option Price')
legend('Discrete Price','Continuous Price:19.238933')