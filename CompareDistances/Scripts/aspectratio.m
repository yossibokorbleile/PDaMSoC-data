function A = aspectratio(C)

%=========================================================================
% ASPECTRATIO  Compute a rotation- and translation-invariant aspect ratio.
%
%   A = ASPECTRATIO(C) computes the aspect ratio of a 2D contour C,
%   given as an N×2 matrix of (x, y) coordinates.
%
%   The contour is centered and analyzed with PCA. The spread of the points
%   along the two principal axes gives:
%
%       A = (std along major axis) / (std along minor axis)
%
%   Properties:
%       • translation-invariant  (centering removes translation)
%       • rotation-invariant     (PCA aligns axes with principal directions)
%
%   Output:
%       A  - aspect ratio >= 1.  For perfectly isotropic shapes, A = 1.
%
%   Degenerate cases:
%       - If the contour lies on a line: A = Inf.
%       - If the contour is a single point: A = NaN.
%
%=========================================================================

%=========================================================================
% Validate input
%=========================================================================

    if ~isnumeric(C) || size(C,2) ~= 2
        error('Input C must be an N×2 numeric matrix.');
    end

%=========================================================================
% Remove translation by centering
%=========================================================================

    Cc = C - mean(C,1);

%=========================================================================
% PCA on covariance matrix
%=========================================================================

    Sigma = cov(Cc);

%=========================================================================
% Eigenvalues (variances along principal directions)
%=========================================================================

    ev = eig(Sigma);

%=========================================================================
% Sort descending: major axis first
%=========================================================================

    ev = sort(ev,'descend');

%=========================================================================
% Degenerate cases
%=========================================================================

    if ev(1) == 0
        A = NaN;    % No variation at all (single point)
        return;
    elseif ev(2) == 0
        A = Inf;    % All points lie on a line
        return;
    end

%=========================================================================
% Standard deviations along principal axes
%=========================================================================

    s1 = sqrt(ev(1));
    s2 = sqrt(ev(2));

%=========================================================================
% Aspect ratio (>=1)
%=========================================================================

    A = s1 / s2;

end
