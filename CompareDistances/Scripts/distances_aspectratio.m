%=========================================================
%
% Matlab script that performs all pairwise comparisons
% of the 2D contours included in a list of files stored in
% List_X1Y1 using the aspect ratio distance
%
% This code needs:
%
%	 - The script aspectratio.m that computes
%	   the aspect ratio of one contour (included
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
%  The full distance matrix is saved as "distances_aspectratio.dat"
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
% Compute aspect ratio for each curve
%========================================================

D = zeros(n, 1);
for i = 1:n
    C = curves{i};
    if i < N1+1
	C = scale_X1*C;
    else
        C = scale_Y1*C;
    end

    ar = aspectratio(C);

    D(i) = ar; 
end

%========================================================
% Compute pairwise Aspect ratio distance matrix
% -------------------------------------------------------------

Dist = zeros(n, n);
for i = 1:n
    for j = i+1:n
        d = abs(log(D(i)) - log(D(j)));
        Dist(i,j) = d;
        Dist(j,i) = d;     % symmetry
    end
    Dist(i,i) = 0;
end

save("distances_aspectratio.dat","Dist","-ascii");
