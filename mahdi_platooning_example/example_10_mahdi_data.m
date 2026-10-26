function MJLS=example_10_mahdi_data()
% Create an MJLS system with data from Mahdi
MJLS.N=64;

% Need to create 64 A matrices
MJLS.As={};
Kp=1;
T=0.1;
n=5;
At=diag(ones(n,1))+diag(ones(n-1,1),1); % Always connected
for i=1:MJLS.N            
    At=update_adjacency(At,i);
    D=diag(At'*ones(n));
    D(1)=2;                             % Leader externally controlled
    Li=diag(D)-At';
    A_11=eye(n)-0.5*Kp*T^2*Li;
    A_12=T*eye(n)-0.5*Kd*T^2*Li;
    A_21=-Kp*T*Li;
    A_22=eye(n)-Kd*T*Li;    
    Ai=[A_11,A_12;A_21,A_22];
    MJLS.As{i}=Ai;
end
MJLS.nx=size(Ai,1);
MJLS.x_ic=rand(2*n,1);
load('./examples/example_9_connectivity_data_mahdi/Transition_Probability.mat');
MJLS.T=Transition_Probability;
p_ic=load('./examples/example_9_connectivity_data_mahdi/p_ic.mat');
MJLS.p_ic=p_ic.pdf;
end
function At=update_adjacency(At,i)
    vec=dec2bin(i-1,6);
    At(1,3)=bin2dec(vec(1));
    At(1,4)=bin2dec(vec(2));
    At(1,5)=bin2dec(vec(3));
    At(2,4)=bin2dec(vec(4));
    At(2,5)=bin2dec(vec(5));
    At(3,5)=bin2dec(vec(6));
end