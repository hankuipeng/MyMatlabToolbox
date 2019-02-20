function [svals groups] = LinSubspace_k(X, K, max_iter)
% LinSubspace(X,K) conducts subspace clustering for data that come from
% linear subspaces. We fit a linear regression into each cluster, and take
% each set of linear regression coefficients as our "centroids". We then
% update our "centroids" and cluster memberships in a K-Means like fashion.

% Inputs:
% X: N by P data matrix
% K: number of clusters 
% max_iter: the maximum number of iterations to run 

N = size(X,1); % number of data objects
P = size(X,2); % the dimensionality of the data 
D = zeros(N,K); % the distance matrix
centroids = zeros(K,P); % the centroids matrix 


%% 1. random initialisation 
groups = datasample(1:K,N,'Replace',true); 
svals = [];
n = [];
regressors = [];
response = [];

for iter = 1:max_iter    
    
    for k = 1:K
        %% 2. build one linear regression for each group
        n(k) = length(find(groups==k));
        
        %%
        regressors{k} = [ones(n(k),1) X(groups==k,1)];
        response{k} = X(groups==k,2);
        centroids(k,:) = (regressors{k}\response{k})';
    end
    
    
    %% construct distance matrix
    for i = 1:N
        for k = 1:K
            D(i,k) = sqrt((X(i,2)-(centroids(k,:)*[1;X(i,1)]))^2);
        end
    end
    
    %% re-allocate the groups
    [vals groups] = min(D,[],2);
    svals(iter) = sum(vals);
    
end

end