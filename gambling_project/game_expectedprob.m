function [ep]= game_expectedprob(p,w,~,i,j,v_next)

%% stochastic stage reward
esr = 0;
%% computing expected probability
ev = 0;

for h = 1:length(w)
    DY = i+(w(h)*j);            % possibility of going to the next state
    ev = ev + p(h)*v_next(DY);
end

ep = esr+ev;        % calculating expected reward
