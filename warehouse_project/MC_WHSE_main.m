% SURYA SAI KADALI-077240

%% Montecarlo simulation
close all;
clear all;
clc;

%% Parameters

% Load the parameters defined in file DP_WHSE_setup.m:
[N,T,k,S,P_new,R,P]=DP_WHSE_setup();
% Load the parameters defined in file DP_WHSE_optimal_policy.m:
[U_optimal,V]=DP_WHSE_optimal_policy();

% Number of simulation runs
Nrun=8000;

%% Initialization

% Inizialize matrices to store results of simulation runs
x_star=zeros(T,Nrun);
u_star=zeros(T-1,Nrun);
gt_star=zeros(T-1,Nrun);
w_star=zeros(T-1,Nrun);

x_star_h2=zeros(T,Nrun);
u_star_h2=zeros(T-1,Nrun);
gt_star_h2=zeros(T-1,Nrun);
w_star_h2=zeros(T-1,Nrun);

x_star_h1=zeros(T,Nrun);
u_star_h1=zeros(T-1,Nrun);
gt_star_h1=zeros(T-1,Nrun);
w_star_h1=zeros(T-1,Nrun);

disp('Monte carlo simulations began...')



%% Computing Optimal, Heuristic 1, Heuristic 2 for Nrun simulations


for m=1:Nrun
  % Optimal policy
  [x_star(:,m), u_star(:,m), gt_star(:,m), w_star(:,m)] = DP_WHSE_singlerun(U_optimal,N); 
  % Heuristic policy 1
  [x_star_h1(:,m), u_star_h1(:,m), gt_star_h1(:,m), w_star_h1(:,m)] =singlerun_heur_1(U_optimal,N);
  % Heuristic policy 2
  [x_star_h2(:,m), u_star_h2(:,m), gt_star_h2(:,m), w_star_h2(:,m)] =singlerun_heur_2(U_optimal,N);
  
  
end


%% Plot and write results 

[REW, REW_h1, REW_h2]=DP_WHSE_plot(x_star_h2,x_star_h1,x_star,gt_star, gt_star_h1, gt_star_h2, Nrun, T);

cmap=[1 0.1 0.1; 0 0 1; 0 1 0; 0.75, 0, 0.75; 0.4660, 0.6740, 0.1880; 0.4940, 0.1840, 0.5560;
    0.6350, 0.0780, 0.1840;0.75, 0.75, 0;0.25, 0.25, 0.25;0, 0, 0 ];


figure
colormap(cmap)
pcolor(U_optimal)
hold on;

h = zeros(3, 1);
h(1) = plot(NaN,NaN,'Color',[0,0,0]);
h(2) = plot(NaN,NaN,'Color',[0.25, 0.25, 0.25]);
h(3) = plot(NaN,NaN,'Color',[0.75, 0.75, 0]);
h(4) = plot(NaN,NaN,'Color',[0.6350, 0.0780, 0.1840]);
h(5) = plot(NaN,NaN,'Color',[0.4940, 0.1840, 0.5560]);
h(6) = plot(NaN,NaN,'Color',[0.4660, 0.6740, 0.1880]);
h(7) = plot(NaN,NaN,'Color',[0.75, 0, 0.75]);
h(8) = plot(NaN,NaN,'Color',[0 1 0]);
h(9) = plot(NaN,NaN,'Color',[0 0 1]);
h(10) = plot(NaN,NaN,'Color',[1 0.1 0.1]);
lgd=legend(h, '1000','990','980', '970','960','950', '940','930','920','910');
title(lgd,'Selling Price')
xlabel('Time peorid');
ylabel('Available stock');
title(['Optimal Policy' ]);


disp('-------------------------------------------------------- ')
disp('Heuristic policy 1')
disp('Here the policy u(t)=5 for all time instance ')
disp('-------------------------------------------------------- ')

disp('Heuristic policy 2')
disp('Here the policy u(t)=4 for all time instance')

disp('-------------------------------------------------------- ')
disp('To view the sensitivity analysis type ''Sensitivity()'' below and press enter key')


% Sensitivity()



