function []=plot_ensemble_trajs(x,samples)
% This function plots the ensemble trajectories for a given MJLS system
% with each state in a sub-plot
steps=size(x,2);
nx=size(x,1);
%% Plots ensemble trajectories
figure()
for i=1:samples    
    for subplots=1:nx
        subplot(nx,1,subplots)
        plot(1:steps,x(subplots,:,i))
        xlabel('time')
        ylabel(['x',int2str(subplots)])
        hold on
    end
end
end