% This function normalizes the rows/columns of a data matrix to have mean 0
% and variance 1.

function Y = norm01(X, dir)

% Inputs:
% X: input data matrix.
% dir: 'dir' for directions. 1 - normalize data by row, 2 - normalize data by column.

Y = X;

% normalize by row
if dir == 1
    for i = 1:size(X,1)
        Y(i,:) = (X(i,:) - mean(X(i,:)))/sqrt(var(X(i,:)));
    end
end

% normalize by column
if dir == 2
    for j = 1:size(X,2)
        Y(:,j) = (X(:,j) - mean(X(:,j)))/sqrt(var(X(:,j)));
    end
end

end