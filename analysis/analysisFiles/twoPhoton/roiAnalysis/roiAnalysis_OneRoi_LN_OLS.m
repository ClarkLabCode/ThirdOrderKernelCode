function roi = roiAnalysis_OneRoi_LN_OLS(roi,varargin)
order = 1;
plotFlag = false;
% repCVFlag = false; % if it is true...
for ii = 1:2:length(varargin)
    eval([varargin{ii} '= varargin{' num2str(ii+1) '};']);
end
flickpath = roi.stimInfo.flickPath;
S = GetSystemConfiguration;
kernelPath = S.kernelSavePath;
flickpath = [kernelPath,roi.stimInfo.flickPath];
roiNum = roi.stimInfo.roiNum;
k = roi.filterInfo.firstKernel.Original;

[respData,stimData,stimIndexes,repCVFlag,repStimuIndInFrame] = GetStimResp_ReverseCorr(flickpath, roiNum);

% [respData,stimData,stimIndexes] = GetStimResp_OLS(flickpath, roiNum);

% compute the thing...
nMultiBars = size(k,2);
maxTau = size(k,1);

if repCVFlag
    % first, get the repeated segments.
    repSegFlag = true;
    OLSMat = tp_Compute_OLSMat_NonRepOrRep(respData,stimData,stimIndexes,repStimuIndInFrame,repSegFlag,'order',order,'maxTau',maxTau,'nMultiBars', nMultiBars);
    stimRep = OLSMat.stim;
    respRep = OLSMat.resp{1};
    % you have to get the OFFSET out and the time traces, so that you could
    % calculate the mean and the variance.
    respRepByTrial = OLSMat.respByTrial{1};
    stimRepByTrial = OLSMat.stimMatrixByTrial;
    stimRepByTrialUpSample = OLSMat.stimRepByTrialUpSample;
    respRepByTrialTimeLag = OLSMat.relativeTimePointsEachTrial{1};
    
    % second, get the non repeated segments.
    repSegFlag = false;
    [OLSMat] = tp_Compute_OLSMat_NonRepOrRep(respData,stimData,stimIndexes,repStimuIndInFrame,repSegFlag,'order',order,'maxTau',maxTau,'nMultiBars', nMultiBars);
    stim = OLSMat.stim;
    resp = OLSMat.resp{1};
else
    OLSMat = tp_Compute_OLSMat(respData,stimData,stimIndexes,'order',order,'maxTau',maxTau,'nMultiBars', nMultiBars);
    stim = OLSMat.stim;
    resp = OLSMat.resp{1};
end
% changed it to filter
predResp = Kernel_Pred_OLS_AllBar_Linear(stim,k);
[lookUpTable.x, lookUpTable.y] = LN_NonParametric(predResp,resp);
[fit_SoftRectification] =  LN_FitToSoftRectification(predResp,resp);
[predLN,coe] = MyFitPoly2(predResp,resp);
r(1) = corr(predResp,resp);
str{1} = 'response and 1o ';



if repCVFlag
    % calculate the total explainable data, and the unexplainable data.
    predRespRep = Kernel_Pred_OLS_AllBar_Linear(stimRep,k);
    nSeg = length(respRepByTrial);
    predRespByTrial = cell(nSeg,1);
    for ss = 1:1:nSeg
        predRespByTrial{ss} = Kernel_Pred_OLS_AllBar_Linear( stimRepByTrial(ss,:,:),k);
        
    end
    rRep = corr(predRespRep,respRep);
    %     sem = std(respRepByTrial,1,2)/sqrt(size(respRepByTrial,2));
    %      PlotXY_Juyue((1:size(respRepByTrial,1))', mean(respRepByTrial,2),'errorBarFlag',true,'sem',sem);
    %     % plot error bar...
    % second thing is to use the
    respFull =  MultibarFlicker_alignResponseInRepSeg(respRepByTrial,respRepByTrialTimeLag);
    predRespFull =   MultibarFlicker_alignResponseInRepSeg( predRespByTrial,respRepByTrialTimeLag);
    if plotFlag
        MakeFigure;
        subplot(3,1,1)
        sem = std(respFull,1,2)/sqrt(size(respFull,2));
        PlotXY_Juyue((1:size(respFull,1))', mean(respFull,2),'errorBarFlag',true,'sem',sem);
        title('time trace for response in repeated segments');
        subplot(3,1,2)
        sem = std(predRespFull,1,2)/sqrt(size(predRespFull,2));
        PlotXY_Juyue((1:size(predRespFull,1))', mean(predRespFull,2),'errorBarFlag',true,'sem',sem);
        title('time trace for predicted response in repeated segments');
        
        subplot(3,3,7);
        quickViewOneKernel_Smooth(k,1,'labelFlag',true,'posUnit',5,'timeUnit',1/60);
        title('kernel');
        
        subplot(3,3,8);
        PlotLNModel(predResp,resp)
        subplot(3,3,9);
        PlotLNModel(predRespRep,respRep);
    end
end

LN.resp = resp;
LN.predResp = predResp;
LN.predLN = predLN;
LN.fit_Poly2 = coe; % look at table.... not coe....
LN.lookUpTable = lookUpTable;
LN.fit_SoftRectification = fit_SoftRectification;
LN.r = r;
LN.rRep = rRep;
LN.str = str;

roi.LN = LN;


end

% meanStim = zeros(nMultiBars,1);
% stdStim = zeros(nMultiBars,1);
% for qq = 1:1:nMultiBars
%     a = stimData(stimIndexes{1},qq);
%     meanStim(qq) = mean(a);
%     stdStim(qq) = std(a);
% end
%
% % test the stilled response...
% nRep = 19;
% a = zeros(897,nRep);
% for nn = 1:1:nRep
%     a(:,nn) = stimData(stimIndexes{1}(1) + (nn - 1) * 3600:stimIndexes{1}(1) + (nn - 1) * 3600 + 897 - 1,1);
% end
