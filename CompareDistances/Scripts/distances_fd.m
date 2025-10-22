%=========================================================
%
% Matlab script that performs all pairwise comparisons
% of the 2D contours included in a list of files stored in
% List_X1Y1 using two Fourier-based distances, one with
% M = 10 harmonics, one with M = 50 harmonics
%
% This code needs:
%
%	 - The script fd_descriptors.m that computes
%	   the Fourier descriptors of one contour (included
%	   in this directory)
%
%	- the file "list_X1Y1" that contains the list
%         of contour to be processed. Note that the full
%         path needs to be provided.
%
%	- each contour file should be a 2-column list of
%         numbers representing the vertices of the contour
%	  If you contours are in a csv format, either
%         rewrite them as a dat file (just replace the
%         comma with a space), or modify the script
%
%  The full distance matrices are saved as 
%  "distances_fd10.dat" and "distances_fd50.dat"
%
%========================================================

%========================================================
% Predefine scaling factor to bring internal coordinates
% to physical unit. In the case of X1Y1, the first 140
% files need to be scaled by "scale_X1" and the others
% by scale_Y1
%========================================================

N1 = 140;
scale_X1 = 0.3155;
scale_Y1 = 0.1639;

%========================================================
% Read list of filenames (one per line)
%========================================================

filepath = '../X1Y1_Contours/';

filelist = strtrim(string(splitlines(fileread("list_X1Y1"))));
filelist = filelist(filelist ~= "");   % remove empty lines
n = numel(filelist);

%========================================================
% Preload all curves so we load only once
%========================================================

curves = cell(n,1);
for i = 1:n
    filename = filelist(i);;
    fullpath = fullfile(filepath, filename);
    curves{i} = load(fullpath);
end

%========================================================
% Compute Fourier descriptors for each curve
%========================================================

M = 100;
FD = zeros(n, M);

opts.scaleNormalize = false;

for i = 1:n

    C = curves{i};
    if i < N1+1
	C = scale_X1*C;
    else
        C = scale_Y1*C;
    end

    % Compute the Fourier descriptors
    out = fd_descriptors(C, M, opts);

    % Store the invariant descriptors
    FD(i, :) = out.E(:).';   % ensure row vector
end

%========================================================
% 4. Compute pairwise Euclidean distance matrix
%========================================================

distmat10 = zeros(n, n);
distmat50 = zeros(n, n);

for i = 1:n
    for j = i+1:n
        d = norm(FD(i,1:50) - FD(j,1:50));
        distmat50(i,j) = d;
        distmat50(j,i) = d;     % symmetry
        d = norm(FD(i,1:10) - FD(j,1:10));
        distmat10(i,j) = d;
        distmat10(j,i) = d;     % symmetry
    end
    distmat50(i,i) = 0;
    distmat10(i,i) = 0;
end

%========================================================
% 5. Save distance matrices
%========================================================

save("distances_fd50.dat","distmat50","-ascii");
save("distances_fd10.dat","distmat10","-ascii");
