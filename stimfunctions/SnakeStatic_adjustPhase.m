function [texStr,stimData] = SnakeStatic_adjustPhase(Q)

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
f = Q.timing.framenumber - Q.timing.framelastchange + 1; % relative frame number
stimData = Q.stims.stimData;
floc = Q.flyloc; % could potentially use this to update the stimulus as well
framet = [1/180 2/180 0]; %GBR. checked this order in DLPU006a.pdf document, each frame happens 1/180th of a second after the next

texStr.opts = 'full'; % or 'rightleft','rightleftfront', etc. see drawTexture for deets
texStr.dim = 2; % or 2
texStr.scale = [1 1 1]; % using the different lengthscales appropriately.

%% reading in stimulus parameters

Lo=p.lo;
Hi=p.hi;
pixSizeY=p.pixSizeY;
pixSizeX=p.pixSizeX;
rowHt=p.rowHt;
spaceHt=p.spaceHt;
whichWay=p.whichWay;
bgVal=p.bgVal;
patType=p.patType;
val=p.val;
cycles=p.cycles;

%% scaling the entered parameters to the size of the display

wd=round(360/pixSizeX);
ht=1/(tand(pixSizeY));
rows=round(ht/(rowHt+spaceHt));

%% picking which pattern is used

switch patType
    case 1
        pat=[Hi Lo -Hi -Lo; -Hi -Lo Hi Lo];
    case 2
        pat=[Hi Lo Lo -Hi -Lo -Lo; -Hi -Lo -Lo Hi Lo Lo];
    case 3
        pat=[Hi Lo Lo Lo -Hi -Lo -Lo -Lo; -Hi -Lo -Lo -Lo Hi Lo Lo Lo];
    case 4
        pat=[Hi Lo -Hi -Lo; Hi Lo -Hi -Lo];
    case 5
        pat=[Hi Lo -Lo -Hi; Hi Lo -Lo -Hi];
end

%% random phase

% checks to see whether your val during this run is larger than it was last
% time this function ran. If so, sets stimData(9) to 1 so that the phase
% will be randomized. Adds to stimData 6 which keeps track of how many
% cycles have passed, so that you can choose how many cycles between each
% phase shift.

stimData(9) = val > stimData(8);
stimData(6) = stimData(6) + stimData(9);
stimData(8) = val ;

% generates a random number between 0 and length(pat)-1, which will be the
% phase shift. The thing to note here is that stimData(7) only changes when
% stimData(9) is true, so even though stimData(9) is only true on the epoch
% changes, the phase is consistent within an epoch. NEW FILE HAS THE
% ADDITIONAL CONSTRAINT THAT STIMDATA(6) BE DIVISIBLE BY CYCLES, which
% allows you to decrease the frequency of phase shift. 

if stimData(9) && mod(stimData(6),cycles)==0
    stimData(7)=floor(rand*(size(pat,2)));
end
   
% implements phase shift using fancy Gilbert-approved matrix operations

rot=[ zeros(1,size(pat,2)-1) eye(1,1);  eye(size(pat,2)-1,size(pat,2)-1) zeros(size(pat,2)-1,1) ];
pat=pat*rot^stimData(7);

%% switch direction, if whichWay=2

if whichWay==2
    pat=fliplr(pat);
end

%% drawing the bitmap

reps=round(wd/length(pat));
a=repmat(pat,1,reps);
len=length(a);
              
ind=zeros(2,(rowHt+spaceHt)*2);
ind(1,spaceHt+1:rowHt+spaceHt)=1;
ind(2,rowHt+2*spaceHt+1:(rowHt+spaceHt)*2)=1;
ind=repmat(ind,1,rows);

ind2=1-ind(1,:)-ind(2,:);
a2=zeros(size(a));
c=zeros(1,len);

a2(:,:)=(a*val+1)*255/2;
c(:,:)=ones(1,len)*bgVal*255;
bitMap(:,:)=(ind'*a2(:,:))+(ind2'*c(:,:));



%stimData(11) = min(bitMap(:));
%stimData(12) = max(bitMap(:));
%stimData(13) = mean(bitMap(:));
%stimData(14) = std(bitMap(:));
%stimData(15:20) = bitMap(1,1:6,1);

%always include this line in a stim function to make the texture from the
%bitmap
texStr.tex = CreateTexture(bitMap,Q);
end

