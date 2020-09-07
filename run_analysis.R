# load the packages
library(dplyr)
library(data.table)

# download and unzip data
f <- "UCI HAR Dataset.zip"

if (!file.exists(f)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, f, method = "curl", mode = 'wb')
  unzip(f)
}

# read and assign data to variables
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# 1 - Merges the training and the test sets to create one data set.
train_data <- cbind(subject_train, x_train, y_train)  
test_data <- cbind(subject_test, x_test, y_test)  
merge_data <- rbind(train_data, test_data)

# 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
meanstd_data <- merge_data %>% select(subject, code, contains("mean"), contains("std"))

# 3 - Uses descriptive activity names to name the activities in the data set
meanstd_data$code <- activities[meanstd_data$code, 2]

# 4 - Appropriately labels the data set with descriptive variable names.
names(meanstd_data)[2] = "activity"
names(meanstd_data)<-gsub("Acc", "Accelerometer", names(meanstd_data))
names(meanstd_data)<-gsub("Gyro", "Gyroscope", names(meanstd_data))
names(meanstd_data)<-gsub("BodyBody", "Body", names(meanstd_data))
names(meanstd_data)<-gsub("Mag", "Magnitude", names(meanstd_data))
names(meanstd_data)<-gsub("^t", "Time", names(meanstd_data))
names(meanstd_data)<-gsub("^f", "Frequency", names(meanstd_data))
names(meanstd_data)<-gsub("tBody", "TimeBody", names(meanstd_data))
names(meanstd_data)<-gsub("-mean()", "Mean", names(meanstd_data), ignore.case = TRUE)
names(meanstd_data)<-gsub("-std()", "STD", names(meanstd_data), ignore.case = TRUE)
names(meanstd_data)<-gsub("-freq()", "Frequency", names(meanstd_data), ignore.case = TRUE)
names(meanstd_data)<-gsub("angle", "Angle", names(meanstd_data))
names(meanstd_data)<-gsub("gravity", "Gravity", names(meanstd_data))

# 5 - From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data <- meanstd_data %>%
    group_by(subject, activity) %>%
    summarise_all(list(mean))
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)
