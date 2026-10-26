clear
clc
%%
load('extreme_laplacians')
%%
%Kp=3;Kd=5.2;T=0.1; % design stable for L_1 and unstable for L_64
Kp=10;Kd=4;T=0.1; % design stable for L_64 
L=L_1;
[A,~]=get_AB(L,Kp,Kd,T);
lambda=eig(A);
max(abs(lambda))
figure()
plot(lambda,'*')
hold on
theta=0:0.1:2*pi;
plot(cos(theta),sin(theta))


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [A,B]=get_AB(L,Kp,Kd,T)
n=size(L,1);
A_11=eye(n)-0.5*Kp*T^2*L;
A_12=T*eye(n)-0.5*Kd*T^2*L;
A_21=-Kp*T*L;
A_22=eye(n)-Kd*T*L;    
A=[A_11,A_12;A_21,A_22];
B=[0.5*T^2*Kp*L;T*Kp*L];
end
