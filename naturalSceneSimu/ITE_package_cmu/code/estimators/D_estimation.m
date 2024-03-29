function [D] = D_estimation(Y1,Y2,co)
%function [D] = D_estimation(Y1,Y2,co)
%Estimates divergence between Y1 and Y2.
%
%INPUT:
%   Y1: Y1(:,t) is the t^th sample from the first distribution. 
%   Y2: Y2(:,t) is the t^th sample from the second distribution.
%   co: divergence estimator object (structure).

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

%Here, we make use of the function handle initialized in 'D_initialization':
    D = co.function_handle(Y1,Y2,co);