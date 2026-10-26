clear all
close all
clc
addpath('../lib')
addpath(genpath('./connectivity_data_mahdi'))

% Select data for transition probability matrix
dir1='1500v_withCC';
dir2='200';
distans = 25;
TPM_path=['./connectivity_data_mahdi/MC_probability/',dir1,'/',dir2,'/Transition_Probability.mat']; % First data

% Fixed network:
% Transition_Probability_1 corresponds to the sparsest graph (Line) just+1
% based on sensors whereas Transition_Probability_64 corresponds to all
% links connected at all times
%TPM_path=['./connectivity_data_mahdi/MC_probability/ideal_network/Transition_Probability_1.mat']; 
%TPM_path=['./connectivity_data_mahdi/MC_probability/ideal_network/Transition_Probability_64.mat'];

% This the data that Mahdi shared at first
%TPM_path='./connectivity_data_mahdi/Transition_Probability.mat'; % First data

%% Define the MJLS
dt=0.1; % Sampling time

% Define PD gains
%Kp=1;Kd=10; % good performance for for L_1 and poor performance(unstable) for L_64
%Kp=1;Kd=5; % good performance for for L_64 and poor performance for L_1 
Kp=1;Kd=1;
MJLS=example_mahdi_double_int(TPM_path,Kp,Kd,dt);
%% Analyze the defined MJLS
% System is mean-square stable iff rho_T < 1 
[B_cal,T_cal]=get_B_T_matrices(MJLS);
tic
rho_B=max(abs(eig(B_cal))); % Expectation dynamics
toc
tic
rho_T=max(abs(eig(T_cal))); % Covariance dynamics
toc
%% Analyze probability dynamics via the spectrum of the Transition Probability Matrix
eigs=eig(MJLS.T);
figure
plot(eigs,'o')
title('Spectrum of the transition Matrix')

% Visualize the Transition probability Matrix
figure()
plot_matrix_data(MJLS.T,'Transition Probability Matrix')
title('Transition Probability Matrix')
 
%% Simulate MJLS
% Generate Reference
[ref_leader]=gen_ref_pos_vel(MJLS.dt);
ref=[distans*[5;4;3;2;1]+ref_leader(1,:);ones(5,1)*ref_leader(2,:)];

% Set appropriate initial conditions
MJLS.x_ic=[ref(:,1)];

% Time-stepping
steps=size(ref,2);
samples=1;
[x,p] = Simulate_MJLS(MJLS,steps,samples,ref);
%% Extract positions
N=MJLS.nx/2;
pos=zeros(N,steps,samples);
vel=zeros(N,steps,samples);
acc=zeros(N,steps,samples);
for i=1:samples
    pos(:,:,i)=x(1:N,:,i);
    vel(:,:,i)=x(N+1:end,:,i);
    acc(:,1,i)=zeros(N,1);
    acc(:,2:end,i)=(1/MJLS.dt)*[x(N+1:end,2:end,i)-x(N+1:end,1:(end-1),i)];    
end
%% Plots
plot_ensemble_trajs(pos,samples)
%% Plot states

% Plot Positions
plot_samples=samples;
figure()
for i=1:plot_samples
    for agent=1:N
        plot(1:steps,pos(agent,:,i))
        hold on
    end        
end
title('Positions')

% Plot velocities
figure()
for i=1:plot_samples
    for agent=1:N
        plot(1:steps,vel(agent,:,i))
        hold on
    end        
end
title('Velocities')

% Plot Accelerations
figure()
for i=1:plot_samples
    for agent=1:N
        plot(1:steps,acc(agent,:,i))
        hold on
    end        
end
title('Accelerations')
%% Plot probabilities
figure()
for i=1:steps
    if i==steps
        plot(1:MJLS.N,p(:,i),'o')
    else
        plot(1:MJLS.N,p(:,i))
    end
    hold on
    %pause
end
title('Dynamics of probability distributions')
%% Open figures for ideal communication with fixed laplacian L_64
% openfig('ideal_communication_positions')
% openfig('ideal_communication_velocities')
% openfig('ideal_communication_accelerations')

save('acc.mat','acc');
save('vel.mat','vel');
save('pos.mat','pos');
