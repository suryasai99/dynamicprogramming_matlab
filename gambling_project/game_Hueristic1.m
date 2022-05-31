function [X_huer1,U_huer1,gt_huer1] = game_Hueristic1(x,l_x,T,x0,R)
%% Initializations
X_huer1 = zeros(1,T+1);
U_huer1= zeros(1,T);
gt_huer1= zeros(1,T);

% initial value
X_huer1(1) = x0;

% single run
for t = 1:T
    if X_huer1(t) == x(1) || X_huer1(t)==x(l_x)
        X_huer1(t+1)=X_huer1(t);
        gt_huer1(t) =  0;
    else
        U_huer1(t)= x(2); % using minimum bet 
        X_huer1(t+1)= X_huer1(t)+(U_huer1(t)*R(t));
        gt_huer1(t) = U_huer1(t)*R(t);
    end
end


