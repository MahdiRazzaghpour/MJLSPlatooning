clear all
close all
clc
addpath('../lib')
addpath(genpath('./connectivity_data_mahdi'))
dir1='2458.CC';% 888.Base
dir2='300-400';

%TPM_path='./connectivity_data_mahdi/Transition_Probability.mat'; % First data
TPM_path=['./connectivity_data_mahdi/MC_probability/',dir1,'/',dir2,'/Transition_Probability.mat']; % First data
%% Define the MJLS
MJLS=example_single_integrator_mahdi_data(TPM_path);  
% p_ic happens to be the stationary distribution
%% Analyze the defined MJLS
[B_cal,T_cal]=get_B_T_matrices(MJLS);
tic
rho_B=max(abs(eig(B_cal)));
toc
tic
rho_T=max(abs(eig(T_cal)));
toc
%% Analyze probability dynamics
eigs=eig(MJLS.T);
figure
plot(eigs,'o')
title('Spectrum of the transition Matrix')
%% Simulate MJLS
samples=100;
steps=30;
ref=[5;4;3;2;1]*ones(1,steps)+1;
%ref=ones(5,1)*ones(1,steps);
[x,p] = Simulate_MJLS(MJLS,steps,samples,ref);
%% Plots
plot_ensemble_trajs(x,samples)
%% Plot positions
plot_samples=samples;
% Plot velocities
figure()
for i=1:plot_samples
    for agent=1:MJLS.nx
        plot(1:steps,x(agent,:,i))
        hold on
    end        
end
xlabel('time')
ylabel('velocity')
title('Velocities')
%% Plot probabilities
figure()
for i=1:steps
    if i==steps
        plot(1:MJLS.N,p(:,i),'o')
    else
        plot(1:MJLS.N,p(:,i))
    end
    hold on
end
title('Dynamics of probability distributions')
%% Visualize the Transition probability Matrix
figure()
plot_matrix_data(MJLS.T,'Transition Probability Matrix')
title('Transition Probability Matrix')
