function C_recon = fd_reconstruct(out, m, Npoints)

%====================================================================
% FD_RECONSTRUCT
%   Reconstruct a contour from Fourier descriptors using m harmonics.
%
%   C_recon = fd_reconstruct(out, m, Npoints)
%
% INPUTS
%   out     : Output structure from fourier_descriptors()
%   m       : Number of harmonics to use for reconstruction (m <= out.M)
%   Npoints : Number of points to generate in the reconstructed contour
%
% OUTPUT
%   C_recon : Npoints x 2 array of reconstructed contour points [x, y]
%
% DESCRIPTION
%   Reconstructs the contour using harmonics from -m to +m from the
%   Fourier coefficients stored in out.F. The contour is reconstructed
%   at Npoints evenly spaced parameter values and translated back by
%   the original centroid.
%====================================================================

%====================================================================
% Validity check: the number of harmonics requested should be smaller
% than the number of harmonics in the descriptors
%====================================================================

if m > out.M
    error('Requested m=%d exceeds available harmonics M=%d', m, out.M);
end

%====================================================================
% Generate parameter values for reconstruction
%====================================================================

t = linspace(0, 1, Npoints+1);
t = t(1:end-1)';  % Remove last point to avoid duplication

%====================================================================
% Initialize reconstructed contour
%====================================================================

z_recon = zeros(Npoints, 1);

%====================================================================
% Find indices in out.F corresponding to harmonics -m to +m
% out.F contains harmonics from -out.M to +out.M
% Index structure: [-M, ..., -1, 0, 1, ..., M]
%====================================================================

M_full = out.M;
center_idx = M_full + 1;  % Index of k=0

%====================================================================
% Reconstruct using inverse DFT formula
% z(t) = sum_{k=-m}^{m} F(k) * exp(2*pi*i*k*t)
%====================================================================

for k = -m:m
    idx = center_idx + k;  % Index in out.F array
    z_recon = z_recon + out.F(idx) * exp(2i*pi*k*t);
end

%====================================================================
% Translate back by centroid
%====================================================================

z_recon = z_recon + out.centroid;

%====================================================================
% Convert from complex to real coordinates
%====================================================================

C_recon = [real(z_recon), imag(z_recon)];

end
