function [uuu,vvv,ln_ppp,ppp]= game_var_prob()

%% parameters
[x,l_x,T,~,w,~,inp,~]= game_setup();

% varying probabilities
ppp = {[0.3 0.7],[0.4 0.6],[0.5 0.5],[0.6 0.4],[0.7 0.3],[0.8 0.2]};
ln_ppp = length(ppp);
%% initialization

uuu = zeros(l_x,T,ln_ppp);   % optimal policy
vvv = zeros(l_x,T+1,ln_ppp); % optimal value function


%% Dp algorithm starts
for s = 1:ln_ppp
    vvv(l_x,T+1,s)=1;

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

                    c_aux(j)=game_expectedrew(ppp{s},w,k(j),i,j,vvv(:,t+1,s));
                end
                [v_star,u_star] = max(c_aux);

            end
            uuu(i,t,s)= k(u_star);      
            vvv(i,t,s)= v_star;

        end 
    end
end