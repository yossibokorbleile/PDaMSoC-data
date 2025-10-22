%====================================================================
% FD_EXAMPLE     
%   A simple example of the use of Fourier descriptors:
%   The script:
%	a) reads a contour
%       b) Computes the Fourier descriptors of the contour up to M = 100
%	c) Reconstruct two contours, one with M = 10, one with M = 50
%	d) Display the original contour and the reconstructions
%====================================================================

%====================================================================
% 1. Load the contour
%====================================================================

load cell.dat

%====================================================================
% 2. Generate the descriptors
%====================================================================

opts.scaleNormalize = false;
M = 100; 
out = fd_descriptors(cell, M, opts);

%====================================================================
% 3. Reconstruct the contour with M = 10 and M = 50
%====================================================================

m = 10;
Npoints = 400;
C_10 = fd_reconstruct(out, m, Npoints);
m = 50;
C_50 = fd_reconstruct(out, m, Npoints);

%====================================================================
% 4. Plot the contour and the reconstructions
%====================================================================

figure; hold on; axis equal;
plot(cell(:,1),     cell(:,2),     'k-', 'LineWidth', 1.5);
plot(C_10(:,1), C_10(:,2), 'r-', 'LineWidth', 1.5);
plot(C_50(:,1), C_50(:,2), 'b-', 'LineWidth', 1.5);
legend('Original contour', 'FD reconstruction, M = 10', 'FD reconstruction, M = 50')

