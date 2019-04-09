function [outRois,roiMasks, extraVals] = DifferentialEpochSelectionWithWatershed(backgroundSubtractedMovie,deltaFOverF,epochStartTimes,epochDurations,params,varargin);
% (backgroundSubtractedMovie,deltaFOverF,epochStartTimes,epochDurations,params,varargin{:});
% Attempt to segment regions of the image by edge selectivity. This assumes
% that all the edge types have been presented (variable edgeTypes). Note
% that this script requires imgFrame! 

    roiMinPixNumber = 1;
    splitByWatershed = 1;
    fgThreshForWatershed = .75;
    eliminateOverlap = 1;
    demoMode = 0;
    
    epochsForIdentification = varargin([false strcmp(varargin, 'epochsForIdentificationForFly')]);
    if isempty(epochsForIdentification)
        error('DifferentialEpochSelectionWithWatershed requires an epochsForIdentification varargin!')
    else
        epochsForIdentification = epochsForIdentification{1};
        extraVals.epochsForIdentificationForFly = epochsForIdentification;
    end
    
    
    
    movieSize = size(deltaFOverF);
    if any(movieSize==0)
        outRois = [];
        roiMasks = zeros(movieSize(1:2));
        return
    end
    
    %%  Get indices associated with different edge presentations.
    nEdges = length(epochsForIdentification);
    

    %% Activity image based on PEAK, not average
    percentileImg = zeros(movieSize(1),movieSize(2),nEdges);
    percentileDiff = zeros(movieSize(1),movieSize(2),nEdges/2); 
    selectedEpochs = ConvertEpochNameToIndex(params,epochsForIdentification);

    for q = 1:nEdges
        % Grabbing the frames in which the edge types occurred
        epochResp = GetResponsesFromMovie(deltaFOverF,epochStartTimes,epochDurations, selectedEpochs(q));
        for m = 1:movieSize(1)
            for n = 1:movieSize(2)
                % percentileImg will contain the value of the pixel at the
                % time point when, if all the time points in the
                % presentation of the given edge type were sorted by
                % intensity, the intensity value would be the
                % percentileThreshold percent of the way through the sorted
                % values
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                percentileThreshold = 0.99;
                percentileImg(m,n,q) = percentileThresh( epochResp(m,n,:),percentileThreshold);
            end
        end
        if mod(q,2) == 0
            % Percentile diff is the difference between every two epochs
            percentileDiff(:,:,q/2) = medfilt2(percentileImg(:,:,q-1)-percentileImg(:,:,q));
        end
    end
    
        if demoMode
            keepGoing = 0;
            for q = 1:nEdges
                figure;
                imagesc(percentileImg(:,:,q));
                title(['Activity for ' epochsForIdentification{q}]);
            end
            fprintf(['\n\n'...
                'These images show the activity for each control epoch. \n'...
                'Activity is calculated as the 99th percentile value of \n'...
                'a given pixel''s intensity during the control epoch. This \n'...
                'threshold level is controlled by the variable \n'...
                'percentileThreshold which is hard-coded in. \n\n'...
                'Chosing the 99th percentile makes the most sense for edge \n'...
                'epochs which have a single high peak. We are essentially \n'...
                'picking the maximum value that the pixel stays at for a bit.\n' ]);
            while ~keepGoing
                keepGoing = input('\n\nType 1 to continue: ');
            end
            for q = 1:nEdges
                close;
            end
        end
        
    MakeFigure;
    colormap_gen;
    allScale = percentileThresh(abs(percentileImg(:)),.98);
    diffScale = percentileThresh(abs(percentileDiff(:)),.98);
    if diffScale == 0
        diffScale = 1;
    end
    for q = 1:nEdges
        if mod(q,2) == 0
            subplot(nEdges/2,1,q/2); imagesc(percentileDiff(:,:,q/2));  
            axis equal; axis off; set(gca,'Clim',[-diffScale diffScale]); colormap(mymap); title([epochsForIdentification{q-1} ' - ' epochsForIdentification{q}]);
        end
    end
    
        if demoMode
            keepGoing = 0;
            fprintf(['\n\n'...
                'These images show the difference in activity between \n' ...
                'control epochs n and n+1. They are created by subtracting \n' ...
                'the images shown in the previous step.']);
            while ~keepGoing
                keepGoing = input('\n\nType 1 to continue: ');
            end
        end
        
    
    %% Threshold, then find connected regions
    percentileDiffAbs = percentileDiff;
    blurDiff = 1;
    blurThresh = 0.95;
    % median filter and separate into positive and negative images. Note
    % that both maps are positive.
    for q = 1:nEdges/2
        medFiltPerc(:,:,q) = medfilt2(percentileDiffAbs(:,:,q));
        mfpPos(:,:,q) = medFiltPerc(:,:,q) .*  ( medFiltPerc(:,:,q) > 0 );
        mfpPosThresh(q) = percentileThresh(mfpPos(:,:,q),blurThresh);
        posRegions(:,:,q) = mfpPos(:,:,q) .* ( mfpPos(:,:,q) > mfpPosThresh(q) );
        mfpNeg(:,:,q) = -medFiltPerc(:,:,q) .*  ( medFiltPerc(:,:,q) < 0 );
        mfpNegThresh(q) = percentileThresh(mfpNeg(:,:,q),blurThresh);
        negRegions(:,:,q) = mfpNeg(:,:,q) .* ( mfpNeg(:,:,q) > mfpNegThresh(q) );
    end
    
        if demoMode
            keepGoing = 0;
            for q = 1:nEdges/2
                figure;
                subplot(2,1,1); imagesc(posRegions(:,:,q)); title(['Positive Areas, ' epochsForIdentification{2*q-1} ' - ' epochsForIdentification{2*q}]);
                subplot(2,1,2); imagesc(negRegions(:,:,q)); title(['Negative Areas, ' epochsForIdentification{2*q-1} ' - ' epochsForIdentification{2*q}]);
            end
            fprintf(['\n\n'...
                'In this step, we cut the difference images made above \n' ...
                'into their positive and negative parts by making two images, \n'...
                'one as diffImg .* (diffImg > 0) and the other the opposite. \n'...
                'We then threshold these images (blurThresh) and find \n'...
                'connected regions in these separated images. \n\n'...
                'If the first two edgeTypes are Left Dark and Left Light, \n'...
                'then the difference image is Left Dark - Left Light. \n'...
                'Then, the positive mask is the left dark ROIs, and the \n'...
                'the negative mask if the left light ROIs.' ]);
            while ~keepGoing
                keepGoing = input('\n\nType 1 to continue: ');
            end
            for q = 1:nEdges/2
                close;
            end
         end
        
    % find connected threshold-exceeding regions
    roiMasks = [];
    seqInd = 0;
    for q = 1:nEdges/2
        thisPosConn = bwconncomp(posRegions(:,:,q)~=0);
        nConnRegions = length(thisPosConn.PixelIdxList);
        for r = 1:nConnRegions
            thisroiMasks = zeros(movieSize(1),movieSize(2));
            thisroiMasks(thisPosConn.PixelIdxList{r}) = 1;
            roiMasks = cat(3,roiMasks,thisroiMasks);
            seqInd = seqInd + 1;
            typeFlag(seqInd) = 1+(q-1)*2;
        end
        thisNegConn = bwconncomp(negRegions(:,:,q)~=0);
        nConnRegions = length(thisNegConn.PixelIdxList);
        for r = 1:nConnRegions
            thisroiMasks = zeros(movieSize(1),movieSize(2));
            thisroiMasks(thisNegConn.PixelIdxList{r}) = 1;
            roiMasks = cat(3,roiMasks,thisroiMasks);
            seqInd = seqInd + 1;
            typeFlag(seqInd) = 2+(q-1)*2;
        end
    end
    
    %% Trimming steps    
    % Eliminate overlap
    if eliminateOverlap
        overlapMask = sum(roiMasks,3) > 1;
        roiMasks = reshape(roiMasks,[movieSize(1)*movieSize(2),size(roiMasks,3)]);
        roiMasks(overlapMask,:) = 0;
        roiMasks = reshape(roiMasks,[ movieSize(1), movieSize(2), size(roiMasks,2) ]);
    end
    
    % Separate by watershed boundaries (force smaller)
    if splitByWatershed && ~isempty(roiMasks)
        watersheds = WatershedMovieAvg( backgroundSubtractedMovie, fgThreshForWatershed );
        splitMasks = [];
        splitTypeFlag = [];
        for q = 1:size(roiMasks,3)
            thisShedSet = roiMasks(:,:,q) .* watersheds;
            uniqueVals = unique(thisShedSet(:));
            uniqueVals = uniqueVals(uniqueVals ~= 0);
            for r = uniqueVals'
                thisSplitMask = thisShedSet == r;
                splitMasks = cat(3,splitMasks,thisSplitMask);
            end
            splitTypeFlag = cat(1,splitTypeFlag,repmat(typeFlag(q),[ length(uniqueVals) 1 ]));
        end
        roiMasks = splitMasks;
        typeFlag = splitTypeFlag;
    end
    
    % But, eliminate very small rois
    nRoiOrig = size(roiMasks,3)*~isempty(roiMasks);
    remove = zeros(nRoiOrig,1);
    for q = 1:nRoiOrig
        if sum(sum(roiMasks(:,:,q))) < roiMinPixNumber
            remove(q) = 1;
        end
    end
    remove = ( remove ~= 0 );
    roiMasks(:,:,remove) = [];
    typeFlag(remove) = [];
    
        if demoMode
            keepGoing = 0;
            fprintf(['\n\n'...
                'Finally, there are a few loose ends to tie:\n'...
                ' - If splitByWatershed = true, we cut the ROIs along \n'...
                '   the watershed lines found by roiUtils_watershedMovieAvg. \n'...
                '   We put this in as a way of reducing roi size on the \n'...
                '   theory that larger ROIs in this method could cause \n'...
                '   poor performamce relative to watershedCluster. \n '....
                ' - If eliminateOverlap = true, COME UP WITH BETTER METHOD. \n'...
                ' - All ROIs with fewer than roiMinPixNumber pixels are \n '...
                '   thrown out. If you don''t want to throw out any, \n '...
                '   set roiMinPixNumber = 1.' ]);
            while ~keepGoing
                keepGoing = input('\n\nType 1 to continue: ');
            end
         end
        
    %% Visualization
    % Visualize these regions overlaid on the average image
    meanImg = mean(backgroundSubtractedMovie, 3);
    if ~isempty(roiMasks)
        for s = 1:nEdges/2
            MakeFigure;
            thisImg = repmat(meanImg/max(abs(meanImg(:))),[1 1 3])/2+.5;
            whichAssign = [ 2 3; 1 2 ];
            for r = 1:size(roiMasks,3)
                for q = 1:2
                    typeNum = (s-1)*2+q;
                    assign1 = whichAssign(q,1);
                    assign2 = whichAssign(q,2);
                    thisImg(:,:,assign1) = thisImg(:,:,assign1) - (roiMasks(:,:,r) * (typeFlag(r) == typeNum));
                    thisImg(:,:,assign2) = thisImg(:,:,assign2) - (roiMasks(:,:,r) * (typeFlag(r) == typeNum));
                end
            end
            image(thisImg)
            title([epochsForIdentification{2*s-1} ' - ' epochsForIdentification{2*s}]);
        end
    end
    
    
    %% Decode typeFlag variable for future use
    typeFlagName = {};
    for q = 1:length(typeFlag)
        typeFlagName = cat(1,typeFlagName,epochsForIdentification(typeFlag(q)));
    end
    
    %% Grab intensities from masks
    roiMasks = logical(roiMasks);
    outRois = zeros(movieSize(3), size(roiMasks, 3));
    roiMaskTemp = zeros(movieSize(1), movieSize(2));
    
    frameStartIndexes = 0:movieSize(1)*movieSize(2):movieSize(1)*movieSize(2)*(movieSize(3)-1);
    if ~isempty(roiMasks)
        for i = 1:size(roiMasks, 3)
            roiIndexOnMask = find(roiMasks(:, :,i));
            roiIndexInMovie = bsxfun(@plus, roiIndexOnMask, repmat(frameStartIndexes, length(roiIndexOnMask), 1));
            selectedPixels=  deltaFOverF(roiIndexInMovie);
            selectedPixels = reshape(selectedPixels,[length(roiIndexOnMask) movieSize(3)]);
            outRois(:,i) = mean(selectedPixels,1);
            roiMaskTemp(roiIndexOnMask) = i;
        end
    end
    
    roiMasks = roiMaskTemp;
    
    %% Save everything
%     ROI.roiMasks = roiMasks;
%     ROI.typeFlag = typeFlag;
%     ROI.typeFlagName = typeFlagName;
%     ROI.controlEpochInds = controlEpochInds;
%     ROI.percentileImg = percentileImg;
%     ROI.percentileDiff = percentileDiff;

end

