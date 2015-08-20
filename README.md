Getting and Cleaning Data Course Project
========================================

This repository contains R code for downloading and tidying the 
[Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones),
according to instructions given for the course project of the [Getting and Cleaning Data course](https://class.coursera.org/getdata-031).

Contents
--------

  - ```run_analysis.R```: The script that produces the tidy data set.
  - ```CodeBook.md```: Contains descriptions of the steps performed in ```run_analysis.R```, 
    as well as the list of produced fields of the tidy data set.
  - ```raw/```: The directory that is expected to contain the raw data set.
  - ```tidy/```: The directory where the text file containing the tidy data is saved
  - ```get_raw_data.R```: This script checks the existence of the raw data
    (actually, just the existence of the ```raw/UCI HAR Dataset``` directory).
    If necessary, it downloads and extracts the zip file containing the files of the raw data set. 
    The zip file is saved and extracted under the ```raw``` folder. 
    This script is invoked by ```run_analysis.R``` to ensure the existence of the raw data.
    However, you can also use it (by ```source()```ing it) if you just want the raw data, without
    having to start the cleaning process.


Notes
------------

  - ```run_analysis.R``` produces two files:
    - ```tidy/tidy_all.txt```: This is the result of the merging and cleaning of the original data. It contains as many data rows as there are in the test and training datasets (2947 + 7352 = 10299) and 68 columns (see ```CodeBook.md```).
    - ```tidy/tidy_avg.txt```: This file contains average of each variable in the clean dataset for each activity and each subject. It contains 180 data rows (30 subjects x 6 types of activities) and 68 columns (see ```CodeBook.md```).
  - If you already have downloaded [the zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) with the raw data, then make sure to extract it under the ```raw``` directory so that ```run_analysis.R``` picks up your copy of the data and does not attempt to download it again.