function [ dist,check ] = ownED( feature_v1,feature_v2,tresh,ed_mode,sequenceType,symmetry_mode )
%OWNED main function for euclidean distance calculation
%   tresh is for current smallest ed
%   ed_mode: 0 - full euclidean distance 1 - eraly abandoning
%   sequenceType: 0 - original real numbers 1 - DFT full sequence 2- DFT 5
%   coefficients 3 - DFT 10 coefficients 4 - DFT 20 coefficients
%   symmetry_mode: 0 - not use symmetry property 1 - use symmetry property
%   Detailed explanation goes here
dist = 0;
check = false;
tresh_square = tresh^2;

% setting max interation steps
numof_max_iter = length(feature_v1);
% check for mid coefficient
symmetry_check = 0;
if sequenceType == 1
    % if using the symmetry properties then reduce the max iteration steps
    if symmetry_mode == 1
        half_number = (length(feature_v1)-1)/2;
        if round(half_number) ~= half_number
            symmetry_check = 1;
        end
        numof_max_iter = 1+round(half_number);
    end
elseif sequenceType == 2
    numof_max_iter = 5;
elseif sequenceType == 3
    numof_max_iter = 10;
elseif sequenceType == 4
    numof_max_iter = 20;
end

% calculating the ed
for i=1:numof_max_iter
    if sequenceType == 0
        % real numbers
        dist = dist+ (feature_v2(i)-feature_v1(i))^2;
    else
        % complex numbers
        % using the symmetric properties        
        if symmetry_mode == 1
            
            if i == 1
                dist = dist+ (abs(feature_v2(i)-feature_v1(i)))^2;
            else
                if i == numof_max_iter
                    dist = dist+ (abs(feature_v2(i)-feature_v1(i)))^2;
                    if symmetry_check == 0
                        dist = dist+ (abs(feature_v2(i)-feature_v1(i)))^2;
                    end
                else
                    dist = dist+ 2*(abs(feature_v2(i)-feature_v1(i)))^2;
                end
            end
        else
            % if not use the symmetric properties
            dist = dist+ (abs(feature_v2(i)-feature_v1(i)))^2;            
        end
        
    end
    
    % check if need a eraly abandoning
    if ed_mode == 1
        if dist > tresh_square
            check = false;
            return;
        end
    end
end
dist = sqrt(dist);
if dist <= tresh
    check = true;
end
end

