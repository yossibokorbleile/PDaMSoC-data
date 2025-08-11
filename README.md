# PDaMSoC-data
This repository contains the data sets from the paper [Persistence diagrams as morphological signatures of cells: A method to measure and compare cells within a population](https://files.yossi.eu/manuscripts/2310.20644.pdf) by Yossi Bokor Bleile, Pooja Yadav, Patrice Koehl, and Florian Rehfeldt, as well as a Jupyter Notebook which reproduces the analysis from the paper.

To run the notebook, the following Python packages will need to be installed:
- [Correa](correa.yossi.eu)
- plotly
- pandas
- sklearn
- numpy
- matplotlib

There are four directories, `X1`, `X2`, `X3`, and `Y1`. In each directory, there are sub-directories `cell` and `nucleus`, and a file `Nuc_Cm_{DIRECTORY}.csv`, which contains the coordinates of the center of mass for each nucleus. 

The datasets `X1`, `X2`, `X3` consist of adult human mesenchymal stem cells (hMSCs) purchased from Lonza $\#PT-2501$ Basel, Switzerland, and `Y1` consists of HeLa cells Leibniz Institute, DSMZ, ACC 57, RRID:CVCL 0030, see `Materials and Methods` section of [Persistence diagrams as morphological signatures of cells: A method to measure and compare cells within a population](https://files.yossi.eu/manuscripts/2310.20644.pdf) for more information about how the were cultured, and how the images were obtained.

In `cell`, there is folder `raw_images` which contains the raw image as a `.tif` file for each cell, and in `contours` there is a `.csv` containing the contour of the cell as obtained using [FilamentSensor2](https://filament-sensor.de/). It is important to note that [FilamentSensor2](https://filament-sensor.de/) will produce many more files, including ones with `interior_contour` in the name, which we do not use in our analysis, and have thus not included in this repository. Also [FilamentSensor2](https://filament-sensor.de/) creates new directories when run, which is different to the structure and nomenclature in this repository. 

In `nucleus` there is a single sub-directory `raw_images` which contains a `.tif` file for each cell. Within in main directory `X1`, `X2`, `X3` and `Y1` each file has a unique ID, which is used in all files related to it. In paricular, the `.tif` files have the same names, but are in different sub-directories.

With all of this data, we used the Python package [Correa](correa.yossi.eu) to obtain a persistence diagram for each cell, using the center of the nucleus for the base of the radial filtration function. After this, we constructed a (dis)similarity matrix using the $2$-Wasserstein distance as our (dis)similarity score, before using  agglomerative hierarchical clustering analysis (HCA) with four different linkage schemes: 

1. average 
2. complete
3. single
4. Ward

Other data sets we have analysed are in the `X2` and `X3` directories, with the same structure as `X1`.

In the notebook `analysis.ipynb` we have reproduced the analysis from the paper.