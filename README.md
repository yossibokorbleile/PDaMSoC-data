# PDaMSoC-data
[![DOI](https://zenodo.org/badge/747212765.svg)](https://doi.org/10.5281/zenodo.16760102)

This repository contains the datasets and analysis code from the paper:

**[Persistence diagrams as morphological signatures of cells: A method to measure and compare cells within a population](https://files.yossi.eu/manuscripts/2310.20644.pdf)**  
*Yossi Bokor Bleile, Pooja Yadav, Patrice Koehl, and Florian Rehfeldt*

## Overview

The repository includes:
- Raw microscopy images and cell contours for four datasets (`X1`, `X2`, `X3`, `Y1`)
- Pre-computed persistence diagrams and distance matrices
- A Jupyter notebook (`analysis.ipynb`) that reproduces the persistent homology computations, and MATLAB files that reproduce the figures from the paper.

## Directory Structure
There are four directories, `X1`, `X2`, `X3`, and `Y1`. In each directory, there are sub-directories `cell` and `nucleus`, and a file `Nuc_Cm_{DIRECTORY}.csv`, which contains the coordinates of the center of mass for each nucleus. 

The datasets `X1`, `X2`, `X3` consist of adult human mesenchymal stem cells (hMSCs) purchased from Lonza $PT-2501$ Basel, Switzerland, and `Y1` consists of HeLa cells Leibniz Institute, DSMZ, ACC 57, RRID:CVCL 0030, see `Materials and Methods` section of [Persistence diagrams as morphological signatures of cells: A method to measure and compare cells within a population](https://files.yossi.eu/manuscripts/2310.20644.pdf) for more information about how the were cultured, and how the images were obtained.

In `cell`, there is folder `raw_images` which contains the raw image as a `.tif` file for each cell, and in `contours` there is a `.csv` containing the contour of the cell as obtained using [FilamentSensor2](https://filament-sensor.de/). It is important to note that [FilamentSensor2](https://filament-sensor.de/) will produce many more files, including ones with `interior_contour` in the name, which we do not use in our analysis, and have thus not included in this repository. Also [FilamentSensor2](https://filament-sensor.de/) creates new directories when run, which is different to the structure and nomenclature in this repository. 

In `nucleus` there is a single sub-directory `raw_images` which contains a `.tif` file for each cell. Within in main directory `X1`, `X2`, `X3` and `Y1` each file has a unique ID, which is used in all files related to it. In paricular, the `.tif` files have the same names, but are in different sub-directories.

For information about running the notebook, see [README](PersistentHomologyAnalysis/README.md).

