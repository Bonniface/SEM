## Description
This project aims to analyze and visualize the USAGE dataset, which contains information about various attributes of individuals. The dataset consists of 418 rows and 37 columns, including both discrete and continuous variables. The project utilizes various R packages for data manipulation, visualization, and analysis.

## Installation
To run this project, make sure you have R and the required packages installed. You can install the necessary packages by running the following command in your R console:

## R
# Copy code
install.packages(c("rio", "here", "tidyverse", "tsibble", "survey", "srvyr", "gtsummary", "apyramid", "patchwork", "ggforce", "tinytex", "dplyr", "mice", "VIM", "DMwR2", "arsenal", "kableExtra", "ggplot2", "readxl", "DataExplorer", "R4EPI/sitrep"))
Usage
Make sure you have the dataset file "USAGE.xlsx" in your working directory.
Run the code in the provided R script.
The code will load the required packages, read the dataset, and perform various analyses and visualizations.
The results will be displayed in the R console and saved as plots or tables.
## Results
# The project generates the following results:

Summary information about the dataset, including the number of rows, columns, missing values, and data types.
Plots to visualize the dataset, including an introduction plot and a missing value percentage plot.
Data cleaning and preprocessing steps, such as dropping columns with high missing value percentages.
Analysis and visualization of selected columns, including bar plots and an age pyramid.
Calculation and visualization of individual ratings of the Mobile Renewal Service.
Analysis of the frequency of combinations of gender and employment status.
Summary tables of variables and their relationships.
Likert scale analysis and the definition of latent variables.
Model evaluation and assessment of fit indices.
# Credits
This project is created by Boniface Kalong.
