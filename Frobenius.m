% This function calculates the Frobenius norm of a matrix X
function Xf = Frobenius(X)

Xf = sqrt(sum(sum((abs(X)).^2)));

end