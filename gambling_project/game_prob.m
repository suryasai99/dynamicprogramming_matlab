function [op,PR]= game_prob()

%% parameters
[x,l_x,T,p,w,~,inp,~]= game_setup();

%% initialization

op = zeros(l_x,T);   % optimal policy
PR = zeros(l_x,T+1); % optimal value function


%% Dp algorithm starts
PR(l_x,T+1)=1;

for t = T:-1:1                  % for all time instants
    for i = 1:l_x               % for all states
        k = inp{i};
        
        if x(i)== x(l_x)
            u_star = 1;
            v_star = 1;
        elseif x(i) == x(1)
            u_star = 1;
            v_star = 0;
        else
           
            c_aux = zeros(1,length(k));
            for j = 1:length(k)             % for all possibile inputs

                c_aux(j)=game_expectedprob(p,w,k,i,j,PR(:,t+1));
            end
            [v_star,u_star] = max(c_aux);

        end
        op(i,t)= k(u_star);      
        PR(i,t)= v_star;

    end 
end