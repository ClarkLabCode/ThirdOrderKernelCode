function [texStr,stimData] = sinWaveFlicker(Q)

% this is to provide the general structure for the texture generating codes
% to be used with PTB in this framework. 

% NOTE: when you create a new stimulus function, you must update the
% stimlookup table in the folder paramfiles. paramfiles will also hold the
% text file giving lists of parameters that comprise an experiment

%when choosing noise values for the sine wave make sure that:
%noiseContrast <= (1-mlum*(contrast+1))/(3*mlum)
%this insures that 3 std of the noise keeps you below a luminence of 1

sii = Q.stims.currStimNum;
p = Q.stims.currParam; % this is what we've got to work with in terms of parameters for this stimulus
f = Q.timing.framenumber - Q.timing.framelastchange; % relative frame number
stimData = Q.stims.stimData;
floc = Q.flyloc; % could potentially use this to update the stimulus as well

texStr.opts = 'full'; % or 'rightleft','rightleftfront', etc. see drawTexture for deets
texStr.dim = 2; % or 2
texStr.scale = [1 1 1]; % using the different lengthscales appropriately.

%% Input parameters

framesPerFlip = p.framesPerUp;
mLum = p.mLum;
var = p.var; % scaling of the constrast after addition of sin + flicker
pixWd = p.pixWd;
flickerFreq = p.flickerFreq;
reseed = p.reseed;
sinLambda = p.sinLambda; % deg
sinFractAmpl = p.sinFractAmpl; % percent
sinOmega = p.sinOmega; % hz

%% Secondary parameters

btmpWd = floor(360/pixWd); % In degrees
lifespan = 60 * framesPerFlip/flickerFreq;
blockLen = 10; %I have no idea whether this is optimal
numBlocks = ceil(btmpWd/blockLen);
blockStarts = [ 1:blockLen:btmpWd+1 ];
blockStarts = [ blockStarts btmpWd+1 ];
k = 360/sinLambda;

%% reseed rng to be consistent between trials
% I'm not sure this works on twoPhoton
if f == 0
    if reseed
        rng(Q.timing.framenumber);
    end
    stimData.age = 0;
    stimData.randSinPhase = rand*2*pi;
    stimData.sinDir = floor(rand*3) - 1;
    % 3 options - stationary, left, right
end
 
%% Draw the bitmap
bitMap = zeros(1,360,framesPerFlip);
stimData.writeColIndex = 0;
for q = 1:framesPerFlip        
    if stimData.age == 0
        stimData.writeColIndex = mod(stimData.writeColIndex + 1,ceil(framesPerFlip/lifespan));
        wc = (stimData.writeColIndex)*(numBlocks+1);
        %% Draw new, uncorrelated values
        stimData.vals = 2*(randi(2,[1 btmpWd])-1.5);
        stimData.mat(wc+1) = stimData.sinDir;
        % Encode and record all pixels
        for s = 1:numBlocks
            blockNum = stimData.vals(blockStarts(s):blockStarts(s+1)-1);
            blockBin = (blockNum > 0);
            blockBinStr = num2str(blockBin);
            blockBinStr = blockBinStr(~isspace(blockBinStr));
            blockBinCode = bin2dec(blockBinStr);
            stimData.mat(wc+s+1) = blockBinCode;
        end
        %% Create sine wave
        xMesh = [1:360];
        stimData.sinWave = sin( 2*pi * (k * xMesh/360 - ...
            stimData.sinDir * sinOmega*f*1/60) + stimData.randSinPhase);
        %% Add them together
        flickDec = 1-sinFractAmpl/100;
        sinDec = sinFractAmpl/100;
        stretchBars = repmat(stimData.vals,[pixWd 1]);
        stretchBars = reshape(stretchBars,[1 360]); % this actually won't work if pix
                                                    % wid doesn't evenly
                                                    % divide 360.
        flickPlusSin = flickDec * stretchBars + sinDec * stimData.sinWave;
    end    
    % Put into bitmap
    bitMap(:,:,q) =  mLum * ( 1 + .95 * var * flickPlusSin);
    % a .98 is magiced in here to prevent contrast from hitting extremes
    stimData.age = mod(stimData.age+1,lifespan);
end

% texStr.tex = makeTexture(bitMap,Q);
texStr.tex = CreateTexture(bitMap,Q);

end