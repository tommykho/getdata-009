getdata-009
===========

Coursera Course Project: Getting and Cleaning Data (getdata-009)
Written by tommyho510@gmail.com

Source of data for this project: 
`https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`

To run this script:
* Download the above zip file into a directory, such as `c:\getdata-009\Course Project`
* Extract the zip file to `c:\getdata-009\project\UCI HAR Dataset`
* Save the file `run_analysis.R` to the same folder `c:\getdata-009\project\UCI HAR Dataset`
* Run `setwd("C:/getdata-009/Course Project/UCI HAR Dataset/")`
* Run `source("run_analysis.R")`

What you expect:
* Result of the data table will be shown in 5 minutes
* The result will be saved as the filename stated as `tidy_data_set.txt`
* You can also view the result using `View(result)`

What the script do...

1. Merges the training and the test sets to create one data set (may take up to 4 minutes)...
  ```r
  X <- rbind(read.table("train/X_train.txt"), read.table("test/X_test.txt"))
  Y <- rbind(read.table("train/y_train.txt"), read.table("test/y_test.txt"))
  S <- rbind(read.table("train/subject_train.txt"), read.table("test/subject_test.txt"))
  ```
2. Extracts only the measurements on the mean and standard deviation for each measurement...
  ```r
  features <- read.table("features.txt")
  features_of_interest <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
  X <- X[, features_of_interest]
  names(X) <- features[features_of_interest, 2]
  names(X) <- gsub("\\(|\\)", "", names(X))
  names(X) <- tolower(names(X))
  ```
3. Uses descriptive activity names to name the activities in the data set...
  ```r
  activities <- read.table("activity_labels.txt")
  activities[, 2] <- gsub("_", " ", tolower(as.character(activities[, 2])))
  Y[,1] <- activities[Y[,1], 2]
  names(Y) <- "activity"
  ```
4. Appropriately labels the data set with descriptive activity names...
  ```r
  names(S) <- "subject"
  tbCombined <- cbind(S, Y, X)
  ```
5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject...
  ```r
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
  ```
6. Remove old data tables to save memory, show and save result as tidy_data.txt
  ```r
  remove(S)
  remove(X)
  remove(Y)
  remove(activities)
  remove(features)
  remove(tmp)
  
  print("Saving result...")
  write.table(result, outputName, row.name=FALSE)
  
  print("Showing result...")
  View(result)
  ```
