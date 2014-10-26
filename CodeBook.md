# Introduction

The script `run_analysis.R`

- Assumes the dataset Human Activity Recognition Using Smartphones Data Set [UCI Machine Learning repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) has been downloaded into your current directory.

- This data is located atdownloads data from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

- Merges the training and test sets into one data set.

- Replaces activity values with descriptive activity names.

- Extracts the mean and standard deviation for each measurement

- Labels the columns with descriptive names

- Creates a independent tidy dataset with an average for each variable for each activity and subject.

# Original Dataset

The original dataset has been partitioned into two sets (70% training and 30% test)

# Tidy Dataset
The first step is to merge the training and test sets.

After the merge operation, mean and standard deviation features are extracted for further processing.

Activity labels are replaced with descriptive activity names, defined in `activity_labels.txt`

The final step creates a tidy dataset with the average for each variable for each activity and subject.
