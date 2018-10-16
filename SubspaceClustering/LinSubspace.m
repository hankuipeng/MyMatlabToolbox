function groups = LinSubspace(X, K, max_iter)
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

for iter = 1:max_iter    
    
    %% 2. build one linear regression for each group
    n1 = length(find(groups==1));
    n2 = N-n1;
    
    %%
    regressors1 = [ones(n1,1) X(groups==1,1)];
    response1 = X(groups==1,2);
    centroids(1,:) = (regressors1\response1)';
    
    %%
    regressors2 = [ones(n2,1) X(groups==2,1)];
    response2 = X(groups==2,2);
    centroids(2,:) = (regressors2\response2)';
    
    
    %% construct distance matrix
    for i = 1:N
        for k = 1:K
            D(i,k) = sqrt((X(i,2)-(centroids(k,:)*[1;X(i,1)]))^2);
        end
    end
    
    %% re-allocate the groups
    [vals groups] = min(D,[],2);
    
end

end