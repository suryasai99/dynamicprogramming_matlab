function [X_huer2,U_huer2,gt_huer2] = game_Hueristic2(x0,R)
[x,l_x,T,p,w,C,inp,init_c]= game_setup();

%% initializations
X_huer2 = zeros(1,T+1);
U_huer2= zeros(1,T);
gt_huer2 = zeros(1,T);

% initial value
X_huer2(1) = x0;

% single run
for t = 1:T
    if X_huer2(t) == x(1) || X_huer2(t)==x(l_x)
        X_huer2(t+1)=X_huer2(t);
        gt_huer2(t)=0;
    elseif X_huer2(t) == x(2)
        U_huer2(t)= x(2);
        X_huer2(t+1)= X_huer2(t)+(U_huer2(t)*R(t)); 
        gt_huer2(t) =  U_huer2(t)*R(t);
    else
        %sy = X_huer2(t)/2;
        if rem(X_huer2(t),20) == 0            
            U_huer2(t)= min(X_huer2(t)/2,C-X_huer2(t)); 
        else
            U_huer2(t)= min((X_huer2(t)/2)+5,C-X_huer2(t));
        end
        X_huer2(t+1)= X_huer2(t)+(U_huer2(t)*R(t));
        gt_huer2(t)=U_huer2(t)*R(t);
    end
end