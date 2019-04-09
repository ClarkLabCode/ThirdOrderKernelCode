function PlotLNModel(predResp,resp,varargin)
% PlotLNModel(predResp,resp,'color','r','lineWidth',5,'markerType','o','titleFlag',false,'setAxisLimFlag',1,'plotDashLineFlag',1,'plotXYCord','1','plotMethod','line');
nBins = 30;
nOneBin = 50;

titleFlag = 1;
plotMethod = 'scatter';
for ii = 1:2:length(varargin)
    eval([varargin{ii} '= varargin{' num2str(ii+1) '};']);
end

% mode = 1, only plot the easier situation,

r  = corr(predResp,resp);
% %  ScatterXYBinned(predResp,resp,nBins,nOneBin);
% plotH = ScatterXYBinned(x,y,nBins,nOneBin,color,'r','lineWidth',5, 'markerType','o')
switch plotMethod
    case 'scatter'
        ScatterXYBinned(predResp,resp,nBins,nOneBin,varargin{:});
    case 'line'
        LinePlotXYBinned(predResp,resp,nBins,nOneBin,varargin{:});
end
if titleFlag
    title(['r :', num2str(r)]);
end
axis equal
xlabel(['predited linear response (\Delta','F/F)']);
ylabel(['Actual Response \Delta','F/F']);

end
