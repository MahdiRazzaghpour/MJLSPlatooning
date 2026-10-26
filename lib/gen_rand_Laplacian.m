function L=gen_rand_Laplacian(N,density)
% This function just returns a random laplacian matrix for anetwork of
% given size N and a given density representing the probability for each
% pair to have a link
A=rand(N)<density;
A=(A+A');
A(find(A>1))=1;
L=diag(A*ones(N,1))-A;
end