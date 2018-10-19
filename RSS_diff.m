function diff = RSS_diff(X, ind, labels)

% The purpose of this function is to calculate the difference in Residual
% Sum of Squares (RSS) before and after removing data object 'ind' from the
% cluster that it belongs to. The regression is build for the data objects
% that lie in the same cluster as 'ind'.

% Inputs:
% X: the N by P data matrix
% ind: the data object to be considered for either removing or not
% labels: the truth labels for the data set

lab = labels(ind); % the label for data object 'ind'

% the group of data objects (inc. 'ind') that lie in the same cluster as
% 'ind'
Xind = X(labels==lab,:); 

%% RSS before
n = size(Xind,1);
regressors = [ones(n,1), Xind(:,1)];
response = Xind(:,2);
Betas = regressors\response;
lr_est = regressors*Betas; % the estimates before
rss_b = sum((lr_est-Xind(:,2)).^2);

%% data after removing 'ind' (issues in this section)
Xind_del = Xind;
Xind_del(ind,:) = [];
X_del = X0_del(labels==lab,:); % issues here

%% RSS after 
n_a = size(X_del,1);
regressors_a = [ones(n_a,1), X_del(:,1)];
response_a = X_del(:,2);
Betas_a = regressors_a\response_a;
lr_est_a = regressors_a*Betas_a;
rss_a = sum((lr_est_a-X_del(:,2)).^2);

%% calculate the difference in RSS
diff = abs(rss_a-rss_b);


end