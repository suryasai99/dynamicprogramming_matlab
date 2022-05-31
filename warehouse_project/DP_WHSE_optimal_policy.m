
function [U, V] = DP_WHSE_optimal_policy()

%% Compute optimal policy U (over t = 1,...,T-1) 
%  and optimal value function V (for t=1,...,T-1,T)
% 
% U has N_x rows and T-1 columns, U(x,t) is optimal input
% when in state x at time t
%
% V has N_x rows and T columns, V(x,t) is optimal value
% if in state x at time t
%


%% Parameters and initialization

% Load the parameters defined in file DP_WHSE_setup.m:
[N,T,k,S,P_new,R,P]=DP_WHSE_setup();

% state
X_set=[1:N];
N_state = length(X_set);

% Initialization of optimal input and optimal value 
V=zeros(N_state,T);
U=zeros(N_state,T-1);
R_aux=zeros(1,k);



%% DP algorithm

% DP algorithm START

% 1. Initialization(Terminal reward)
for i=1:N
    V(i,T)=S*(i-1);
end

% 2. Main loop
for t=(T-1):-1:1
    for s=1:N_state
        if s==1 % state index where all the products are sold
            U_star=k+1;
            V_star=0;
        else
            for h=1:k % input index

 %             computing the expected value of reward
                R_aux(h) = (P_new(h)*(R(h)+V(s-1,t+1)))+((1-P_new(h))*V(s,t+1));
            end
            [V_star, U_star] = max(R_aux); % selects the optimal input(policy) and value
        end
        U(s,t)=U_star; % optimal input
        V(s,t)=V_star; % optimal value
    end
    
end
end



