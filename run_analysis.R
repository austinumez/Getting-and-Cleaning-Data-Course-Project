> # 1. Downloading and unzipping dataset
  > if(!file.exists("./data")){dir.create("./data")}
> fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
> download.file(fileUrl,destfile="./data/Dataset.zip")
trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Content type 'application/zip' length 62556944 bytes (59.7 MB)
downloaded 59.7 MB

> # Unzip dataSet to /data directory
> unzip(zipfile="./data/Dataset.zip",exdir="./data")
> #2. Merging the training and the test sets to create one data set:
> #2a. Reading files
> #Reading trainings tables:
> x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
> y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
> subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
> #2b.Reading testing tables:
> x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
> y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
> subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
> #2c.Reading feature vector:
> features <- read.table('./data/UCI HAR Dataset/features.txt')
> #2d.Reading activity labels:
> activityLabels = read.table('./data/UCI HAR Dataset/activity_labels.txt')
> 3.Assigning column names:
> #3. Assigning column names:
> colnames(x_train) <- features[,2] 
> colnames(y_train) <-"activityId"
> colnames(subject_train) <- "subjectId"
> colnames(x_test) <- features[,2]
> colnames(y_test) <- "activityId"
> colnames(subject_test) <- "subjectId"
> colnames(activityLabels) <- c('activityId','activityType')
> #Merging all data into one set
> mrg_train <- cbind(y_train, subject_train, x_train)
> mrg_test <- cbind(y_test, subject_test, x_test)
> setAllInOne <- rbind(mrg_train, mrg_test)
> #4. Extracting only  measurements on the mean and standard deviation for each measurement
> #4a. Reading column names:
> colNames <- colnames(setAllInOne)
> #5. Create vector for defining ID, mean and standard deviation:
> mean_and_std <- (grepl("activityId" , colNames) | 
                       +                      grepl("subjectId" , colNames) | 
                       +                      grepl("mean.." , colNames) | 
                       +                      grepl("std.." , colNames) 
                     + )
> #6. Making nessesary subset from setAllInOne:
> setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]
> Using descriptive activity names to name the activities in the data set:
> #Using descriptive activity names to name the activities in the data set:
> setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                                  +                               by='activityId',
                                  +                               all.x=TRUE)
> #6.Creating a second, independent tidy data set with the average of each variable for each activity and each subject:
> #6a. Making second tidy data set
> secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
> secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]
> #6b. Writing second tidy data set in txt file
> write.table(secTidySet, "secTidySet.txt", row.name=FALSE)
> save.image("F:/Project 5D2BD5/Root/John Hopkins University/Getting and Cleaning Data/week4/CPData.RData")
> save.image("F:/Project 5D2BD5/Root/John Hopkins University/Getting and Cleaning Data/week4/Gettiing and Cleaning data - Course Project/CP.RData")
> 