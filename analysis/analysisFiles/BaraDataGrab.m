clear
%close all
%% Set the axes font size & name
set(0,'DefaultAxesFontSize', 20)
set(0,'DefaultAxesFontName', 'Arial')
%% Set the paths for flies with 2p and no 2p
%w2p = GetPathsFromDatabase('T4T5','Glider3PMirroredStdw2P','GC6f','right');
% no2p = GetPathsFromDatabase('T4T5','Glider3PMirroredStd','GC6f','right');
% baraGliderNo2 = [no2p(3:end)];%; w2p(2:end)];
% baraGliderYes2 = [w2p(2:end-1)];


%w2p = GetPathsFromDatabase('T4T5','glidAM_3p2p_sweep','GC6f','right');
%w2p = GetPathsFromDatabase('T4T5','glidAM_3p2p_sweep60Hz','GC6f','right');
%w2p = GetPathsFromDatabase('HS','glidAM_3p2p_sweep5Hz','GC6f','right');
%w2p = GetPathsFromDatabase('T4T5','leftRightUpCIS_CISc02_05_1','GC6f','right');
%w2p = GetPathsFromDatabase('T4T5','angularSweep_CIS_CISc02_05_1','GC6f','right');
%w2p = GetPathsFromDatabase('T4T5','NLDedgeM_single','GC6f','right');  
w2p = GetPathsFromDatabase('T4T5','randomVelocityGrating_new_120_240_sweep','GC6f','right');
%w2p = GetPathsFromDatabase('T4T5','leftRightUpCIS_CISc02_tiltedby30_corrected','GC6f','right');
%w2p = GetPathsFromDatabase('T4T5','NLDedgeM_HigherNoise','GC6f','right');
%w2p = GetPathsFromDatabase('T4T5','PDFollowedBySweep_V2','GC6f','right');
 %w2p = GetPathsFromDatabase('T4T5','ProgressiveDotsDensitySweep','GC6f','right');
%w2p = GetPathsFromDatabase('T4T5','SweepCISregFrequency','GC6f','right');
%w2p = GetPathsFromDatabase('T4T5','OpponencyTestProgressiveDots','GC6f','right', 'Bara');
% 'IcaRoiExtraction','roiSelectionFile', 'RoiSelectionSizeAndResp','filterMovie',0,'forceRois',0,'epochsForSelectivity',{'Square Right' 'Square Left'; 'Square Left' 'Square Right'}

baraGliderYes2 = [w2p(1:3); w2p(5:end)];
baraGliderYes2 = [baraGliderYes2(1:6); baraGliderYes2(8:end)];
%baraGliderYes2 = [ w2p(2); w2p(3); w2p(5:7); w2p(9:end)];
%baraGliderYes2 = [w2p(1:20); w2p(22:end)];
%baraGliderYes2 = [w2p];
%%
legVal = {'Progressive', 'Regressive'};
%  
% fullGlider3p1=RunAnalysis('analysisFile',{'CombAndSep'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRois','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge'},...
%     'dataX',[],'tickX',1:7,'tickLabelX',{'Uncorr',  'Converging +', 'Converging -', 'Diverging +', 'Diverging -','2pt+', '2pt-' },'labelX','','figLeg',legVal,'combOpp',0,'numSep',2,'filterMovie',1,'forceRois',0);

% fullGlider3p2=RunAnalysis('analysisFile',{'CombAndSep'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRois','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge'},...
%     'dataX',[],'tickX',1:7,'tickLabelX',{'Uncorr',  'Converging +', 'Converging -', 'Diverging +', 'Diverging -','2pt+', '2pt-' },'labelX','','figLeg',legVal,'combOpp',0,'numSep',2,'filterMovie',1,'forceRois',0);
% fullGlider3p3=RunAnalysis('analysisFile',{'CombAndSep'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRois','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge'},...
%     'dataX',[],'tickX',1:7,'tickLabelX',{'Uncorr',  'Converging +', 'Converging -', 'Diverging +', 'Diverging -','2pt+', '2pt-' },'labelX','','figLeg',legVal,'combOpp',0,'numSep',2,'filterMovie',1,'forceRois',0);
% fullGlider3p4=RunAnalysis('analysisFile',{'CombAndSep'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsi veRois','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'tickX',1:7,'tickLabelX',{'Uncorr',  'Converging +', 'Converging -', 'Diverging +', 'Diverging -','2pt+', '2pt-' },'labelX','','figLeg',legVal,'combOpp',0,'numSep',2,'filterMovie',1,'forceRois',0);
%

% fullGlider3p1=RunAnalysis('analysisFile',{'CombAndSep'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRois','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
%     '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%    'dataX',[],'tickX',1:13,'tickLabelX',{'Uncor',  '1 Hz +', '1 Hz -','5 Hz +', '5 Hz -','10 Hz +', '10 Hz -','15 Hz +', '15 Hz -', '20 Hz +', '20 Hz -', '60 Hz +', '60 Hz -'},'labelX','','figLeg',legVal,'combOpp',0,'numSep',2,'filterMovie',1,'forceRois',0);
% 

%% Orthogonal Opp test
% 
%   legVal = { 'Progressive', 'Regressive', 'Progressive + Regressive','Up + Progressive', 'Up + Regressive', 'Down + Progressive', 'Down + Regressive'};
% fullGlider3p1=RunAnalysis('analysisFile',{'CombAndSep'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRoisKillUpDown','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
%     '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'tickX',1:3,'tickLabelX',{'0.1',  '0.25', '0.5'},'labelX','','figLeg',legVal,'combOpp',0,'numSep',7,'filterMovie',1,'forceRois',0);

% 
% plotEps = ones(1,34);
% %plotEps(1:20) = 0;
% %plotEps(28:34) = 1;
% % plotEps = ones(1,34);
% fullGlider3p1=RunAnalysis('analysisFile',{'PlotTimeTraces'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRoisKillUpDown','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
%     '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'tickX',1:3,'tickLabelX',{'0.25',  '0.5', '1'},'labelX','','figLeg',legVal,'combOpp',0,'filterMovie',1,'forceRois',0, 'numIgnore', 13, 'plotEpochs', plotEps);

%% Random V Grating

fullGlider3p1=RunAnalysis('analysisFile',{'PlotTimeTraces'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRoisKillUpDown','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
    {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
    '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
    'dataX',[],'labelX','','combOpp',0,'filterMovie',1,'forceRois',0, 'numIgnore', 13);


%% Movies yay
% fullGlider3p1=RunAnalysis('analysisFile',{'CreateMotionLayerMovie'},'dataPath',baraGliderYes2(10),'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', '','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
%     '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'tickX',1:3,'tickLabelX',{'0.25',  '0.5', '1'},'labelX','','figLeg',legVal,'combOpp',0,'filterMovie',1,'forceRois',0, 'numIgnore', 27,...
%     'epochsForMovie', {28, 34}, 'saveMovieLocation', 'C:\Users\Team Badwan HQ\Documents\MoviesStimuli');


%% Angular Sweep
% xLabels = {'Progressive', '30Deg', '60Deg','90Deg', '120Deg', '150Deg', '180Deg', '210Deg', '240Deg','270Deg', '300Deg', '330Deg'};
% fullGlider3p1=RunAnalysis('analysisFile',{'PlotPolar'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRois','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
%     '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'tickX',1:length(xLabels),'tickLabelX',xLabels,'labelX','','combOpp',0, 'numSep', 1,'filterMovie',1,'forceRois',0);

%% Noisey Edge
% legVal= {'Noise', 'Prog Light Noisey'	'Reg Light Noisey'	'Prog Dark Noisey'	'Reg Dark Noisey'	'Prog Light'	'Reg Light'	'Prog Dark'	'Reg Dark'};
% fullGlider3p1=RunAnalysis('analysisFile',{'PlotTimeTraces'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRois','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
%     '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'figLeg',legVal,'labelX','','combOpp',0, 'numSep', 1,'filterMovie',1,'forceRois',0);
%% Classic Glider
%roiSelecFile = 'watershedRoiExtraction_MA';
% roiSelecFile = 'IcaRoiExtraction';
% fullGlider3p1=RunAnalysis('analysisFile',{'CombAndSep'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRois','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';'~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';...
%     '~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'tickX',1:7,'tickLabelX',{'Uncorrelated',  'Converging +', 'Converging -','Diverging +', 'Diverging -','2pt+', '2pt-' },'labelX','','figLeg',legVal,'combOpp',0,'numSep',2,'filterMovie',1,'forceRois',0);

%% Random Velocity Grating
% legVal= {'120 S' '120 R'	'240 S'	'240 R'};
% fullGlider3p1=RunAnalysis('analysisFile',{'PlotTimeTraces'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRois','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
%     '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'figLeg',legVal,'labelX','','combOpp',0, 'numSep', 1,'filterMovie',1,'forceRois',0);

%% ROI Extraction Analysis
% fullGlider3p1=RunAnalysis('analysisFile',{'EdgeSelectivityAnalysisPartDuo'},'dataPath',baraGliderYes2, 'dataX',[],'tickX',1:7,'tickLabelX',{'Uncorrelated',  'Converging +', 'Converging -','Diverging +', 'Diverging -','2pt+', '2pt-' },'labelX','','figLeg',legVal,'combOpp',0,'numSep',2);

% fullGlider3p1=RunAnalysis('analysisFile',{'EdgeSelectivityAnalysisPartDuo'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', '','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';'~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';...
%     '~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'tickX',1:7,'tickLabelX',{'Uncorrelated',  'Converging +', 'Converging -','Diverging +', 'Diverging -','2pt+', '2pt-' },'labelX','','figLeg',legVal,'combOpp',0,'numSep',2);

%% PD Sweep
% legVal= { 'Progressive Sine Wave', 'Gray'	'CPG'	'Regressive Sine Wave' 'Static'};
% fullGlider3p1=RunAnalysis('analysisFile',{'PlotTimeTraces'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRois','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
%     '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'figLeg',legVal,'labelX','','combOpp',0, 'numSep', 1,'filterMovie',1,'forceRois',0, 'numIgnore', 14);
%% Density Sweep
%   legVal = {'5pD',	'10pD',	'20pD',	'40pD',	'80pD',	'100pD'};
% fullGlider3p1=RunAnalysis('analysisFile',{'CombAndSep'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRoisKillUpDown','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
%     {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
%     '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
%     'dataX',[],'tickX',1:6,'tickLabelX',legVal,'labelX','','combOpp',0,'numSep',1,'filterMovie',1,'forceRois',0);
%% Opponency Dot Test
  legVal = { 'Progressive', 'Regressive', 'Progressive + Regressive','Up + Progressive', 'Up + Regressive', 'Down + Progressive', 'Down + Regressive'};
fullGlider3p1=RunAnalysis('analysisFile',{'CombAndSep'},'dataPath',baraGliderYes2,'roiExtractionFile', 'IcaRoiExtraction','roiSelectionFile', 'SelectResponsiveRoisKillUpDown','filterMovie',1,'forceRois',0,'epochsForSelectivity', ...
    {'~Left Light Edge', 'Left Dark Edge', 'Right Light Edge', 'Right Dark Edge';'~Right Light Edge', 'Right Dark Edge', 'Left Light Edge', 'Left Dark Edge';...
    '~Left Dark Edge', 'Left Light Edge', 'Right Dark Edge', 'Right Light Edge';'~Right Dark Edge', 'Right Light Edge', 'Left Dark Edge', 'Left Light Edge'},...
    'dataX',[],'tickX',1:length(legVal),'tickLabelX',legVal,'labelX','','combOpp',0,'numSep',1,'filterMovie',1,'forceRois',0);


%%
 % fullGlider3p1=RunAnalysis('analysisFile', {'CombAndSep'},'dataPath',baraGliderYes2,'roiExtractionFile',roiSelecFile,'roiSelectionFile', 'RoiSelectionSizeAndResp','filterMovie',0,'forceRois',0,'epochsForSelectivity',{'Square Right' 'Square Left'; 'Square Left' 'Square Right'}, ...
  %  'dataX',[],'tickX',1:7,'tickLabelX',{'Uncorrelated','Converging +', 'Converging -', 'Diverging +', 'Diverging -','2pt+', '2pt-' },'labelX','','figLeg',legVal,'combOpp',0,'numSep',2,'filterMovie',1,'forceRois',0);

% fullGlider3p1=RunAnalysis('analysisFile',{'CombAndSep', 'PlotRoisOnMask'},'dataPath',baraGliderYes2,'roiExtractionFile','IcaRoiExtraction','roiSelectionFile', 'RoiSelectionSizeAndResp','filterMovie',0,'forceRois',0,'epochsForSelectivity',{'Square Right' 'Square Left'; 'Square Left' 'Square Right'}, ...
%     'dataX',[],'tickX',1:3,'tickLabelX',{'0.25',  '0.5', '1'},'labelX','','figLeg',legVal,'combOpp',0,'numSep',7,'filterMovie',1,'forceRois',0, 'plotInd', 1);


% legVal = {'Uncorrelated' 'Uncorrelated'  'Diverging P+' 'Diverging N+' 'Diverging P-' 'Diverging N-'  ...
%     'Converging P+' 'Converging N+'  'Converging P-' 'Converging N-'  '2pt +' '2pt -'};