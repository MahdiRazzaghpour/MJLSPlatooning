function [x,p] = Simulate_MJLS(MJLS,steps,samples,ref)
% This function simulates the given MJLS with given number of samples and a
% given references
%% Propogate probabilities and states
x=zeros(MJLS.nx,steps,samples);
x(:,1,:)=MJLS.x_ic*ones(1,samples);
p=zeros(MJLS.N,steps);
p(:,1)=MJLS.p_ic;
for i=2:steps
    p(:,i)=MJLS.T*p(:,i-1);
    for j=1:samples   
        % Pick the A and B matrices with correct probability
        rand_no=rand(); 
        id=find(rand_no<cumsum(p(:,i-1)),1);
        A=MJLS.As{id};        
        B=MJLS.Bs{id};
        
        % Update states with respect to the A matrix        
        x(:,i,j)=A*x(:,i-1,j)+B*ref(:,i-1);
    end 
end
end

