%% This function calculates the clustering error, given the ground truth 
% labels and a vector of cluster assignments.

% Last updated: 6 Mar. 2020

function err = missrate(Truth, labels)

grps_a = bestMap(Truth, labels);
err = sum(Truth(:) ~= grps_a(:)) / length(Truth);

end