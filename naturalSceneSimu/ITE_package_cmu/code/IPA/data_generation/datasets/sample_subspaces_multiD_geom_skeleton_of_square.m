function [e] = sample_subspaces_multiD_geom_skeleton_of_square(d,num_of_samples)
%function [e] = sample_subspaces_multiD_geom_skeleton_of_square(d,num_of_samples)
%Sampling from a random variable distributed uniformly on the skeleton of the d-dimensional square.
%
%INPUT:
%	num_of_samples: number of samples to be generated.
%OUTPUT:
%   e: e(:,t) is the t^th sample. size(e,2) = num_of_samples.
%EXAMPLE:
%   e = sample_subspaces_multiD_geom_skeleton_of_square(4,1000);

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

%random square vertex:    
    p = (rand(d,num_of_samples)>0.5);%0/1 vector of length d
	
%neighbor of p:
    p2 = p;
	
%one coordinate is changed:    
    flip = discrete_nonuniform_sampling(ones(d,1)/d, 1,num_of_samples);
    flip = flip + d * [0:num_of_samples-1];
    p2(flip) = 1 - p2(flip);
	
%take a random point of the edge:
    e = p + repmat(rand(1,num_of_samples),d,1).* (p2-p);