function [er]= game_expectedrew(p,w,k,i,j,v_next)

%% stochastic stage reward
esr = p(1)*k-p(2)*k;            %expected stage reward
%esr = 0;
%% computing expected value
ev = 0;

for h = 1:length(w)
    DY = i+(w(h)*j);            % possibility of going to the next state
    ev = ev + p(h)*v_next(DY);
end

er = esr+ev;        % calculating expected reward
