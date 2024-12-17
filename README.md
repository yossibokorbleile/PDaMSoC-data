# PDaMSoC-data
This repository contains the data sets from the paper [Persistence diagrams as morphological signatures of cells: A method to measure and compare cells within a population](https://files.yossi.eu/manuscripts/2310.20644.pdf) by Yossi Bokor Bleile, Patrice Koehl, and Florian Rehfeldt, as well as a Jupyter Notebook which reproduces the analysis from the paper.

To run the notebook, the following Python packages will need to be installed:
- [Correa](correa.yossi.eu)
- plotly
- pandas
- sklearn
- numpy
- matplotlib

In the directory `X1` are the files relating to data set $X1$ analysed in the paper. For each cell, there are two files, one contained in the `X1/nucleus` directory and the other in the `X1/cell` directory. The `.tif` files in `X1/nucleus` are all even numbers, and the files `X1/cell` are all odd numbers, with the nucleus `(n).tiff` corresponding to the file `(n+1).tiff`, where leading `0`'s are added to make `(n)` and `(n+1)` are three digit numbers.

These `.tif` files can be processed with [FilamentSensor](https://filament-sensor.de/) to obtain the `.csv` files in `X1/cell/csv_contour` and `X1/nucleus/csv_contour`, which for convenience are contained in this repository.  Using the files in `X1/nucleus` we can also obtain the center of the nucleus for each cell, which is contained in `X1/Nuc_area_Cm_X1.xlsx`.

With all of this data, we used the Python package [Correa](correa.yossi.eu) to obtain a persistence diagram for each cell, using the center of the nucleus for the base of the radial filtration function. After this, we constructed a (dis)similarity matrix using the $2$-Wasserstein distance as our (dis)similarity score, before using  agglomerative hierarchical clustering analysis (HCA) with four different linkage schemes: 

1. average 
2. complete
3. single
4. Ward

Other data sets we have analysed are in the `X2` and `X3` directories, with the same structure as `X1`.

In the notebook `analysis.ipynb` we have reproduced the analysis from the paper.