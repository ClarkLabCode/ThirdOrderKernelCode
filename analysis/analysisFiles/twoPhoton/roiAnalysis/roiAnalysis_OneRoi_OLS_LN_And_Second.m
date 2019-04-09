function roi = roiAnalysis_OneRoi_OLS_LN_And_Second(roi,param,varargin)

% ploting function is seprated with calculating function
order = 1; % order is 1, dx = 1.
dx = 1; % could be the next nearest bar/
plotFlag = false;
for ii = 1:2:length(varargin)
    eval([varargin{ii} '= varargin{' num2str(ii+1) '};']);
end
% load data data set.
S = GetSystemConfiguration;
kernelPath = S.kernelSavePath;
flickpath = [kernelPath,roi.stimInfo.flickPath];

roiNum = roi.stimInfo.roiNum;
switch order
    case 1
        kernelFull = roi.filterInfo.firstKernel.Original;
    case 2
        % depend on dx.
        switch dx
            case 1
                kernelFull = roi.filterInfo.secondKernel.dx1.Original;
            case 2
                kernelFull = roi.filterInfo.secondKernel.dx2.Original;
        end
end
[respData,stimData,stimIndexes,repCVFlag,repStimuIndInFrame] = GetStimResp_ReverseCorr(flickpath, roiNum);
% [respData,stimData,stimIndexes] = GetStimResp_OLS(flickpath, roiNum); %
% compute the thing...
nMultiBars = size(kernelFull,2);
switch order
    case 1
        maxTau = size(kernelFull,1);
    case 2
        % for second order, use 60 as well
        %         maxTau = 60;
        maxTau = round(sqrt(size(kernelFull,1)));
end

maxTauRange = param.maxTauRange;
barNumRange = param.barNumRange;
dtMaxRange = param.dtMaxRange;

[nonRepData,repData] = roiAnalysis_OneRoi_OLS_PrepareStimResp_NonRepAndRep(respData,stimData,stimIndexes,repStimuIndInFrame,order,dx,maxTau,nMultiBars);
barCenter = roiAnalysis_FindFirstKernelCenter(roi,'methodFilterCenter','prob');
% h
[kernelTrunc,rTestingSelected,maxTau_DtMax_Range] = roiAnalysis_OneRoi_OLS_OverFittingTest_ModelSelection_1o2o(nonRepData,repData, maxTauRange,barNumRange,barCenter,kernelFull,order,dtMaxRange,'plotFlag',plotFlag);

% if it is first order, also do LN, otherwise, second order is good.
% you might want to do this trial by trial;
[respNonRep,predRespNonRep,respRep,predRespRep,respRepByTrialUpSample,predRespRepByTrialUpSample,respRepByTrial,predRespRepByTrial] = roiAnalysis_OneRoi_OLS_PredResp_RepAndNonRep(nonRepData,repData,kernelTrunc);

% only care about the data at testing data ?
ana.predRespByTrialUpSample = predRespRepByTrialUpSample; % for the repeated segments.
ana.respByTrialUpSample = respRepByTrialUpSample;
ana.predResp_L = predRespRep; % prediction of first order and second order kernel will be added together
ana.resp = respRep;
ana.r = roiAnalysis_OneRoi_OLS_Utils_ComputeCorr(respRep,predRespRep,respRepByTrial,predRespRepByTrial,respRepByTrialUpSample,predRespRepByTrialUpSample);
ana.predPower = roiAnalysis_OneRoi_OLS_Utils_ComputePredictivePower(respRepByTrial,predRespRepByTrial);
ana.kernel = kernelTrunc;
ana.respRepByTrialTimeLag = repData.respRepByTrialTimeLag;
ana.predResp_L_ByTrial = predRespRepByTrial;
ana.respRepByTrial = respRepByTrial;
% it will be easier if you also keep the by trial.
switch order
    case 1
        % to plot LN, also want the response and predicted response on the
        % non repeated session.
        ana.predRespNonRep = predRespNonRep;
        ana.respNonRep = respNonRep;
        % extra things are LN model.
        % for the first order kernel....
        predRespNonRep = predRespNonRep - mean(predRespNonRep);
        respNonRep = respNonRep - mean(respNonRep);
        [lookUpTable.x, lookUpTable.y] = LN_NonParametric(predRespNonRep,respNonRep);
        [fit_SoftRectification] =  LN_FitToSoftRectification(predRespNonRep,respNonRep);
        [~,fit_Poly] = MyFitPoly2(predRespNonRep,respNonRep);
        
        % arrange every thing into trial by trial form. just for plotting.
        % worry about this later...
        %         respRepByTrialUpSample = MultibarFlicker_alignResponseInRepSeg(respRepByTrial,respRepByTrialTimeLag);
        % use the LN model to pred response.
        predResp_LN_SoftRectification = MyLN_SoftRectification(predRespRep,fit_SoftRectification);
        predResp_LN_Poly = MyLN_Poly(predRespRep,fit_Poly,lookUpTable,'setUpLowerBoundFlag',false);
       
        nonLinearity.fit_Poly2 = fit_Poly;
        nonLinearity.lookUpTable = lookUpTable;
        nonLinearity.fit_SoftRectification = fit_SoftRectification;
        nonLinearity.predResp_LN_SoftRectification = predResp_LN_SoftRectification;
        nonLinearity.predResp_LN_Poly = predResp_LN_Poly;
        
        nSeg = length(predRespRepByTrial);
        predResp_LN_SoftRectification_ByTrial = cell(nSeg,1);
        for ss = 1:1:nSeg
            predResp_LN_SoftRectification_ByTrial{ss} = MyLN_SoftRectification(predRespRepByTrial{ss}, fit_SoftRectification);
        end
        predResp_LN_SoftRectification_ByTrialUpSample = MultibarFlicker_alignResponseInRepSeg(predResp_LN_SoftRectification_ByTrial, repData.respRepByTrialTimeLag);
        
        predResp_LN_Poly_ByTrial = cell(nSeg,1);
        for ss = 1:1:nSeg
            predResp_LN_Poly_ByTrial{ss} = MyLN_Poly(predRespRepByTrial{ss}, fit_Poly,lookUpTable);
        end
        predResp_LN_Poly_ByTrialUpSample = MultibarFlicker_alignResponseInRepSeg(predResp_LN_Poly_ByTrial, repData.respRepByTrialTimeLag);
        
        nonLinearity.r_SoftRectification = roiAnalysis_OneRoi_OLS_Utils_ComputeCorr(respRep,predResp_LN_SoftRectification,...
            respRepByTrial,predResp_LN_SoftRectification_ByTrial,respRepByTrialUpSample,predResp_LN_SoftRectification_ByTrialUpSample);
        nonLinearity.power_SoftRectification = roiAnalysis_OneRoi_OLS_Utils_ComputePredictivePower(respRepByTrial,predResp_LN_SoftRectification_ByTrial);

        nonLinearity.r_Poly = roiAnalysis_OneRoi_OLS_Utils_ComputeCorr(respRep,predResp_LN_Poly,...
            respRepByTrial,predResp_LN_Poly_ByTrial,respRepByTrialUpSample,predResp_LN_Poly_ByTrialUpSample);
        nonLinearity.power_Poly = roiAnalysis_OneRoi_OLS_Utils_ComputePredictivePower(respRepByTrial,predResp_LN_Poly_ByTrial);

        nonLinearity.predResp_LN_SoftRectification_ByTrialUpSample = predResp_LN_SoftRectification_ByTrialUpSample;
        nonLinearity.predResp_LN_Poly_ByTrialUpSample = predResp_LN_Poly_ByTrialUpSample;
        % you also have to get the upSampled version to plot the traces...
        % troublesome. could be canceled in the future, but keep it now.
        
        roi.LM.firstOrder = ana; % linear model... % for the plotting, for the LN, you also have to do a litte bit more.
        roi.LM.nonLinearity = nonLinearity;
    case 2
        roi.LM.secondOrder = ana;
end

% you can run this function for twice. and do not plot things inside. not
% necessary.