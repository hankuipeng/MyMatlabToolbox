function d_rms = rms(X, labels, pct)
% this function calculates the root mean squared error of a
% clustering given a set of labels.

% Inputs:
% X: N by P data matrix
% labels: a set of labels indicating the cluster memberships
% pct: the proportion of variability to be captured by the subspace

% dimensionality of the data 
N = size(X, 1);
P = size(X, 2);

% number of clusters 
K = size(unique(labels),1);

%% calculate the centroid for each cluster 
centroids = [];
mu = [];
rms = zeros(N,1);

% SVD on each cluster
for k = 1:K
    
    % svd
    mu(k,:) = mean(X(labels==k,:));
    Y = X(labels==k,:) - mu(k,:);
    [U S V] = svd(Y);
    
    % store U S V for each cluster
    Uall{k} = U;
    Sall{k} = S;
    Vall{k} = V;
    L = U*S;
    
    % decide subspace dimensionality 
    eigvals = diag(S'*S);
    q = sum(cumsum(eigvals) <= pct*sum(eigvals))+1;
    
    % safety catch
    if q > P
        q = P;
    end
    
    Q(k) = q;
    
    % calculate the projected centroids
    centroids{k} = mean(L(:,1:q)*V(:,1:q)')+mu(k,:);
    
end

% calculate the rms for each data point 
for i = 1:N
    rms(i) = sqrt(sum((X(i,:)-centroids{k}).^2));
end

d_rms = mean(rms);

end