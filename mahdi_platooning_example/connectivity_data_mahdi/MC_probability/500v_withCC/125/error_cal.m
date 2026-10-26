clear all;
close all;
clc

distance=125;
load('acc.mat');
load('vel.mat');
load('pos.mat');

% error=0;
% vel_dif=0;
% acc_dif=0;

N=1;
M=1;
K=1;

for i=1:size(pos,2)
    for j=2:size(pos,1)
        error(1,N)= abs (pos(j,i)-pos(j-1,i)+ distance);
        N=N+1;
    end
end

for i=1:size(pos,2)
    vel_dif(1,M)= max(vel(:,i))-min(vel(:,i));
    M=M+1;
end

for i=1:size(pos,2)
    acc_dif(1,K)= max(acc(:,i))-min(acc(:,i));
    K=K+1;
end

O1 = mean(error)
O2 = mean(vel_dif)
O3 = mean(acc_dif)

  
        