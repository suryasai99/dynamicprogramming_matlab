function [N,T,k,S,P_new,R,P]=DP_WHSE_setup()



%% Model parameters and initialization

% Total Number of states
% As I considered No. of products from 0 to 100. i.e [1:101] 
% state 101 represents 100 products in the warehouse
% state 1 represents all products are sold (0 products)
N=101;  

% Number of Time instants(0 to 200) i.e [1:201]
T=201;

k=10; % price index

S=80; % cost of a product which are unsold at the final time instant

% Vector to store values of Reserve price (Initialization)
R=zeros(1,k);

% Vector to store values of probabilities of the client's reserve price (Initialization)
P=zeros(1,k);

% Initialization of the probabilities which represents with the probability 
% p_new it goes to the next state and with (1-p_new) it remains in the 
% current state
P_new=zeros(1,k);


%% computing values 

% Computing Reserve price(input)
for i=1:k
    R(1,i)=900+(10*i);
end

% ------------------------
C=0;
 for i=1:k
    C=C+ 0.9^i;
 end

% Computing Probabilities of the client's reserve price
for i=1:k
    P(1,i)=(0.9^i)/C;
end

% computing p_new
P_new(1,1)=1;
for i=1:(k-1)
    ini=1;
    for j=1:i
        ini=ini-P(j);
    end
    P_new(1,i+1)=ini;
end