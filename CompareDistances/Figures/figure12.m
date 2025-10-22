% =======================================================
%
% Simple script for generating the 4 panels of figure 12 
% from the paper
%
% =======================================================

% =======================================================
% Add the directory Scripts to the path
% =======================================================

addpath('../Scripts/');

% =======================================================
% Get distance matrices
% =======================================================

filepath='../X1Y1_Distances/';
filename='distances_fd50.dat';
fullpath=fullfile(filepath, filename);
load(fullpath);

filename='distances_fd10.dat';
fullpath=fullfile(filepath, filename);
load(fullpath);

filename='distances_elastic.dat';
fullpath=fullfile(filepath, filename);
load(fullpath);

filename='distances_aspectratio.dat';
fullpath=fullfile(filepath, filename);
load(fullpath);

% =======================================================
% Load cluster assignment (for coloring)
% =======================================================

load list_6clusters;

% =======================================================
% Perform mds scaling. Note that the script generates
% a figure each time it is called
% =======================================================

mds_analysis(distances_aspectratio, list_6clusters);
mds_analysis(distances_elastic, list_6clusters);
mds_analysis(distances_fd10, list_6clusters);
mds_analysis(distances_fd50, list_6clusters);

% =======================================================
% Print the figures in separate PDF files
% =======================================================

figure(1)
print -dpdf Figure12_A.pdf

figure(2)
print -dpdf Figure12_B.pdf

figure(3)
print -dpdf Figure12_C.pdf

figure(4)
print -dpdf Figure12_D.pdf
