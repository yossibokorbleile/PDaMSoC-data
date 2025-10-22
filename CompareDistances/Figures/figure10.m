% =======================================================
%
% Simple script for generating figure 10 from the paper
%
% =======================================================

% =======================================================
% Add the directory Scripts to the path
% =======================================================

addpath('../Scripts/');

% =======================================================
% Get distance matrix
% =======================================================

filepath='../X1Y1_Distances/';
filename='distances_PH.dat';
fullpath=fullfile(filepath, filename);

load(fullpath);

% =======================================================
% Get cluster assignment (for coloring)
% =======================================================

load list_6clusters;

% =======================================================
% Perform mds scaling. Note that the script generates
% the figure
% =======================================================

mds_analysis(distances_PH, list_6clusters);

% =======================================================
% Print the figure as a PDF file
% =======================================================

figure(1)
print -dpdf figure10.pdf

