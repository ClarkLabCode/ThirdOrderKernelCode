function [k, rhat, rho, S, R] = extractKernel_60HzStim13HzResp(stimulus,responses,numFramesBack,numFramesForward,choosePoints)

%     S = zeros(length(responses)-numFramesBack, numFramesBack);
%     R = zeros(length(responses)-numFramesBack, 1);
%     responses(isnan(responses)) = 0;
%     aa = 1;
%     for ii = numFramesBack+1:length(responses)
%         S(aa, :) = stimulus((ii*numFramesBack):-1:(ii-1)*numFramesBack+1);
%         R(aa, 1) = responses(ii);
%         aa = aa+1;
%     end 
    S = stimulus;
    R = responses;
    size(S);
    choosePoints = choosePoints(find(choosePoints < size(S,1)));
    choosePoints = choosePoints(find(choosePoints > numFramesForward + 1));
    if ~isequal(choosePoints, [])
        S = S(choosePoints, :);
        R = R(choosePoints, :);
    end
    
    if numFramesForward ~= 0
        S = S(numFramesForward+1:end, :);
        R = R(1:end-numFramesForward, :);
    end
    if numFramesForward ~= 0
    S = zeros(length(stimulus)-numFramesBack-numFramesForward, numFramesBack+numFramesForward);
    R = zeros(length(stimulus)-numFramesBack-numFramesForward, 1);
    ii = 1;
    while (ii+numFramesBack+numFramesForward-1) < size(stimulus, 1)
        S(ii, :) = stimulus(ii+numFramesBack+numFramesForward-1:-1:ii);
        R(ii, :) = responses(ii+numFramesBack-1);
        ii = ii+1;
    end
        choosePoints = choosePoints(find(choosePoints < size(S,1)));
    choosePoints = choosePoints(find(choosePoints > numFramesForward + 1));
    if ~isequal(choosePoints, [])
        S = S(choosePoints, :);
        R = R(choosePoints, :);
    end
    
    end
    R = R-mean(R);
    k = S\R;

    rhat = S*k; % only of chosen points
    rho = corr(rhat,R); % only of chosen points
end