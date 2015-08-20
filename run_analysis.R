## run_analysis.R
##
## Description: Script for reading the raw data of the 'Human Activity Recognition Using Smartphones' dataset
## and producing a tidy dataset
##
## Purpose: Course project of 'Getting and Cleaning Data' course (https://class.coursera.org/getdata-031)
##
## Notes:
##   - The script produces two files:
##     - tidy/tidy_all.txt: This is the result of the merging and cleaning of the original data. It contains
##       as many data rows as there are in the test and training datasets (2947 + 7352 = 10299) and 68 columns (see codebook).
##     - tidy/tidy_avg.txt: This file contains average of each variable in the clean dataset for each activity and each subject. It contains
##       180 data rows (30 subjects x 6 types of activities) and 68 columns (see codebook).


raw.dataset.dir <- 'raw/UCI HAR Dataset'
tidy.data.dir <- 'tidy'


## Step 1: Make sure that the raw data is available
source('./get_raw_data.R')


## Step 2: Read raw data

# Read activity labels
activity.labels <- read.table(file.path(raw.dataset.dir, 'activity_labels.txt'))
names(activity.labels) <- c('activityId', 'activity')

# Read feature labels
feature.labels <- read.table(file.path(raw.dataset.dir, 'features.txt'))
names(feature.labels) <- c('featureId', 'feature')

# Read training data
train.subjects <- read.table(file.path(raw.dataset.dir, 'train/subject_train.txt'))
train.activities <- read.table(file.path(raw.dataset.dir, 'train/y_train.txt'))
train.feature.vectors <- read.table(file.path(raw.dataset.dir, 'train/X_train.txt'))

# Read testing data
test.subjects <- read.table(file.path(raw.dataset.dir, 'test/subject_test.txt'))
test.activities <- read.table(file.path(raw.dataset.dir, 'test/y_test.txt'))
test.feature.vectors <- read.table(file.path(raw.dataset.dir, 'test/X_test.txt'))


## Step 3: Merge training and test datasets

# Merge subjects of training and testing dataset
all.subjects <- rbind(train.subjects, test.subjects)
names(all.subjects) <- 'subjectId'

# Merge activities of training and testing dataset
all.activities <- rbind(train.activities, test.activities)
names(all.activities) <- 'activityId'

# use transform() to construct an 'activity' column for the 'all.activities' data frame
all.activities <- transform(all.activities, activity = activity.labels[activityId, 'activity'])

# Merge feature vectors of training and testing dataset
all.feature.vectors <- rbind(train.feature.vectors, test.feature.vectors)


## Step 4: Add labels in the merged dataset that contains the feature vectors

names(all.feature.vectors) <- feature.labels$feature


## Step 5: Extract only measurements on the mean and standard deviation for each record

# Get the features that have 'mean()' or 'std()' in their name
features.to.extract <- feature.labels[grep('mean\\(\\)|std\\(\\)', feature.labels$feature, ignore.case = TRUE), ]
feature.ids.to.extract <- features.to.extract$featureId

# Create a new data frame from 'all.feature.vectors' with only the selected features
measurements <- all.feature.vectors[, feature.ids.to.extract]


## Step 6: Produce new labels for the extracted measurements

# Produce new feature names by dropping the parentheses and replacing dashes with dots
features.to.extract.enhanced <- transform(features.to.extract, featureLabel = gsub(pattern = '[()]', x = feature, replacement = ''))
features.to.extract.enhanced <- transform(features.to.extract.enhanced, featureLabel = gsub(pattern = '-', x = featureLabel, replacement = '.'))


## Step 7: Set the new labels to the merged dataset that contains the feature vectors.

names(measurements) <- features.to.extract.enhanced$featureLabel


## Step 8: Add subject and activity information in the dataset containing the measurements

measurements <- transform(measurements, subjectId = all.subjects$subjectId, activity = all.activities$activity)


## Step 9: Create a dataset with the average of each variable for each activity and each subject

measurements.agg <- aggregate(. ~ subjectId + activity, data = measurements, FUN = mean)


## Step 10. Write tidy dataset to files

write.table(measurements, file.path(tidy.data.dir, 'tidy_all.txt'), row.names = FALSE)
write.table(measurements.agg, file.path(tidy.data.dir, 'tidy_avg.txt'), row.names = FALSE)
