function MJLS=example_9_mahdi_data(TPM_path)
% Create an MJLS system with data from Mahdi
MJLS.N=64;
% Need to create 64 A matrices
MJLS.As={};
MJLS.Bs={};
MJLS.Laps={};
MJLS.dt=0.1;
Kp=3;Kd=5.2; % design stable for L_1 and unstable for L_64
%Kp=10;Kd=4;T=0.1; % design stable for L_64 
n=5;
At=diag(ones(n,1))+diag(ones(n-1,1),1); % Always connected
for i=1:MJLS.N            
    At=update_adjacency(At,i);
    D=diag(At'*ones(n));
    D(1)=2;                             % Leader externally controlled
    Li=diag(D)-At';
    MJLS.Laps{i}=Li;
    [Ai,Bi]=get_AB(Li,Kp,Kd,MJLS.dt);
    MJLS.As{i}=Ai;
    MJLS.Bs{i}=Bi;
end
MJLS.nx=size(Ai,1);
MJLS.x_ic=[((n+1)-(1:n))';0*rand(n,1)];
load(TPM_path,'Transition_Probability');
MJLS.T=Transition_Probability;

% The stationary distribution is stored in the file p_ic.mat.
% p_ic=load('./connectivity_data_mahdi/p_ic.mat');
% MJLS.p_ic=p_ic.pdf;

%Genetare a random initial distribution
p_ic=rand(64,1);
MJLS.p_ic=1/sum(p_ic)*p_ic;

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
function [A,B]=get_AB(L,Kp,Kd,T)
n=size(L,1);
A_11=eye(n)-0.5*Kp*T^2*L;
A_12=T*eye(n)-0.5*Kd*T^2*L;
A_21=-Kp*T*L;
A_22=eye(n)-Kd*T*L;    
A=[A_11,A_12;A_21,A_22];
B=[0.5*T^2*Kp*L;T*Kp*L];
end