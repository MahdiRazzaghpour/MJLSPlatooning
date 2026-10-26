function []=plot_matrix_data(X_compressed,X_name)
%subplot(1,3,3)
X_minc=min(min(X_compressed));
X_maxc=max(max(X_compressed));
range_Xc = [X_minc X_maxc]; 
imagesc(X_compressed,range_Xc)
title(X_name)
end