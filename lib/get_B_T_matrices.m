function [B_cal,T_cal]=get_B_T_matrices(MJLS)
% This function gets the MJLS system and the transition prob matrix T and
% returns the B_cal and T_cal matrices which govern the mean and the
% covariance dynamics

% Build block diagonal Matrices
blk_diag_As=[];
blk_diag_kron_As=[];
for i=1:MJLS.N
    blk_diag_As=blkdiag(blk_diag_As,MJLS.As{i});
    blk_diag_kron_As=blkdiag(blk_diag_kron_As,kron(MJLS.As{i},MJLS.As{i})); 
end

%Build the B_cal and T_cal matrices
B_cal=kron(MJLS.T,eye(MJLS.nx))*blk_diag_As;
T_cal=kron(MJLS.T,eye(MJLS.nx^2))*blk_diag_kron_As;
end