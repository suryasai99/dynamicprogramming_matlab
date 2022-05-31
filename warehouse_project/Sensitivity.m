
function Sensitivity()

disp('The probability varies by changing the value of 0.9 to find probability by different constants')


%% Parameters and initialization

% Load the parameters defined in file DP_WHSE_setup.m:
[N,T,k,S,P_new,R,P]=DP_WHSE_setup();

S_new=[80,600,800,910,930,940,950,960,970,980,990,1000];

X_set=[1:N];
N_state = length(X_set);

figure('units','normalized','outerposition',[0 0 1 1])
for m= 1:length(S_new)
    
    
    S=S_new(m);

% -------------------------------------------------------------------------------------------------------

U=[1:k];
U_aux=zeros(1,k);
R_aux=zeros(1,k);
X_set=[1:N];
N_state = length(X_set);
V=zeros(N_state,T);
U=zeros(N_state,T-1);
for i=1:N
    V(i,T)=S*(i-1);
end
% -----------------------------------------------------------------------------------------------------------
for t=(T-1):-1:1
    for s=1:N_state
        if s==1
            U_star=k+1;
            V_star=0;
        else
            for h=1:k

 %                 Fing the expected value of cost

                R_aux(h) = ((P_new(h)*(R(h)+V(s-1,t+1)))+((1-P_new(h))*V(s,t+1)));
            end
            [V_star, U_star] = max(R_aux);
        end
        U(s,t)=U_star;
        V(s,t)=V_star;
    end
    
end
cmap=[0 0 0; 0 0 1; 0 1 0; 0.75, 0, 0.75; 0.4660, 0.6740, 0.1880; 0.4940, 0.1840, 0.5560;
    0.6350, 0.0780, 0.1840;0.75, 0.75, 0;0.25, 0.25, 0.25;1 0.1 0.1 ];
colormap(cmap)
pcolor(U)

hold on;

h = zeros(3, 1);
h(1) = plot(NaN,NaN,'Color',[1 0.1 0.1]);
h(2) = plot(NaN,NaN,'Color',[0.25, 0.25, 0.25]);
h(3) = plot(NaN,NaN,'Color',[0.75, 0.75, 0]);
h(4) = plot(NaN,NaN,'Color',[0.6350, 0.0780, 0.1840]);
h(5) = plot(NaN,NaN,'Color',[0.4940, 0.1840, 0.5560]);
h(6) = plot(NaN,NaN,'Color',[0.4660, 0.6740, 0.1880]);
h(7) = plot(NaN,NaN,'Color',[0.75, 0, 0.75]);
h(8) = plot(NaN,NaN,'Color',[0 1 0]);
h(9) = plot(NaN,NaN,'Color',[0 0 1]);
h(10) = plot(NaN,NaN,'Color',[0 0 0]);
lgd=legend(h, '1000','990','980', '970','960','950', '940','930','920','910');
title(lgd,'Selling Price')
xlabel('Time peorid');
ylabel('Available stock');
title(['Optimal policy for S=' num2str(S)  ]);


pause(0.5);

end
figure('units','normalized','outerposition',[0 0 1 1])
k=10;
C=0;
a=[0.3,0.7,0.9,1.0,1.2,2,5,10];
[N,T,k,S,P_new,R,P]=DP_WHSE_setup();

for m=1:length(a)
 for i=1:k
    C=C+ a(m)^i;
 end
 
for i=1:k
    P(1,i)=(a(m)^i)/C;
end
P_new(1,1)=1;
for i=1:(k-1)
    new=1;
    for j=1:i
        new=new-P(j);
    end
    P_new(1,i+1)=new;
end




% -------------------------------------------------------------------------------------------------------

U=[1:k];
U_aux=zeros(1,k);
R_aux=zeros(1,k);
X_set=[1:N];
N_state = length(X_set);
V=zeros(N_state,T);
U=zeros(N_state,T-1);
for i=1:N
    V(i,T)=S*(i-1);
end
% -----------------------------------------------------------------------------------------------------------
for t=(T-1):-1:1
    for s=1:N_state
        if s==1
            U_star=k+1;
            V_star=0;
        else
            for h=1:k

 %                 Fing the expected value of cost

                R_aux(h) = ((P_new(h)*(R(h)+V(s-1,t+1)))+((1-P_new(h))*V(s,t+1)));
            end
            [V_star, U_star] = max(R_aux);
        end
        U(s,t)=U_star;
        V(s,t)=V_star;
    end
    
end
cmap=[0 0 0; 0 0 1; 0 1 0; 0.75, 0, 0.75; 0.4660, 0.6740, 0.1880; 0.4940, 0.1840, 0.5560;
    0.6350, 0.0780, 0.1840;0.75, 0.75, 0;0.25, 0.25, 0.25;1 0.1 0.1 ];
colormap(cmap)
pcolor(U)

hold on;

h = zeros(3, 1);
h(1) = plot(NaN,NaN,'Color',[1 0.1 0.1]);
h(2) = plot(NaN,NaN,'Color',[0.25, 0.25, 0.25]);
h(3) = plot(NaN,NaN,'Color',[0.75, 0.75, 0]);
h(4) = plot(NaN,NaN,'Color',[0.6350, 0.0780, 0.1840]);
h(5) = plot(NaN,NaN,'Color',[0.4940, 0.1840, 0.5560]);
h(6) = plot(NaN,NaN,'Color',[0.4660, 0.6740, 0.1880]);
h(7) = plot(NaN,NaN,'Color',[0.75, 0, 0.75]);
h(8) = plot(NaN,NaN,'Color',[0 1 0]);
h(9) = plot(NaN,NaN,'Color',[0 0 1]);
h(10) = plot(NaN,NaN,'Color',[0 0 0]);
lgd=legend(h, '1000','990','980', '970','960','950', '940','930','920','910');

title(lgd,'Selling Price')
xlabel('Time period');
ylabel('Available stock');
title(['Optimal policy for different probability, Constant=' num2str(a(m))  ]);


pause(0.5);

end



    
