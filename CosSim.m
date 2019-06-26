% This function outputs an N by N cosine similarity matrix, given an N by P
% data matrix as input. The similarity values range between -1 and 1.

% 26th Jun. 2019

function Wfull = CosSim(X)

% initial parameters 
N = size(X, 1);
W = zeros(N);

% make sure the data are normalized to unit length
Xl = norml2(X, 1);

for ll = 1:(N-1)
    for rr = (ll+1):N
        
        W(ll,rr) = Xl(ll,:)*Xl(rr,:)';
        
    end
end

Wfull = W + eye(N) + W';


%% This function normalize the row/column of a matrix to have unit length
function y = norml2(x,ind)

if ind == 1 % normalize each row in 'before' 
    x = x';
    scale = diag(1./sqrt(sum(abs(x).^2)));
    y = (x*scale)';
end

if ind == 2 % normalize each column in 'before'
    scale = diag(1./sqrt(sum(abs(x).^2)));
    y = x*scale;
end

end

end
