## get_raw_data.R
##
## Description: Script for downloading the raw data of the 'Human Activity Recognition Using Smartphones' dataset
## (see http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
##
## Purpose: Course project of 'Getting and Cleaning Data' course (https://class.coursera.org/getdata-031)
##

library(curl)

# Check if the 'UCI HAR Dataset' directory exists under 'raw'; if not, download the raw dataset
if (!file.exists("raw/UCI HAR Dataset")) {
    raw.data.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    raw.data.zip.filename <- "raw/UCI_HAR_data.zip"

    h <- new_handle()
	handle_setopt(h, ssl_verifypeer = FALSE)

	curl_download(url = raw.data.url, destfile = raw.data.zip.filename, handle = h)

    unzip(zipfile = raw.data.zip.filename, exdir="raw")
}

