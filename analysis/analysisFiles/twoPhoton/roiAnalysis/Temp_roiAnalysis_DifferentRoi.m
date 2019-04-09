function Temp_roiAnalysis_DifferentRoi(roiData,varargin)
dt = [-8:1:8];
tMax = [30];
aveBy = 'fly';
MainName = '';
saveFigFlag = true;
normKernelFlag = false; % normalize individual kernels within one roi, and then do any calculation from there. it should be false.
normRoiFlag = true;
kernelTypeUse = [2,3];
whichPlot = 'first';
for ii = 1:2:length(varargin)
    eval([varargin{ii} '= varargin{' num2str(ii+1) '};']);
end
MainName = [MainName,'_dtMax',num2str(max(dt)),'_tMax',num2str(tMax)];

dtMax = max(dt);

% roiData = roiAnalysis_SecondDt(roiData,'normKernelFlag',normKernelFlag,'normRoiFlag',normRoiFlag,...
%     'dt',dt,'tMax',tMax,'kernelToUse','Aligned');
%

% FigPlot_SK_MeanDtSineWave_IndividualBars(roiData,'dx',1, 'dtMax',dtMax,'tMax',tMax,'direction',0,'kernelTypeUse',kernelTypeUse,...
%     'normKernelFlag',normKernelFlag,'normRoiFlag',normRoiFlag,...
%     'aveBy','fly','MainName',MainName,'saveFigFlag',saveFigFlag);
% FigPlot_SK_MeanDtSineWave_IndividualBars(roiData,'dx',2, 'dtMax',dtMax,'tMax',tMax,'direction',0,'kernelTypeUse',kernelTypeUse,...
%     'normKernelFlag',normKernelFlag,'normRoiFlag',normRoiFlag,...
%     'aveBy','fly','MainName',MainName,'saveFigFlag',saveFigFlag);
switch whichPlot
    case 'first'
        FigPlot_FK_MeanKernel(roiData,'aveBy',aveBy,'kernelTypeUse',kernelTypeUse,'normRoiFlag',normRoiFlag,'MainName',MainName,'saveFigFlag',saveFigFlag);
    case 'second'
        % plot the first order kernel for those rois....
        roiData = roiAnalysis_SecondDt(roiData,'normKernelFlag',normKernelFlag,'normRoiFlag',normRoiFlag,...
            'dt',dt,'tMax',tMax,'kernelToUse','Adjusted');
        FigPlot_SK_MeanDtSineWave(roiData,'dx',1, 'dtMax',dtMax,'tMax',tMax,'direction',0,...
            'normKernelFlag',normKernelFlag,'normRoiFlag',normRoiFlag,...
            'aveBy',aveBy,'MainName',MainName,'saveFigFlag',saveFigFlag);
        FigPlot_SK_MeanDtSineWave(roiData,'dx',2, 'dtMax',dtMax,'tMax',tMax,'direction',0,...
            'normKernelFlag',normKernelFlag,'normRoiFlag',normRoiFlag,...
            'aveBy',aveBy,'MainName',MainName,'saveFigFlag',saveFigFlag);
end
% FigPlot_SK_MeanDtSineWave_T5T4Blend(roiData,'dx',1, 'dtMax',dtMax,'tMax',tMax,'direction',0,...
%     'normKernelFlag',normKernelFlag,'normRoiFlag',normRoiFlag,...
%     'aveBy',aveBy,'MainName',MainName,'saveFigFlag',saveFigFlag);
%
% FigPlot_SK_MeanDtSineWave_T5T4Blend(roiData,'dx',2, 'dtMax',dtMax,'tMax',tMax,'direction',0,...
%     'normKernelFlag',normKernelFlag,'normRoiFlag',normRoiFlag,...
%     'aveBy',aveBy,'MainName',MainName,'saveFigFlag',saveFigFlag);

% roiAnalysis_SK_MeanDtSineWave(roiData,'dx',1, 'dtMax',dtMax,'tMax',tMax,'direction',0,...
%     'normKernelFlag',normKernelFlag,'normRoiFlag',normRoiFlag,...
%     'aveBy','kernel','MainName',MainName,'saveFigFlag',saveFigFlag);
%
% roiAnalysis_SK_MeanDtSineWave(roiData,'dx',2,'dtMax',dtMax,'tMax',tMax,'direction',0,...
%     'normKernelFlag',normKernelFlag,'normRoiFlag',normRoiFlag,...
%     'aveBy','fly','normFlag',normFlag,'MainName',MainName,'saveFigFlag',saveFigFlag);

% roiAnalysis_SK_MeanDtSineWave(roiData,'dx',1,'aveBy','roi','normFlag',normFlag,'MainName',MainName,'saveFigFlag',saveFigFlag);
% roiAnalysis_SK_MeanDtSineWave(roiData,'dx',2,'aveBy','roi','normFlag',normFlag,'MainName',MainName,'saveFigFlag',saveFigFlag);

end