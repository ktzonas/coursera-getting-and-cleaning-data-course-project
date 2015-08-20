Getting and Cleaning Data Course Project
========================================

This document describes the steps of the cleaning process that has been implemented in ```run_analysis.R```, and also the columns of the resulting datasets.

### Steps of the cleaning process

  1. Make sure that the raw data is available; if not, download end extract the [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) with the raw data.
  2. Read raw data into data frames:
    -  ```activity.labels```: Data frame with 6 rows (as many as the different types of activities that were performed by the subject) and 2 columns:
      - ```activityId```: Activity identifier (numeric)
      - ```activity```: Activity name
    -  ```feature.labels```: Data frame with 561 rows, one, for each of the 561 features that were produced in the original dataset, and two columns:
      - ```featureId```: Feature identifier (numeric) that refers to the position of the feature in the original datasets.
      - ```feature```: Feature name, as found in ```features.txt```
    -  Training data:
      - ```train.feature.vectors```: Contains 7352 measurements of 561 features
      - ```train.subjects```: Contains the ID of the subject for each of the 7352 measurements
      - ```train.activities```: Contains the ID of the activity performed by the subject for each of the 7352 measurements
    - Test data:
      - ```test.feature.vectors```: Contains 2947 measurements of 561 features
      - ```train.subjects```: Contains the ID of the subject for each of the 2947 measurements
      - ```train.activities```: Contains the ID of the activity performed by the subject for each of the 2947 measurements
  3. Merge training and test datasets. This produces the following data frames:
    - ```all.feature.vectors```: Contains 10299 measurements of 561 features
    - ```all.subjects```: Contains the ID of the subject for each of the 10299 measurements
    - ```all.activities```: Contains the ID of the activity performed by the subject for each of the 10299 measurements
  4. Add labels in the merged dataset that contains the feature vectors.
    - Use ```feature.labels``` to set labels for ```all.feature.vectors```. 
  5. Extract only measurements on the mean and standard deviation for each record. The features that are extracted are the the ones whose name contains either ```mean()``` or ```std()```. There are 66 features matching these criteria. This produces the ```measurements``` data frame, which contains the same rows as ```all.feature.vectors```, but only the 66 columns that we are interested in.
  6. Produce new labels for the extracted measurements by dropping the parentheses and replacing dashes with dots. So, for example, ```tBodyAcc-mean()-X``` is converted to ```tBodyAcc.mean.X```. A mapping of the old labels to the new labels is kept in ```features.to.extract.enhanced```.
  7. Set the new labels to the merged dataset that contains the feature vectors. Applies the new labels found in ```features.to.extract.enhanced``` to ```measurements```.
  8. Add subject and activity information in the dataset containing the measurements. This adds two columns, ```subjectId``` and ```activity```, to the ```measurements``` data frame, so there are 68 columns in total. The subject and activity information is copied from ```all.subjects``` and ```all.activities```.
  9. Create a dataset with the average of each variable for each activity and each subject. The resulting data frame (```measurements.agg```) contains 180 rows (30 subjects x 6 types of activities that were performed).
  10. Write tidy dataset to files:
    - ```tidy/tidy_all.txt``` contains the data of the dataset produced in step 8 (```measurements```).
    - ```tidy/tidy_avg.txt``` contains the data of the dataset produced in step 9 (```measurements.agg```).


### Columns in the tidy dataset

  - ```subjectId```
  - ```activity```
  - ```tBodyAcc.mean.X```
  - ```tBodyAcc.mean.Y```
  - ```tBodyAcc.mean.Z```
  - ```tBodyAcc.std.X```
  - ```tBodyAcc.std.Y```
  - ```tBodyAcc.std.Z```
  - ```tGravityAcc.mean.X```
  - ```tGravityAcc.mean.Y```
  - ```tGravityAcc.mean.Z```
  - ```tGravityAcc.std.X```
  - ```tGravityAcc.std.Y```
  - ```tGravityAcc.std.Z```
  - ```tBodyAccJerk.mean.X```
  - ```tBodyAccJerk.mean.Y```
  - ```tBodyAccJerk.mean.Z```
  - ```tBodyAccJerk.std.X```
  - ```tBodyAccJerk.std.Y```
  - ```tBodyAccJerk.std.Z```
  - ```tBodyGyro.mean.X```
  - ```tBodyGyro.mean.Y```
  - ```tBodyGyro.mean.Z```
  - ```tBodyGyro.std.X```
  - ```tBodyGyro.std.Y```
  - ```tBodyGyro.std.Z```
  - ```tBodyGyroJerk.mean.X```
  - ```tBodyGyroJerk.mean.Y```
  - ```tBodyGyroJerk.mean.Z```
  - ```tBodyGyroJerk.std.X```
  - ```tBodyGyroJerk.std.Y```
  - ```tBodyGyroJerk.std.Z```
  - ```tBodyAccMag.mean```
  - ```tBodyAccMag.std```
  - ```tGravityAccMag.mean```
  - ```tGravityAccMag.std```
  - ```tBodyAccJerkMag.mean```
  - ```tBodyAccJerkMag.std```
  - ```tBodyGyroMag.mean```
  - ```tBodyGyroMag.std```
  - ```tBodyGyroJerkMag.mean```
  - ```tBodyGyroJerkMag.std```
  - ```fBodyAcc.mean.X```
  - ```fBodyAcc.mean.Y```
  - ```fBodyAcc.mean.Z```
  - ```fBodyAcc.std.X```
  - ```fBodyAcc.std.Y```
  - ```fBodyAcc.std.Z```
  - ```fBodyAccJerk.mean.X```
  - ```fBodyAccJerk.mean.Y```
  - ```fBodyAccJerk.mean.Z```
  - ```fBodyAccJerk.std.X```
  - ```fBodyAccJerk.std.Y```
  - ```fBodyAccJerk.std.Z```
  - ```fBodyGyro.mean.X```
  - ```fBodyGyro.mean.Y```
  - ```fBodyGyro.mean.Z```
  - ```fBodyGyro.std.X```
  - ```fBodyGyro.std.Y```
  - ```fBodyGyro.std.Z```
  - ```fBodyAccMag.mean```
  - ```fBodyAccMag.std```
  - ```fBodyBodyAccJerkMag.mean```
  - ```fBodyBodyAccJerkMag.std```
  - ```fBodyBodyGyroMag.mean```
  - ```fBodyBodyGyroMag.std```
  - ```fBodyBodyGyroJerkMag.mean```
  - ```fBodyBodyGyroJerkMag.std```

