% The following function computes the Incomplete Cholesky decomposition of
% the Gram matrix generated by the random variable samples
%
% Input:   "samples" should be COLUMN vectors of length (nx1)
%				'kernelSize' is a scalar for the kernel size.
%               "precision" is a scalar for the precision
%
% Output: 'choleskyMarix' contains nxd Cholesky matrix
%
% Default:  precision = 10^-6.
%
% Author: Sohan Seth (sohan@cnel.ufl.edu)	Date: 01.06.2009

function choleskyMatrix  = incompleteCholesky(samples,kernelSize,precision)

if nargin == 2
    precision = 10^-6;
end

n = size(samples,1);
twoSigmaSquare = 2*kernelSize^2;
permuteVector = 1:n;
partialTraceCholeskyMatrix = zeros(1,n);
% choleskyMatrix = zeros(n, n/100);
choleskyMatrix(:,1) = exp(-(samples - samples(1)).^2/twoSigmaSquare); % 1D
diagCholeskyMatrix = zeros(1, n);

for countCol=1:n

    if countCol == 1
        diagCholeskyMatrix(countCol:n) = (exp(-(samples(permuteVector(countCol:n)) ...
            - samples(permuteVector(countCol:n))).^2/twoSigmaSquare))';
    else
        diagCholeskyMatrix(countCol:n) = (exp(-(samples(permuteVector(countCol:n)) ...
            - samples(permuteVector(countCol:n))).^2/twoSigmaSquare))' ... % ones(1,n-countCol +1) ... % As diagonal of Kernel Matrix is all 1's
            - sum(choleskyMatrix(countCol:n,1:countCol-1).^2,2)'; % 1D
    end

    partialTraceCholeskyMatrix(countCol) = sum(diagCholeskyMatrix(countCol:n));

    if  partialTraceCholeskyMatrix(countCol) <= 0
        warning(['Negative diagonal entry', num2str(partialTraceCholeskyMatrix(countCol))])
    end

    if  partialTraceCholeskyMatrix(countCol) <= precision
        break
    else

        [bestElementValue bestElementIndex] = max(diagCholeskyMatrix(countCol:n));

        bestElementIndex = bestElementIndex+countCol-1;

        temp1 = permuteVector(countCol);
        permuteVector(countCol) = permuteVector(bestElementIndex);
        permuteVector(bestElementIndex) = temp1;

        temp2 = choleskyMatrix(countCol, 1:countCol-1);
        choleskyMatrix(countCol, 1:countCol-1) = choleskyMatrix(bestElementIndex, 1:countCol-1);
        choleskyMatrix(bestElementIndex, 1:countCol-1) = temp2;

        bestElementValue = sqrt(bestElementValue);

        choleskyMatrix(countCol,countCol) = bestElementValue;

        choleskyMatrix(countCol+1:n,countCol) = (exp(-(samples(permuteVector(countCol)) ...
            - samples(permuteVector(countCol+1:n))).^2/twoSigmaSquare) ...
            - choleskyMatrix(countCol+1:n,1:countCol-1)*choleskyMatrix(countCol,1:countCol-1)')/bestElementValue;

    end
end

if countCol ~= n
    choleskyMatrix = choleskyMatrix(:,1:countCol-1);
end

temp = [permuteVector',choleskyMatrix];
temp = sortrows(temp,1);
choleskyMatrix = temp(:,2:end);