function [REW, REW_h1, REW_h2]=DP_WHSE_plot(x_star_h2,x_star_h1,x_star,gt_star, gt_h1, gt_h2, Nrun, T)



%% TOTAL REVENUE optimal policy

% Total revenue for each run
REW=sum(gt_star,1);

% Sample mean
M1=mean(REW);
SD1=std(REW); % standard deviation

% results and plots
disp(' ')
disp(['Mean value of total revenue for optimal policy is  ' num2str(M1) ])
disp(['standard devation of total revenue for optimal policy is  ' num2str(SD1) ])
disp('-------------------------------------------------------- ')
figure
hold on
histogram(REW,20,'Normalization','pdf','FaceColor','r');
[z_star,edges_star]=histcounts(REW,20,'Normalization','pdf');
plot(M1*[1 1], [0 max(z_star)],'k','LineWidth',2);

legend('Histogram',['Mean value = ' num2str(M1)]);
xlabel('Total Revenue');
ylabel('Probability density');
title(['Optimal policy - Total revenue distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
grid;



%% TOTAL REVENUE Heuristic policy 1

% Total revenue for each run
REW_h1=sum(gt_h1,1);

% Sample mean
M2=mean(REW_h1);
SD2=std(REW_h1); % standard deviation

% results and plots
disp(' ')
disp(['Mean value of total revenue for Heuristic policy 1 is  ' num2str(M2) ])
disp(['standard devation of total revenue for optimal policy 1 is  ' num2str(SD2) ])
disp('-------------------------------------------------------- ')
figure
hold on
histogram(REW_h1,20,'Normalization','pdf','FaceColor','b');
[z_h1,edges_h1]=histcounts(REW_h1,20,'Normalization','pdf');
plot(M2*[1 1], [0 max(z_h1)],'k','LineWidth',2);
legend('Histogram',['Mean value = ' num2str(M2)]);
xlabel('Total Revenue');
ylabel('Probability density');
title(['Heuristic policy 1 - Total revenue distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
grid;



%% TOTAL REVENUE Heuristic policy 2

% Total revenue for each run
REW_h2=sum(gt_h2,1);

% Sample mean
M3=mean(REW_h2);

SD3=std(REW_h2); % standard deviation

% results and plots
disp(' ')
disp(['Mean value of total revenue for Heuristic policy 2 is  ' num2str(M3) ])
disp(['standard devation of total revenue for optimal policy 2 is ' num2str(SD3) ])
disp('-------------------------------------------------------- ')
figure
hold on
histogram(REW_h2,20,'Normalization','pdf','FaceColor','g');
[z_h2,edges_h2]=histcounts(REW_h2,20,'Normalization','pdf');
plot(M3*[1 1], [0 max(z_h2)],'k','LineWidth',2);
legend('Histogram',['Mean value = ' num2str(M3)]);
xlabel('Total Revenue');
ylabel('Probability density');
title(['Heuristic policy 2 - Total revenue distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
grid;



%% Comparison 

figure
hold on

% Compute the center of the bins
bins_star=edges_star(1:end-1)+diff(edges_star);
bins_h1=edges_h1(1:end-1)+diff(edges_h1);
bins_h2=edges_h2(1:end-1)+diff(edges_h2);

bar(bins_h1,z_h1,'b');
bar(bins_h2,z_h2,'g');
bar(bins_star,z_star,'r');
legend('Heuristic 1','Heuristic 2','Optimal')
xlabel('Total Revenue');
ylabel('Probability density');
title(['Total revenue distribution from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
grid;

figure
hold on
[F_star, xi_star] = ecdf(REW);
[F_h1, xi_h1] = ecdf(REW_h1);
[F_h2, xi_h2] = ecdf(REW_h2);
plot(xi_h1,F_h1,'b','LineWidth',2)
plot(xi_h2,F_h2,'g','LineWidth',2)
plot(xi_star,F_star,'r','LineWidth',2)
legend('Heuristic 1','Heuristic 2','Optimal','Location','SouthEast')
xlabel('Total Revenue');
ylabel('Probability distribution');
title(['Empirical CDF from N=' num2str(Nrun) ' simulation runs (T=' num2str(T) ')']);
grid;

figure
hold on
histogram(x_star_h2(100,:),20,'Normalization','pdf','FaceColor','r');

xlabel('Stock at T=100');
ylabel('Probability density');
title('Stock at time T=100 for Heuristic policy 2');
grid;

figure
hold on
histogram(x_star_h1(100,:),20,'Normalization','pdf','FaceColor','r');

xlabel('Stock at T=100');
ylabel('Probability density');
title('Stock at time T=100 for Heuristic policy 1');
grid;

figure
hold on
histogram(x_star(100,:),20,'Normalization','pdf','FaceColor','r');

xlabel('Stock at T=100');
ylabel('Probability density');
title('Stock at time T=100 for optimal policy');
grid;

