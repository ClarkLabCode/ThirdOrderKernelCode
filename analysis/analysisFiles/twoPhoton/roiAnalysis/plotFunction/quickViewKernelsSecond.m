function quickViewKernelsSecond(kernels,varargin)
% there should be a limit on how many rois you are presenting, let us see.
% 5*5.
smoothFlag = false;
titleByRoiSequenceFlag = false;
roiSequence = [];
saveFigFlag = false;
MainName = '';
nFigSave = 1;
figFileType = {'png'};
subplotHt = 3;
subplotWd = 4;
for ii = 1:2:length(varargin)
    eval([varargin{ii}, '= varargin{', num2str(ii + 1),'};'])
end


nMaxRoiOne = subplotHt * subplotWd;
nRoi = size(kernels,2);
nMaxRoi = min(nMaxRoiOne,nRoi);

if nMaxRoi == nMaxRoiOne;
    
    nRound = ceil(nRoi/nMaxRoi);
    count = 1;
    for ii = 1:1:nRound
        MakeFigure;
        for cc = 1:1:nMaxRoiOne
            subplot(subplotHt,subplotWd,cc);
            if smoothFlag
                quickViewOneKernel_Smooth(squeeze(kernels(:,count)),2);
            else
                quickViewOneKernel(squeeze(kernels(:,count)),2,'labelFlag',false);
            end
            if titleByRoiSequenceFlag
                title(num2str(roiSequence(count)));
            else
                title(num2str(count));
            end
            count = count+1;
            if(count > nRoi)
                if saveFigFlag
                    MySaveFig_Juyue(gcf,MainName,num2str(ii),'nFigSave',nFigSave,'fileType',figFileType);
                end
                return
            end
        end
        if saveFigFlag
            MySaveFig_Juyue(gcf,MainName,num2str(ii),'nFigSave',nFigSave,'fileType',figFileType);
        end
    end
else
    subplotHt = floor(sqrt(nRoi));
    subplotWd = ceil(nRoi/subplotHt);
    MakeFigure;
    for count = 1:1:nRoi
        subplot(subplotHt,subplotWd,count);
        if smoothFlag
            quickViewOneKernel_Smooth(squeeze(kernels(:,count)),2);
        else
            quickViewOneKernel(squeeze(kernels(:,count)),2,'labelFlag',false);
        end
        if titleByRoiSequenceFlag
            title(num2str(roiSequence(count)));
        else
            title(num2str(count));
        end
    end
    if saveFigFlag
        MySaveFig_Juyue(gcf,MainName,num2str(1),'nFigSave',nFigSave,'fileType',figFileType);
    end
end
