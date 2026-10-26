function [ref]=gen_ref_pos_vel(dt)
% This function generates a reference as per Mahdi's CACC paper by applying
% a predetermined force to a double integrator in discrete-time(ZOH)
    A=[1,dt;0,1];
    B=[dt^2/2;dt];
    C=eye(2);    
    u=[zeros(1,200),-ones(1,50),zeros(1,150),ones(1,100),zeros(1,50)];
    steps=size(u,2);
    x=zeros(2,steps);
    x(:,1)=[0;20];
    ref(:,1)=C*x(:,1);    
    for i=1:(steps-1)       
        x(:,i+1)=A*x(:,i)+B*u(i);
        ref(:,i+1)=C*x(:,i+1);
    end
end