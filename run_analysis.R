# run_analysis.R
# For Coursera > Cleaning Data > Week 4 > Final project
# Danz 170701

#Clean up shop
rm(list=ls())               #remove all vars
cat("\014")                 #clear console

#Set working directory
setwd("C:\\Users\\adanz\\Dropbox\\Danz Cloud\\classwork\\Data Science - Coursera\\3 Data cleaning\\week 4\\final project")

#Name zip file; if it doesn't exist, download it.  
filename <- "getdata_dataset.zip"
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename,  mode = "wb")
}  
#if the file hasn't been unzipped yet, do so. 
unzipPath <- "./final project/UCI HAR Dataset"
if (!file.exists(unzipPath)) { 
    unzip(filename, exdir = "./final project") 
}

#Identify path to training and testing sets 
trainPath <- paste(unzipPath, "/train/X_train.txt", sep="")
testPath  <- paste(unzipPath, "/test/X_test.txt", sep="")

#Identify path to data labels
trainLabPath <- paste(unzipPath,"/train/y_train.txt", sep="")
testLabPath  <- paste(unzipPath,"/test/y_test.txt", sep="")
featurePath  <- paste(unzipPath,"/features.txt", sep="")
activityPath <- paste(unzipPath,"/activity_labels.txt", sep="")
trainSubjPath    <- paste(unzipPath,"/train/subject_train.txt", sep="")
testSubjPath     <- paste(unzipPath,"/test/subject_test.txt", sep="")

#Read the data sets
trainSet <- read.table(trainPath, header = FALSE)
trainLab <- read.table(trainLabPath, header = FALSE)
testSet  <- read.table(testPath, header = FALSE)
testLab  <- read.table(testLabPath, header = FALSE)
features <- read.table(featurePath, header = FALSE)
activity <- read.table(activityPath, header = FALSE)
trainSubj<- read.table(trainSubjPath, header = FALSE)
testSubj <- read.table(testSubjPath, header = FALSE)

#Merge the training and testing data sets
alldata  <- rbind(trainSet,  testSet)
allSubj  <- rbind(trainSubj, testSubj)
allLab   <- rbind(trainLab,  testLab)

#Determine the indices of mean and std values
featureIdx <- grep(".*mean.*|.*std.*", features[,2])

#Using feature index, get chosen data from tables
featureList <- features[featureIdx,2]

#Clean up the feature names and make 'em look purdy. 
featureList <- gsub("^t", "Time", featureList)
featureList <- gsub("^f", "Freq", featureList)
featureList <- gsub("-mean\\(\\)", "Mean", featureList)
featureList <- gsub("-std\\(\\)", "Std", featureList)
featureList <- gsub("-meanFreq\\(\\)", "MeanFreq", featureList)

#Clean up activity names
activityList <- tolower(activity[,2])

#extract mean/std data 
data2keep <- alldata[,featureIdx]

#put it all into a data frame
dataTable <- cbind(allSubj, allLab, data2keep)

#set column name
colnames(dataTable) <- c("Subject", "Activity", featureList)

#convert activity and subjects into factors
dataTable$Activity <- factor(dataTable$Activity)
dataTable$Subject <- factor(dataTable$Subject)


#Compute the average for all features across all subjects
meanData <- aggregate(as.matrix(dataTable[,featureList]) ~ Subject + Activity, data=dataTable, FUN = "mean")
write.table(meanData, "MeanSensorData.txt", row.names = FALSE, quote = FALSE)







