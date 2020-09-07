# The Code Book for the project

## Data source

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. 
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## R script

File with R code "run_analysis.R" performs the 5 following steps (in accordance assigned task of course work):

- Load the libraries "dplyr" and "data.table".
- Download and unzip the data from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

- Read and assign data to variables:
"features", "activities", "subject_test", "x_test", "y_test", "subject_train", "x_train", "y_train"

- Merges the training and the test sets to create one data set.
3 variables are created: "train_data" is the union of the train data set, "test_data" is the union of the test data set, "merge_data" is the union of the previous variables.

- Extracts only the measurements on the mean and standard deviation for each measurement.
1 variable is created: "meanstd_data" with the subject, code, mean and the standard desviation.

- Uses descriptive activity names to name the activities in the data set.

- Appropriately labels the data set with descriptive variable names.

- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
1 variable is created: "tidy_data" and 1 .txt file is generated: "tidy_data.txt"

