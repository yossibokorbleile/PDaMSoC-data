function Y = mds_analysis(distmat, cluster_info)
%
% generate a projection of the cell space based on a distance
% matrix
%
% Input:
%	distmat: all distances between the cells
%	cluster_info: indicates the cluster number for the cell considered
%
%
%============================================
% define colors based on cluster number
%============================================
%
X1Y1_cols = [
	0.0, 	1, 	1;      %cyan
	0.36,   0.61,    0; %green
	0.8,    0,       1.0;  %3 purple 
	1,      0.,      0.0; %red
	0,	0,	0; %5 black
        0.8,    0.8,    0;
    ];

%
%============================================
% Size of the problem
%============================================
%
N=max(size(cluster_info));

%
%============================================
% Assign colors
%============================================
%
for iCell = 1:N
	color(iCell,:) = X1Y1_cols(cluster_info(iCell), :); 
end
%
%============================================
% Perform MDS
%============================================
%
[Y e]=cmdscale(distmat,2);
t = sum(e);
e = 100*e./t;
%
%============================================
% Generate figure
%============================================
%
figure
hold on
for iCell = 1:N
	plot(Y(iCell,1),Y(iCell,2), 'o','Color',color(iCell,:), 'LineWidth',2.0);
end
xticks([])
yticks([])
xlabel(['PC1 (' num2str(e(1)) '%)'])
ylabel(['PC2 (' num2str(e(2)) '%)'])
set(gca,'FontName','TimesNewRoman','FontSize',14)
