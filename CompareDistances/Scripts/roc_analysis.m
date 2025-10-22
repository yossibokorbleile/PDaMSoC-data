function [rocX, rocY, AUC, pAUC10] = roc_curve(distmat, labels)
%
% generate a ROC curve on a distance matrix and a fold standard cluster assignment
%
% Input:
%       distmat: all distances between the cells
%       cluster_info: indicates the cluster number for the cell considered
%
% Output:
%	rocX:	fraction of false positive
%	rocY:	fraction of true positive
%	AUC:	area under the curve
%	pAUC10: area under the curve for rocX <= 0.1
%

N = max(size(labels));

% ----------------------------------------
% Build pairwise ground-truth labels
% ----------------------------------------

Y = zeros(N*(N-1)/2, 1);   % 1 = same cluster, 0 = different clusters
S = zeros(N*(N-1)/2, 1);   % Score = -distance (higher score = more similar)

k = 1;
for i = 1:N
    for j = i+1:N
        Y(k) = labels(i) == labels(j);
        S(k) = -distmat(i,j);   % convert distance to similarity
        k = k + 1;
    end
end

% ----------------------------------------
% Compute ROC curve and AUC using perfcurve
% ----------------------------------------

[rocX, rocY, ~, AUC] = perfcurve(Y, S, 1);

% Remove duplicate FPR values (keep first occurrence)
[rocX_unique, idx_unique] = unique(rocX, 'stable');
rocY_unique = rocY(idx_unique);

% ----------------------------------------
% Find indices where FPR is below or equal to 0.1
% ----------------------------------------
idx = rocX_unique <= 0.1;

% ----------------------------------------
% Extract the partial ROC curve
% ----------------------------------------
rocX_partial = rocX_unique(idx);
rocY_partial = rocY_unique(idx);

% ----------------------------------------
% If FPR doesn't reach exactly 0.1, interpolate to get the point at FPR=0.1
% ----------------------------------------
if ~isempty(rocX_partial) && rocX_partial(end) < 0.1
    % Interpolate TPR at FPR = 0.1
    tpr_at_01 = interp1(rocX_unique, rocY_unique, 0.1, 'linear');
    rocX_partial = [rocX_partial; 0.1];
    rocY_partial = [rocY_partial; tpr_at_01];
end

% ----------------------------------------
% Compute area under the partial curve using trapezoidal integration
% ----------------------------------------
pAUC10 = trapz(rocX_partial, rocY_partial);

end
