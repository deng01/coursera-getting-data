# Coursera Getting and Cleaning Data
# 1. Merges the training and the test sets to create on data set
# 2. Extracts only the measurements on the man and standard deviation for each measurement
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names.
# 5. From the data set in step 4, create a second, independent tidy data set with the average of 
#	each variable ofr each activity and each subject

library(plyr)
library(dplyr)

merge.datasets <- function() {
	
	# Read in the data
	train.x <- read.table("UCI HAR Dataset/train/X_train.txt")
	train.y <- read.table("UCI HAR Dataset/train/y_train.txt")
	train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
	test.x <- read.table("UCI HAR Dataset/test/X_test.txt")
	test.y <- read.table("UCI HAR Dataset/test/y_test.txt")
	test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
	
	# Merge the data
	x <- rbind(train.x, test.x)
	y <- rbind(train.y, test.y)
	subject <- rbind(train.subject, test.subject)
	
	# Return the data
	list(x=x, y=y, subject=subject)
}

extract.mean.std <- function(df) {
  # Extract on the mean and standard deviation for each measurement
  
  # Read in the feature list
  features <- read.table("UCI HAR Dataset/features.txt")
  
  # Find the mean and std columns
  mean.col <- sapply(features[,2], function(x) grepl("mean()", x, fixed=TRUE))
  std.col  <- sapply(features[,2], function(x) grepl("std()", x, fixed=TRUE))
  
  # Extract
  extract.df <- df[, (mean.col | std.col)]
  colnames(extract.df) <- features[(mean.col | std.col), 2]
  extract.df
}

label.activities <- function(df) {
  # Apply descriptive names
  
  colnames(df) <- "activity"
  df$activity[df$activity==1] <- "WALKING"
  df$activity[df$activity==2] <- "WALKING_UPSTAIRS"
  df$activity[df$activity==3] <- "WALKING_DOWNSTAIRS"
  df$activity[df$activity==4] <- "SITTING"
  df$activity[df$activity==5] <- "STANDING"
  df$activity[df$activity==6] <- "LAYING"
  df
}

main <- function() {
  # Merge the dataset
  merged <- merge.datasets()
  
  # Extract only the mean and standard deviation for each measurment
  x.mean.std <- extract.mean.std(merged$x)
  
  # Label the activities
  y.activities <- label.activities(merged$y)
  
  # Label the subjects
  colnames(merged$subject) <-c("subject")
  
  # Combine into one dataframe
  combined <- cbind(x.mean.std, y.activities, merged$subject)
  
  # Create tidy dataset
  tidy <- ddply(combined, .(subject, activity), function(x) colMeans(x[,1:60]))
  
  # Write as csv
  write.table(tidy, "UCI_HAR_tidy.txt", row.names=FALSE)
}
	
main()
