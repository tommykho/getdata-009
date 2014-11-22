# Course Project getdata-009
# Written by tommyho510@gmail.com
#
# Source of data for this project: 
#	  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# To run this script:
#   A. Download the above zip file into a directory, such as
#     c:\getdata-009\Course Project
#   B. Extract the zip file
#     c:\getdata-009\project\UCI HAR Dataset
#   C. Save this file 'run_analysis.R' to the same folder
#     c:\getdata-009\project\UCI HAR Dataset
#   D. Run 'setwd("C:/getdata-009/Course Project/UCI HAR Dataset/")'
#   E. Run 'source("run_analysis.R")'
#
# What you expect:
#   F. Result of the data table will be shown in 5 minutes
#   G. You can also view the result using 'View(result)"
#   F. The result can be saved as the filename stated as outputName, by removing the comment of the last line

outputName <- "tidy_data_set.txt"

### Beginning of the script ###

# step 1...
print("1. Merges the training and the test sets to create one data set (may take up to 4 minutes)...")
X <- rbind(read.table("train/X_train.txt"), read.table("test/X_test.txt"))
Y <- rbind(read.table("train/y_train.txt"), read.table("test/y_test.txt"))
S <- rbind(read.table("train/subject_train.txt"), read.table("test/subject_test.txt"))

# step 2...
print("2. Extracts only the measurements on the mean and standard deviation for each measurement...")
features <- read.table("features.txt")
features_of_interest <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
X <- X[, features_of_interest]
names(X) <- features[features_of_interest, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# step 3...
print("3. Uses descriptive activity names to name the activities in the data set...")
activities <- read.table("activity_labels.txt")
activities[, 2] <- gsub("_", " ", tolower(as.character(activities[, 2])))
Y[,1] <- activities[Y[,1], 2]
names(Y) <- "activity"

# step 4...
print("4. Appropriately labels the data set with descriptive activity names...")
names(S) <- "subject"
tbCombined <- cbind(S, Y, X)

# step 5...
print("5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject...")
uniqueSubjects <- unique(S)[,1]
numSubjects <- length(unique(S)[,1])
numActivities <- length(activities[,1])
numCols <- dim(tbCombined)[2]
result <- tbCombined[1:(numSubjects*numActivities), ]

## applying colMeans on each unique row...
row = 1
for (s in 1:numSubjects) {
    for (a in 1:numActivities) {
        result[row, 1] = uniqueSubjects[s]
        result[row, 2] = activities[a, 2]
        tmp <- tbCombined[tbCombined$subject==s & tbCombined$activity==activities[a, 2], ]
        result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
        row = row+1
    }
}

# remove old data tables to save memory...
remove(S)
remove(X)
remove(Y)
remove(activities)
remove(features)
remove(tmp)

# saving result into a file...
print("Saving result...")
write.table(result, outputName, row.name=FALSE)

# show result...
print("Showing result...")
View(result)

### End of the script ###