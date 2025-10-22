% =======================================================
%
% Simple script for generating the 2 panels of figure 13 
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

filename='distances_PH.dat';
fullpath=fullfile(filepath, filename);
load(fullpath);

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
% Load cluster assignments (define gold standard for
% ROC analysis
% two levels are considered
% =======================================================

load list_2clusters;
load list_6clusters;

% =======================================================
% Perform ROC analysis for each distance matrix:
% Each roc_analysis generates:
%      - the rates of false positive and true positive
%      - the AUC (area under the curve)
%      - the pAUC (partial AUC, FP < 0.1)
% =======================================================

[x_ph2, y_ph2, auc_ph2, pauc_ph2] = roc_analysis(distances_PH, list_2clusters);
[x_ph6, y_ph6, auc_ph6, pauc_ph2] = roc_analysis(distances_PH, list_6clusters);

[x_ar2, y_ar2, auc_ar2, pauc_ar2] = roc_analysis(distances_aspectratio, list_2clusters);
[x_ar6, y_ar6, auc_ar6, pauc_ar6] = roc_analysis(distances_aspectratio, list_6clusters);

[x_el2, y_el2, auc_el2, pauc_el2] = roc_analysis(distances_elastic, list_2clusters);
[x_el6, y_el6, auc_el6, pauc_el2] = roc_analysis(distances_elastic, list_6clusters);

[x_10fd2, y_10fd2, auc_10fd2, pauc_10fd2] = roc_analysis(distances_fd10, list_2clusters);
[x_10fd6, y_10fd6, auc_10fd6, pauc_10fd6] = roc_analysis(distances_fd10, list_6clusters);

[x_50fd2, y_50fd2, auc_50fd2, pauc_50fd2] = roc_analysis(distances_fd50, list_2clusters);
[x_50fd6, y_50fd6, auc_50fd6, pauc_50fd6] = roc_analysis(distances_fd50, list_6clusters);

% =======================================================
% Generate and print ROC curves for level 1 (2 clusters)
% =======================================================

figure
plot(x_ph2, y_ph2, '-k','LineWidth',2);
hold on
plot(x_ar2, y_ar2, '-r','LineWidth',2);
plot(x_el2, y_el2, '-b','LineWidth',2);
plot(x_10fd2, y_10fd2, '-m','LineWidth',2);
xlabel('False positive rate')
ylabel('True positive rate')
legend('PD','Aspect ratio','Elastic energy','Fourier (M=10)','Location','SouthEast')
set(gca,'FontName','TimesNewRoman','FontSize',14)
print -dpdf figure13_A.pdf

% =======================================================
% Generate and print ROC curves for level 2 (6 clusters)
% =======================================================

figure
plot(x_ph6, y_ph6, '-k','LineWidth',2);
hold on
plot(x_ar6, y_ar6, '-r','LineWidth',2);
plot(x_el6, y_el6, '-b','LineWidth',2);
plot(x_10fd6, y_10fd6, '-m','LineWidth',2);
xlabel('False positive rate')
ylabel('True positive rate')
legend('PD','Aspect ratio','Elastic energy','Fourier (M=10)','Location','SouthEast')
set(gca,'FontName','TimesNewRoman','FontSize',14)
print -dpdf figure13_B.pdf

