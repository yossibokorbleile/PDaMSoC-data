function out = fourier_descriptors(C, M, opts)

%=============================================================================
% FOURIER_DESCRIPTORS  
%   Compute Fourier descriptors (FDs) for a 2-D closed contour,
%   with full invariance to **translation**, **rotation**, and **starting point**.
%   Optional **scale normalization** is available.
%
%   out = fourier_descriptors(C, M)
%   out = fourier_descriptors(C, M, opts)
%
% INPUTS
%   C      : Nx2 array of contour points [x, y]. Must describe a closed curve
%            (last point need not repeat the first; the function will close it).
%
%   M      : Number of harmonics to compute (positive integer).
%            The function will compute harmonics from -M to +M.
%
%   opts   : Optional struct with fields:
%              opts.scaleNormalize (logical)
%                 - If true, descriptors are additionally made scale-invariant
%                   by dividing by the magnitude of the first harmonic.
%                 - Default: false.
%
% OUTPUT  (returned in struct "out")
%
%   out.F(-M:M)
%       Complex Fourier coefficients for each harmonic k.
%       These are the **normalized coefficients** obtained after translation
%       removal and starting-point alignment.
%       They are NOT rotation-invariant by themselves.
%
%   out.E(1:M)
%       **Rotation-invariant Fourier descriptors**.  
%       For each harmonic k > 0:
%           E(k) = |F(k)|
%       These magnitudes are invariant with respect to:
%         - translation  
%         - rotation  
%         - starting point  
%       They constitute the canonical descriptor vector for shape comparison.
%
%   out.E_norm(1:M)  
%       If opts.scaleNormalize = true, this contains scale-normalized descriptors:  
%           E_norm(k) = E(k) / E(1)  
%       If scale normalization is disabled, this field is empty.
%
%   out.centroid
%       Complex centroid of the contour (x + iy). Translation invariance is 
%       enforced by subtracting this from all points before computing FDs.
%
%   out.M  
%       Number of positive harmonics returned (same as input M).
%
% DESCRIPTION
%   This implementation uses the standard complex Fourier descriptor approach:
%     ✓ Contour represented as complex function z(t) = x(t) + i*y(t)
%     ✓ Translation removal by subtracting centroid
%     ✓ Starting-point invariance by normalizing phase relative to F(1)
%     ✓ Rotation invariance via magnitude descriptors
%     ✓ Optional scale normalization
%
%   The output (out.E or out.E_norm) can be used for shape comparison,
%   classification, clustering, PCA in descriptor space, etc.
%
%========================================================================

if nargin < 3, opts = struct(); end
if ~isfield(opts, 'scaleNormalize'), opts.scaleNormalize = false; end

C = double(C);
if size(C,2) ~= 2, error('C must be Nx2'); end

%========================================================================
% Ensure closed shape
%========================================================================

x = C(:,1); y = C(:,2);
if abs(x(1)-x(end)) > eps || abs(y(1)-y(end)) > eps
    x = [x; x(1)];
    y = [y; y(1)];
end

%========================================================================
% Convert to complex representation
%========================================================================

z = x + 1i*y;
N = length(z) - 1;  % Number of points (excluding repeated last point)
z = z(1:N);  % Remove the repeated last point for DFT

%========================================================================
% Translation invariance
%========================================================================

centroid = mean(z);
z = z - centroid;

%========================================================================
% Compute Fourier coefficients using DFT
% We'll compute coefficients for k = -M to M
%========================================================================

F = zeros(1, 2*M+1);
k_range = -M:M;

for idx = 1:length(k_range)
    k = k_range(idx);
    
    if k == 0
        F(idx) = sum(z) / N;
    else
        % Compute F(k) = (1/N) * sum_{n=0}^{N-1} z(n) * exp(-2*pi*i*k*n/N)
        n = (0:N-1)';
        F(idx) = sum(z .* exp(-2i*pi*k*n/N)) / N;
    end
end

%========================================================================
% Starting-point invariance
% Normalize phase by the angle of F(1)
% This makes descriptors independent of where we start tracing the contour
%========================================================================

idx_1 = M + 2;  % Index of k=1 in F array (since we start at k=-M)
phase_offset = angle(F(idx_1));

% Apply phase correction to all harmonics
for idx = 1:length(k_range)
    k = k_range(idx);
    F(idx) = F(idx) * exp(-1i * k * phase_offset);
end

%========================================================================
% Rotation-invariant magnitudes
% Extract positive harmonics only (k = 1 to M)
%========================================================================

F_positive = F(M+2:end);  % k = 1,2,...,M
E = abs(F_positive);

%========================================================================
% Optional scale normalization
%========================================================================

if opts.scaleNormalize && E(1) > 0
    E_norm = E / E(1);
else
    E_norm = [];
end

%========================================================================
% Output
%========================================================================

out.F = F;
out.k_range = k_range;  % To know which index corresponds to which harmonic
out.E = E;
out.E_norm = E_norm;
out.centroid = centroid;
out.M = M;

end
