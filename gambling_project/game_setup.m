function [x,l_x,T,p,w,C,inp,init_c]= game_setup()

x = [0:10:200];         % states
l_x = length(x);        % length of states

C = 200;                % Desired capital  
init_c = 100;           % Initial capital

T = 40;                 % Time instants

p = [0.2 0.8];          % probabilities of the game
w = [1 -1];             % uncertainity vector

% Inputs of each state
for i = 1:l_x
    if x(i) == 0 || x(i) == x(l_x)
        inp{i} = 0;
    else
        inp{i}= [x(2):10:min(x(i),C-x(i))];
    end
end


% PP = [1 zeros(1,20);
%       0.8 0 0.2 zeros(1,(l_x-3));
%       0.8 0 0 0 0.2 zeros(1,(l_x-5));
%       0.8 0 0 0 0 0  0.2 zeros(1,(l_x-7));
%       0.8 0 0 0 0 0 0 0 0.2 zeros(1,(l_x-9)); 
%       0.8 0 0 0 0 0 0 0 0 0 0.2 zeros(1,(l_x-11));
%       0.8 0 0 0 0 0 0 0 0 0 0 0 0.2 zeros(1,(l_x-13));
%       0.8 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 zeros(1,(l_x-15));
%       0.8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 zeros(1,(l_x-17));
%       0.8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 zeros(1,(l_x-19));
%       0.8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.2 ;
%       0   0 0.8 zeros(1,(l_x-4)) 0.2 ;
%       0   0  0  0 0.8 zeros(1,(l_x-6)) 0.2 ;
%       0   0  0  0  0  0  0.8 zeros(1,(l_x-8)) 0.2 ;
%       0   0  0  0  0  0  0  0  0.8 zeros(1,(l_x-10)) 0.2 ;
%       0   0  0  0  0  0  0  0  0  0  0.8 zeros(1,(l_x-12)) 0.2 ;
%       0   0  0  0  0  0  0  0  0  0  0  0  0.8 zeros(1,(l_x-14)) 0.2 ;
%       0   0  0  0  0  0  0  0  0  0  0  0   0  0  0.8 zeros(1,(l_x-16)) 0.2 ;
%       0   0  0  0  0  0  0  0  0  0  0  0   0  0  0  0 0.8 zeros(1,(l_x-18)) 0.2 ;
%       0   0  0  0  0  0  0  0  0  0  0  0   0  0  0  0 0  0  0.8 zeros(1,(l_x-20)) 0.2 ;
%       zeros(1,20) 1 ];
% 
% 
% ans = PP^T;