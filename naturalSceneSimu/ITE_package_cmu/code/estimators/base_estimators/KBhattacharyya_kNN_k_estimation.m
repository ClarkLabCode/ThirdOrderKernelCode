function [K] = KBhattacharyya_kNN_k_estimation(Y1,Y2,co)
%function [K] = KBhattacharyya_kNN_k_estimation(Y1,Y2,co)
%Estimates the Bhattacharyya kernel of two distributions from which we have samples, Y1 and Y2. The estimation is based on k-nearest neighbors (S={k}).
%
%We use the naming convention 'K<name>_estimation' to ease embedding new kernels on distributions.
%
%INPUT:
%  Y1: Y1(:,t) is the t^th sample from the first distribution.
%  Y2: Y2(:,t) is the t^th sample from the second distribution. Note: the number of samples in Y1 [=size(Y1,2)] and Y2 [=size(Y2,2)] can be different.
%  co: estimator object of a kernel on distributions.
%
%REFERENCE: 
%   Barnabas Poczos and Liang Xiong and Dougal Sutherland and Jeff Schneider. Support Distribution Machines. Technical Report, 2012. "http://arxiv.org/abs/1202.0302" (k-nearest neighbor based estimation of Dtemp2)
%   Tony Jebara, Risi Kondor, and Andrew Howard. Probability product kernels. Journal of Machine Learning Research, 5:819-844, 2004. (probability product kernels --spec--> Bhattacharyya kernel)
%   Anil K. Bhattacharyya. On a measure of divergence between two statistical populations defined by their probability distributions. Bulletin of the Calcutta Mathematical Society, 35:99-109, 1943. (Bhattacharyya kernel)

%Copyright (C) 2012- Zoltan Szabo ("http://www.gatsby.ucl.ac.uk/~szabo/", "zoltan (dot) szabo (at) gatsby (dot) ucl (dot) ac (dot) uk")
%
%This file is part of the ITE (Information Theoretical Estimators) toolbox.
%
%ITE is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by
%the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
%
%This software is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
%MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
%
%You should have received a copy of the GNU General Public License along with ITE. If not, see <http://www.gnu.org/licenses/>.

%co.mult:OK. The information theoretical quantity of interest can be (and is!) estimated exactly [co.mult=1]; the computational complexity of the estimation is essentially the same as that of the 'up to multiplicative constant' case [co.mult=0]. In other words, the estimation is carried out 'exactly' (instead of up to 'proportionality').

%verification:
    if size(Y1,1)~=size(Y2,1)
        error('The dimension of the samples in Y1 and Y2 must be equal.');
    end

if co.p %[p(x)dx]
    K = estimate_Dtemp2(Y1,Y2,co);
else %[q(x)dx]
    K = estimate_Dtemp2(Y2,Y1,co);
end
