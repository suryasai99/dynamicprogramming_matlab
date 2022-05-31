
function [x, u, gt, C_P] = DP_WHSE_singlerun(U,x0)


%% Parameters and initialization

% Load the parameters defined in file DP_WHSE_setup.m:
[N,T,k,S,P_new,R,P]=DP_WHSE_setup();

% state
x=zeros(1,T);

% stage cost
gt = zeros(1,T-1);

% input 
u = zeros(1,T-1);


%% Main loop 

% Initial state 
x(1) = x0;
C_P=zeros(1,T-1);

for t=1:T-1 
  u(t) = U(x(t),t);
  if u(t)==11
      x(t+1)=x(t);
      gt(t)=0;
  else
     client_price=randsample([1:k],1,true,P);
     C_P(t)=client_price;
     if client_price>=u(t)
         x(t+1)=x(t)-1;
         gt(t)=R(u(t));
     else
         x(t+1)=x(t);
         gt(t)=0;
         
     end
  end
  if x(t+1)==1 % if state reaches 1 at any time instant then break
      break
  end
  
  
  
      
      
      
end
gt(t)=gt(t)+(x(t)-2)*S;
end



