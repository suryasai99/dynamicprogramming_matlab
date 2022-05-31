function [X,U_inp,gt] = game_singlerun(x,l_x,T,x0,U,R)

%% Initializations
X = zeros(1,T+1);
U_inp= zeros(1,T);
gt = zeros(1,T);

% inital value
X(1) = x0;

% single run
for t = 1:T
    n = find(x==X(t));
    U_inp(t)= U(n,t);
    if X(t) == x(1) || X(t)==x(l_x)
        X(t+1)=X(t);
        gt(t)= 0 ;
    else
        X(t+1)= X(t)+(U_inp(t)*R(t));
        gt(t)= U_inp(t)*R(t) ;
    end
end


