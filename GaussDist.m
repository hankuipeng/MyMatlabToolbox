function d = GaussDist(x,y)
% this function calculates the Gaussian similarity of two data vectors a
% and b, using the formula:
% d = exp(-||x-y||^2)

Dxy = sum((x-y).^2);
d = exp(-Dxy);

end