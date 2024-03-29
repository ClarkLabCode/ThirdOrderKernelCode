function [I] = IHSIC_estimation(Y,ds,co)
%function [I] = IHSIC_estimation(Y,ds,co)
%Estimates mutual information (I) using the HSIC (Hilbert-Schmidt independence criterion) method. 
%
%We use the naming convention 'I<name>_estimation' to ease embedding new mutual information estimation methods.
%
%INPUT:
%   Y: Y(:,t) is the t^th sample.
%  ds: subspace dimensions. ds(m) = dimension of the m^th subspace, m=1,...,M (M=length(ds)).
%  co: mutual information estimator object.
%
%REFERENCE: 
%   Arthur Gretton, Olivier Bousquet, Alexander Smola and Bernhard Scholkopf. Measuring Statistical Dependence with Hilbert-Schmidt Norms. International Conference on Algorithmic Learnng Theory (ALT), 63-78, 2005.
%   Alain Berlinet and Christine Thomas-Agnan. Reproducing Kernel Hilbert Spaces in Probability and Statistics. Kluwer, 2004. (mean embedding)

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
    if sum(ds) ~= size(Y,1);
        error('The subspace dimensions are not compatible with Y.');
    end

%initialization:
    num_of_samples = size(Y,2);
    num_of_comps = length(ds);
    cum_ds = cumsum([1;ds(1:end-1)]);%1,d_1+1,d_1+d_2+1,...,d_1+...+d_{M-1}+1 = starting indices of the subspaces (M=number of subspaces).
    Gs = {};   
    
%Gs:   
   for k = 1 : num_of_comps
       ind = [cum_ds(k):cum_ds(k)+ds(k)-1];
       %Cholesky decomposition:
            [G,p] = chol_gauss(Y(ind,:),co.sigma,num_of_samples*co.eta);
       [temp,p] = sort(p); %p:=inverse of p
       Gs{k} = G(p,:);
   end

I = hsicChol(Gs,num_of_samples,num_of_comps);
