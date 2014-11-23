getdata-009
===========
Coursera Course Project: Getting and Cleaning Data (getdata-009)
CODEBOOK

Written by tommyho510@gmail.com
===========
This file describes the variables, the data, and any transformations or work that you performed to clean up the data

```r
X <- combine the data table	`train/X_train.txt` and `test/X_test.txt` using `rbind`
Y <- combine the data table	`train/y_train.txt` and `test/y_test.txt` using `rbind`
S <- combine the data table	`train/subject_train.txt` and `test/subject_test.txt` using `rbind`
X <- extract the data table from the `features_of_interest` from `featuress.txt` 
Y <- extract the labels from the `activities_labels.txt`
tbCombined <- combine the data table S, Y, X
numSubjects <- length of unique 1st column of S
numActivities <- length of 1st column of activities
numCols <- number of column of tbCombined
result <- 
	uniqueSubjects in the 1st column 
	activities in the 2nd column
	colMeans of each item for the rest of the columns
outputName <- file to be saved
```
