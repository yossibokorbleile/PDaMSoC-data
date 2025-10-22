%=========================================================
%
% Matlab script that performs all pairwise comparisons
% of the 2D contours included in a list of files stored in
% List_X1Y1 using the elastic distance
%
% This code needs:
%
%         - The package fdasrvf available at:
%           https://github.com/jdtuck/fdasrvf_MATLAB
%           This file uses the function pairwise_align_curves
%           it should be in your Matlab path (in fact
%           the whole fdasrf package needs to be in the
%           Matlab path)
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
%  The full distance matrix is saved as "distances_elastic.dat"
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
% Allocate distance matrix
%========================================================

distmat = zeros(n, n);

%========================================================
% Compute all elastic distances between contours
%========================================================

for i = 1:n
    C1 = curves{i};
    if i < N1+1
	C1 = scale_X1*C1;
    else
        C1 = scale_Y1*C1;
    end
    for j = i+1:n
	C2 = curves{j};
    	if j < N1+1
		C2 = scale_X1*C2;
    	else
        	C2 = scale_Y1*C2;
    	end
        dist = pairwise_align_curves(C1', C2');
        distmat(i,j) = dist;
        distmat(j,i) = dist;
    end
    distmat(i,i) = 0;
end

%========================================================
% Optionally save result
%========================================================

save("distances_elastic.dat", "distmat","-ascii");

