function LoglogHistogram(x,subplotInd)
% the value of the x is plot .
% assume x are always positive.
isSubPlot = 1;
if nargin < 2
    isSubPlot = 1;
end
if min(x) < 0
    disp('error, x should be larger than 0');
    return;
end
subplot(subplotInd(1),subplotInd(2),subplotInd(3));
h = histogram(x);

xValue = h.BinEdges(1:end - 1) +  1/2 * h.BinWidth;
yValue = h.Values;
%close gcf

subplot(subplotInd(1),subplotInd(2),subplotInd(3));
loglog(xValue,yValue);
grid on;

end


