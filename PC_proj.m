function [dat V] = PC_proj(X, pct)

% 'PC_vec' computes a set of principal component vectors for data matrix X 
% that captures no less than pct% of the variability in the data, and 
% outputs the projected data. 
% (1) X do not need to be a zero mean data matrix.  
% (2) the resulting PCs (vecs) are the PCs after added back the original
% mean for X.

% Inputs:
% X: N by P data matrix 
% pct: the percentage of variability that we wish to be captured by the PCs

% Output: 

% dat: it has the same dimensionality as the original data, it is
% essentially the data reconstructed by projecting onto the first n PCs.
% V: contains the whole set of principal component vectors for X. 

% 17th Oct. 2018

mu = mean(X);

X_0m = X-mu; % data after deducted the feature-wise mean

[U S V] = svd(X_0m); % SVD on the zero mean data

eigvecs = diag(S'*S); % a sequence of eigenvalues 

% number of eigenvectors needed to capture no less than pct% of the
% variability in the data 
n = sum((cumsum(eigvecs)>=sum(eigvecs))*pct==0)+1;

% project data from cluster 1 onto subspace (1st PC) of cluster 1
dat = X_0m*V(:,1:n)*V(:,1:n)'+mu;


end