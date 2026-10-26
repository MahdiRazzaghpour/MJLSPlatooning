clear all
close all
clc
addpath('./examples/')
addpath('./lib/')

%% Define the MJLS
% Eaxmple 1: scaler not MSS
% Example 2: scalar MSS
% Example 3: Unstable+Unstable=Stable  
% Example 4: Stable+Stable=Unstable
% Example 8: Mass spring damper system with random spring stiffness

MJLS=example_8();      
%% Analyze the defined MJLS
[B_cal,T_cal]=get_B_T_matrices(MJLS);
rho_B=max(abs(eig(B_cal)));
rho_T=max(abs(eig(T_cal)));