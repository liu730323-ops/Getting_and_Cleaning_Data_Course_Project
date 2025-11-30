# Step 1 —— Download & unzip data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "dataset.zip"

if(!file.exists(zipfile)){
  download.file(url, zipfile, mode = "wb")
}

if(!file.exists("UCI HAR Dataset")){
  unzip(zipfile)
}
# Step 2 — Load data files
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

trainX <- read.table("UCI HAR Dataset/train/X_train.txt")
trainY <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSub <- read.table("UCI HAR Dataset/train/subject_train.txt")

testX <- read.table("UCI HAR Dataset/test/X_test.txt")
testY <- read.table("UCI HAR Dataset/test/y_test.txt")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Merge Step (Requirement #1)
mergedX <- rbind(trainX, testX)
mergedY <- rbind(trainY, testY)
mergedSub <- rbind(trainSub, testSub)

colnames(mergedX) <- features[,2]
colnames(mergedY) <- "activity"
colnames(mergedSub) <- "subject"

fullData <- cbind(mergedSub, mergedY, mergedX)

library(dplyr)

reqColumns <- grep("mean\\(\\)|std\\(\\)", features[,2])
tidyData <- fullData[, c(1,2, reqColumns + 2)]

tidyData$activity <- factor(tidyData$activity,
                            levels = activity_labels[,1],
                            labels = activity_labels[,2])

names(tidyData) <- gsub("^t", "Time", names(tidyData))
names(tidyData) <- gsub("^f", "Frequency", names(tidyData))
names(tidyData) <- gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData) <- gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData) <- gsub("Mag", "Magnitude", names(tidyData))
names(tidyData) <- gsub("-mean\\(\\)", "Mean", names(tidyData))
names(tidyData) <- gsub("-std\\(\\)", "Std", names(tidyData))

finalData <- tidyData %>% 
  group_by(subject, activity) %>% 
  summarise_all(mean)

write.table(finalData, "tidy_dataset.txt", row.names = FALSE)

