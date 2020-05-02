# 0) Load Packages and get the Data
library(reshape2)
RawData <- "UCI_HAR_Dataset.zip"
urlRawData <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
outDir = "UCI_HAR_Data"

if (!file.exists(RawData)) {
  download.file(url = urlRawData,RawData)
}

if (!file.exists(outDir)) { 
  unzip(RawData) 
}

#1.Merges the training and the test sets to create one data set.

# Data train 
data_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
target_train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Data test 
data_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
target_test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Merging
data <- rbind(data_train, data_test)
target_data <- rbind(target_train, target_test)
subject_data <- rbind(subject_train, subject_test)
features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("ID", "activity"))

names(subject_data) = "subject"
names(target_data) = "activity"
colnames(data) <- features[,2]

dim(train_data)
dim(target_data)
dim(subject_data)

df = cbind(data,target_data,subject_data)
colnames(df)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
featuresMeanSd<-grep("mean\\(\\)|std\\(\\)", colnames(df))

df_subset_Mean_std <-subset(df,select=c(featuresMeanSd,subject,activity))

colnames(df_subset)

#3.Uses descriptive activity names to name the activities in the data set

df$activity <- factor(df$activity, levels = activities[,1], labels = activities[,2])

#4.Appropriately labels the data set with descriptive variable names.

renameDF = function(df){
  names(df)<-gsub("mean", "Mean", names(df))
  names(df)<-gsub("std", "Standard_deviation", names(df))
  names(df)<- gsub("mad", "Median_absolute_deviation", names(df))
  names(df) <- gsub("sma","Signal magnitude area", names(df))
  names(df)<-gsub("Acc", "Accelerometer", names(df))
  names(df)<-gsub("^t", "time", names(df))
  names(df)<-gsub("^f", "frequency", names(df))
  names(df)<-gsub("Gyro", "Gyroscope", names(df))
  names(df)<-gsub("Mag", "Magnitude", names(df))
  names(df)<-gsub("BodyBody", "Body", names(df))
  names(df)<-gsub("[()]", "", names(df))
  names(df)<- make.unique(names(df)) # Issue with duplicated column names
  
  return(df)
}

df_renamed = renameDF(df)

str(df_renamed)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_dataset = df_renamed%>%
  group_by(subject, activity)%>%
  summarise_each(funs(mean))

write.table(tidy_dataset, "tidyData.txt", row.names = F, dec = ".", col.names = T)

