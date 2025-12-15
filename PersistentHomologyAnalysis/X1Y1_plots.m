data = readtable('X1Y1/X1Y1_distances.csv');
data.Properties.RowNames = data.Var1;
data=removevars(data, "Var1");
numericData = table2array(data);
clusterAssignmentsX1=readtable("mlab_clusters_X1.csv")
clusterAssignmentsX1.Properties.RowNames = clusterAssignmentsX1.Row
clusterAssignmentsX1=removevars(clusterAssignmentsX1, "Row");
%============================================
% Perform MDS
%============================================
%
[Y e]=cmdscale(numericData,2);

figure
hold on
for iLeaf=1:N
    plot(Y(iLeaf,1),Y(iLeaf,2), 'o','Color',numericData_color(iLeaf,:), 'LineWidth',1.5);
end
xticks([])
% yticks([])
xlabel({"X1+Y1 MDS"});
% yticklabels({});
box on
gca.LineWidth=1;
% savefig("numericData_mds.fig")
%%
figure
hold on
[Y e]=cmdscale(numericData,2);
X1_cols = [
    1.0000, 0,      0;      % Red
    0.0 1.0 1.0;      % Yellow-Green
    0.3600,    0.6100,         0; % Green
    
    0.8000, 0,      1.0000; % Purple
    1,      0.000, 0.0000; % Red
    0,      0,      0       % Black
    ];
% X1_cols = hsv(5);
% [0.36 0.61 0.00][0.5 1.0 0]
for i = 1:N
    cell = data.Properties.RowNames{i};
    if contains(cell, "Y1")
         if cell == "Y1_215"
             plot (Y(i,1),Y(i,2), "o", "MarkerFaceColor", [0.8,0.8,0], "MarkerEdgeColor", [0.8,0.8,0], 'LineWidth',1.5);
             text(Y(i,1),Y(i,2), "Y1\_215")
         elseif cell == "Y1_222"
             plot (Y(i,1),Y(i,2), "o", "MarkerFaceColor", [0.8,0.8,0], "MarkerEdgeColor", [0.8,0.8,0], 'LineWidth',1.5);
             text(Y(i,1),Y(i,2), "Y1\_222")
        else
            plot (Y(i,1),Y(i,2), "o",  "MarkerEdgeColor", [0.8,0.8,0], 'LineWidth',1.5);
        end
    elseif contains(cell, "X1")
           % X1_rowId = strcmp(clusterAssignmentsX1.Properties.RowNames, cell);
           clusId = clusterAssignmentsX1{cell, "Cluster"}+1;
           X1_cols(clusId,:)
           
           if cell == "X1_108"
               text(Y(i,1),Y(i,2), "X1\_108")
               plot (Y(i,1),Y(i,2), "o", "MarkerFaceColor", X1_cols(clusId,:), "MarkerEdgeColor", X1_cols(clusId,:), 'LineWidth',1.5);
           elseif cell == "X1_015"
               text(Y(i,1),Y(i,2), "X1\_015")
               plot (Y(i,1),Y(i,2), "o", "MarkerFaceColor", X1_cols(clusId,:), "MarkerEdgeColor", X1_cols(clusId,:), 'LineWidth',1.5);
           elseif cell == "X1_129"
               plot (Y(i,1),Y(i,2), "o", "MarkerFaceColor", X1_cols(clusId,:), "MarkerEdgeColor", X1_cols(clusId,:), 'LineWidth',1.5);
               text(Y(i,1),Y(i,2), "X1\_129")
           else 
               plot (Y(i,1),Y(i,2), "o",  "MarkerEdgeColor", X1_cols(clusId,:), 'LineWidth',1.5);
           end
    end
end
