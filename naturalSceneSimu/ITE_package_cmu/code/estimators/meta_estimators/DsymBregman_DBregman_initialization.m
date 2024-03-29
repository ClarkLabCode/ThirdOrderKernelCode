function [co] = DsymBregman_DBregman_initialization(mult,post_init)
%function [co] = DsymBregman_DBregman_initialization(mult)
%function [co] = DsymBregman_DBregman_initialization(mult,post_init)
%Initialization of the symmetric Bregman distance estimator using the relation: D_S = (D_NS(f1,f2) + D_NS (f2,f1)) / alpha, where D_NS is the nonsymmetric Bregman distance.
%
%Note:
%   1)The estimator is treated as a cost object (co).
%   2)We use the naming convention 'D<name>_initialization' to ease embedding new divergence estimation methods.
%   3)This is a meta method: the (nonsymmetric) Bregman distance estimator can arbitrary.
%
%INPUT:
%   mult: is a multiplicative constant relevant (needed) in the estimation; '=1' means yes (='exact' estimation), '=0' no (=estimation up to 'proportionality').
%   post_init: {field_name1,field_value1,field_name2,field_value2,...}; cell array containing the names and the values of the cost object fields that are to be used
%   (instead of their default values). For further details, see 'post_initialization.m'.
%OUTPUT:
%   co: cost object (structure).

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

%mandatory fields (following the template structure of the estimators to make uniform usage of the estimators possible):
    co.name = 'symBregman_DBregman';
    co.mult = mult;
    
%other fields:
    co.alpha = 0.7; %assumption: not equal to 1
    
    co.member_name = 'Bregman_kNN_k'; %you can change it to any (nonsymmetric) Bregman distance estimator

%post initialization (put it _before_ initialization of the members in case of a meta estimator):    
    if nargin==2 %there are given (name,value) cost object fields
        co = post_initialization(co,post_init);
    end  
    
%initialization of the member(s):
    co.member_co = D_initialization(co.member_name,mult,{'alpha',co.alpha}); %{'alpha',co.alpha}: the 'alpha' field of the member is also set here

    
