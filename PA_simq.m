function [theta, diff, dmax] = PA_simq(F, G, q)

% Note (2018/11/03):
% This function calculates subspace similarity based on the proposed
% subspace similarity measure in MAC, but principal angles are calculated
% using the method proposed in 'Principal angles between 
% subspaces in an a-based scalar product'.

% Inputs:
% F, G: N by P data matrices  
% q: subspace dimensionality

% ss: the similarity between two subspaces, whose principal component
% vectors are F and G respectively.

%% F-related quantities
if size(F,1) == 1
    Qf=F';
else
    [U1 S1 V1] = svd(F','econ'); % U1 contains the eigenvectors
    vals1 = diag(S1).^2;
    Qf = U1(:,1:q);
end
df = q;


%% G-related quantities
if size(G,1)==1
    Qg=G';
else
    [U2 S2 V2] = svd(G','econ'); % U1 contains the eigenvectors
    vals2 = diag(S2*S2');
    Qg = U2(:,1:q);
end
dg = q;


%% reduced SVD  
[Y S Z] = svd(Qf'*Qg, 'econ');


%% final step
theta = acos(diag(S));
diff = 0;
dmax = q;
u = Qf*Y;
v = Qg*Z;

end