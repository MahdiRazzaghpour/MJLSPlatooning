clear all
close all
clc
addpath('./examples/')
%% Example from MJLS notes: Unstable+Unstable=Stable
% Eaxmple 1: scalaer not MSS
% Example 2: scalar MSS
% Example 3: Unstable+Unstable=Stable  
% Example 4: Stable+Stable=Unstable
% Example 5: Network Stabilization with an informed agent
% Example 8: Mass spring damper system with random spring stiffness

MJLS=example_8();


eig1=eig(MJLS.As{1});
eig2=eig(MJLS.As{2});    
T=MJLS.T;
x_ic=MJLS.x_ic;
p_ic=MJLS.p_ic;
nx=MJLS.nx;

steps=200;
samples=200;
%% Propogate probabilities and plot
x=zeros(MJLS.nx*samples,steps);
x(:,1)=kron(ones(samples,1),x_ic);
p=zeros(MJLS.N,steps);
p(:,1)=p_ic;
for i=2:steps
    p(:,i)=T*p(:,i-1);
    for j=1:samples           
        % Pick the A matrix with correct probability
        rand_no=rand(); 
        id=find(rand_no<cumsum(p(:,i-1)),1);
        A=MJLS.As{id};        
        
        % Update states with respect to the A matrix        
        x(nx*(j-1)+1:nx*j,i)=A*x(nx*(j-1)+1:nx*j,i-1);
    end 
end
%% Plots ensemble trajectories
for i=1:samples    
    for subplots=1:nx
        subplot(nx,1,subplots)
        plot(1:steps,x(nx*(i-1)+subplots,:))
        xlabel('time')
        ylabel(['x',int2str(subplots)])
        hold on
    end
end
%% Plot sample mean and covariances for scalar examples
if nx==1
    x_mean=(1/samples)*ones(1,samples)*x;
    x_var=(1/samples)*ones(1,samples)*x.^2;
    x_ub=x_mean+x_var.^(0.5);
    x_lb=x_mean-x_var.^(0.5);
    figure()
    plot(1:steps,x_mean)
    hold on
    pause
    plot(1:steps,x_ub)
    plot(1:steps,x_lb)
    legend('mean(x)','mean(x)+std_dev','mean(x)-std_dev')
end