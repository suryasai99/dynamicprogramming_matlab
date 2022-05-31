%% MOnte carlo main
% clear all;
close all;
clc;

%% importing parameters and optimal policy
[x,l_x,T,p,w,C,inp,init_c]= game_setup();
[U,v]= game_optimal();      % optimal policy

N_run = 1e4;                % No. of simulations
%% optimal policy with varying probabilities
[uuu,vvv,ln_ppp,ppp]= game_var_prob();

%% initializations 
RR = zeros(N_run,T);
RR_v = zeros(N_run,T,ln_ppp);

XX = zeros(N_run,T+1);
UU_inp = zeros(N_run,T);
gt_rew = zeros(N_run,T);

XX_huer1= zeros(N_run,T+1);
UU_huer1 = zeros(N_run,T);
gt_rew_huer1 = zeros(N_run,T);

XX_huer2= zeros(N_run,T+1);
UU_huer2 = zeros(N_run,T);
gt_rew_huer2 = zeros(N_run,T);

XX_var = zeros(N_run,T+1,ln_ppp);
UU_inp_var = zeros(N_run,T,ln_ppp);
gt_rew_var = zeros(N_run,T,ln_ppp);

x0 = init_c;  % initial capital


%%  generating random samples
for e = 1:N_run
    for t = 1:T
        RR(e,t) = randsample(w,1,true,p);  % generating random samples
    end
end

% ramdom samples for varying probabilities
for m = 1:ln_ppp
    for e = 1:N_run
        for t = 1:T
            RR_v(e,t,m) = randsample(w,1,true,ppp{m});  % generating random samples
        end
    end
end
%% Monte carlo simulation of optimal,hueristic policy
for e = 1:N_run

    [XX(e,:),UU_inp(e,:),gt_rew(e,:)] = game_singlerun(x,l_x,T,x0,U,RR(e,:));  % By using optimal policy

    [XX_huer1(e,:),UU_huer1(e,:),gt_rew_huer1(e,:)] = game_Hueristic1(x,l_x,T,x0,RR(e,:));  % using hueristic policy1
    

    [XX_huer2(e,:),UU_huer2(e,:),gt_rew_huer2(e,:)] = game_Hueristic2(x0,RR(e,:));   % using hueristic policy2      


end


% Monte carlo simulation for varying probabilities

for m = 1:ln_ppp
    for e = 1:N_run
        [XX_var(e,:,m),UU_inp_var(e,:,m),gt_rew_var(e,:,m)] = game_singlerun(x,l_x,T,x0,uuu(:,:,m),RR_v(e,:,m));  % By using optimal varying policy
    end
end


%% To calculate probability of winning in optimal,hueristic 1&2

win = 0;win_huer1 = 0;win_huer2 = 0;


for i = 1:N_run
    if XX(i,T+1)==C
        win = win +1;
    end
end

for i = 1:N_run
    if XX_huer1(i,T+1)==C
        win_huer1 = win_huer1 +1;
    end
end

for i = 1:N_run
    if XX_huer2(i,T+1)==C
        win_huer2 = win_huer2 +1;
    end
end

p_win = win/N_run; p_win_huer1 = win_huer1/N_run; p_win_huer2 = win_huer2/N_run;

% calculation of probability of winning in case of varying probabilities

win_var = zeros(1,ln_ppp);
p_win_var = zeros(1,ln_ppp);
for j = 1:ln_ppp
    for i = 1:N_run
        if XX_var(i,T+1,j)==C
            win_var(1,j) = win_var(1,j) +1;
        end
    end
    p_win_var(1,j)= win_var(1,j)/N_run;
end



%% probability to reach desired capital
[op,PR]= game_prob();

%% Calculation of mean of the capital at the end of the time instant

mean_JJ = mean(XX(:,T+1));
st_jj = std(XX(:,T+1));

mean_h1 = mean(XX_huer1(:,T+1));
st_h1 = std(XX_huer1(:,T+1));

mean_h2 = mean(XX_huer2(:,T+1));
st_h2 = std(XX_huer2(:,T+1));

% mean for varying probabilities at the end of the time instant
mean_vary = zeros(1,ln_ppp);
for i = 1:ln_ppp
    mean_vary(1,i) = mean(XX_var(:,T+1,i));
end
%%%%%%%%%%%%%%%%%%%% 
%% plots

% plot of optimal policy
figure(1)
xindex=[0.5:T+0.5];
yindex=[0.5:l_x+0.5];
U_augmented = [ [U zeros(l_x,1)]; zeros(1,T+1) ];
pcolor(xindex,yindex,U_augmented);
xlabel('Time');
ylabel('To bet(state)');
title('Optimal policy');
colorbar;
colormap(jet);

% plot of probabilities to reach desired capital
figure(2)
xindex=[0.5:T+1+0.5];
yindex=[0.5:l_x+0.5];
PR_augmented = [ [PR zeros(l_x,1)]; zeros(1,T+2) ];
pcolor(xindex,yindex,PR_augmented);
xlabel('Time');
ylabel('probabilities)');
title('PROBABILITIES TO REACH DESIRED CAPITAL');
colorbar;
a = [[0 0.4470 0.7410];[0.9290 0.6940 0.1250];[0.8500 0.3250 0.0980];[0.4660 0.6740 0.1880];[0.4940 0.1840 0.5560];
    [0.3010 0.7450 0.9330];[0.6350 0.0780 0.1840];[1 1 0];[0 1 1];	[0 1 0]];
colormap("default");

% calculation of pdf at the end of the game
figure(3)
subplot(2,2,1)
hold on
histogram(XX(:,T+1),20,"FaceColor",[0.4660 0.6740 0.1880],"Normalization","pdf")
[z,edges] = histcounts(XX(:,T+1),20,"Normalization","pdf");
plot(mean_JJ*[1 1],[0,max(z)],'LineWidth',2,'Color','r')
xlabel('CAPITAL')
ylabel('PROBABILITY')
title('PDF OF DESIRED CAPITAL WITH OPTIMAL POLICY')
legend('Histogram',['Mean value = ' num2str(mean_JJ)]);

subplot(2,2,2)
hold on
histogram(XX_huer1(:,T+1),20,"FaceColor",'m',"Normalization","pdf")
[z,edges] = histcounts(XX_huer1(:,T+1),20,"Normalization","pdf");
plot(mean_h1*[1 1],[0,max(z)],'LineWidth',2,'Color','g')
xlabel('CAPITAL')
ylabel('PROBABILITY')
title('PDF OF DESIRED CAPITAL WITH HUERISTIC POLICY 1')
legend('Histogram',['Mean value = ' num2str(mean_h1)]);

subplot(2,2,3)
hold on
histogram(XX_huer2(:,T+1),20,"FaceColor",[0.6350 0.0780 0.1840],"Normalization","pdf")
[z,edges] = histcounts(XX_huer2(:,T+1),20,"Normalization","pdf");
plot(mean_h2*[1 1],[0,max(z)],'LineWidth',2,'Color','b')
xlabel('CAPITAL')
ylabel('PROBABILITY')
title('PDF OF DESIRED CAPITAL WITH HUERISTIC POLICY 2')
legend('Histogram',['Mean value = ' num2str(mean_h2)]);

% plotting of optimal policy with varying probabilities
figure(4)
for i = 1:ln_ppp
    gk = ppp{i};
    subplot(2,3,i)
    xindex=[0.5:T+0.5];
    yindex=[0.5:l_x+0.5];
    U_augmented = [ [uuu(:,:,i) zeros(l_x,1)]; zeros(1,T+1) ];
    pcolor(xindex,yindex,U_augmented);
    xlabel('Time');
    ylabel('To bet(state)');
    title(['Optimal policy when probabilities are ' num2str(gk)]);
    colorbar;
    colormap(a);
end

figure(5)
for i = 1:ln_ppp
    g_k = ppp{i};
    subplot(2,3,i)
    hold on
    histogram(XX_var(:,T+1,i),20,"FaceColor",[0.3010 0.7450 0.9330],"Normalization","pdf")
    [z,edges] = histcounts(XX_var(:,T+1,i),20,"Normalization","pdf");
    plot(mean_vary(i)*[1 1],[0,max(z)],'LineWidth',2,'Color','r')
    xlabel('CAPITAL')
    ylabel('PROBABILITY')
    title(['PDF OF DESIRED CAPITAL IN CASE OF PROBABILITIES ' num2str(g_k)]);
    legend('Histogram',['Mean value = ' num2str(mean_vary(i))]);
end

%% results
disp(['Time horizon =' num2str(T)]);
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp(['probability of winning with optimal policy = ' num2str(p_win)]);
disp(['probability of winning with Hueristic policy1 = ' num2str(p_win_huer1)]);
disp(['probability of winning with Hueristic policy2 = ' num2str(p_win_huer2)]);
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
for i = 1:ln_ppp
    disp(['probability of winning in case of probability ' num2str(ppp{i}) 'is = ' num2str(p_win_var(i))]);

end

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
for i = 1:l_x
    disp(['if our initial capital is '  num2str(x(i)) ' probability to reach the desired capital is '  num2str(PR(i,1)) ]);
    
end







