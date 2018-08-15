#-------------------------------------------------------------
# 1. Read and merge the training and test data
#-------------------------------------------------------------

# Get Training Observations
library(data.table)
xtrainDF <- fread("UCI HAR Dataset/train/x_train.txt")
# Get Training Activity codes
ytrainDF <- fread("UCI HAR Dataset/train/y_train.txt")
# Get subject codes
strainDF <- fread("UCI HAR Dataset/train/subject_train.txt")
# Merge training Activity codes, subjects and Observations
trainDF <- cbind(ytrainDF, strainDF, xtrainDF)
# Clean up
rm(xtrainDF)
rm(ytrainDF)
rm(strainDF)

# Get Test Observations
xtestDF <- fread("UCI HAR Dataset/test/x_test.txt")
# Get Test Activity codes
ytestDF <- fread("UCI HAR Dataset/test/y_test.txt")
# Get subject codes
stestDF <- fread("UCI HAR Dataset/test/subject_test.txt")
# Merge test Activity codes, subjects and Observations
testDF <- cbind(ytestDF, stestDF, xtestDF)
# Clean up
rm(xtestDF)
rm(ytestDF)
rm(stestDF)

# Merge Training and test data
DF <- rbind(trainDF, testDF)
# Clean up
rm(trainDF)
rm(testDF)

# Add features names to data
features <- fread("UCI HAR Dataset/features.txt")
features <- rbind(data.table(-1, "Activity_Code"), data.table(0, "Subject_Code"), features)
names(DF) <- features$V2
rm(features)

#-------------------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#-------------------------------------------------------------------------------------------
library(dplyr)
meanAndSDCols <- c("Activity_Code", "Subject_Code", names(select(DF, contains("-mean()"))), names(select(DF, contains("-std()"))))
DFMeanSD <- select(DF, one_of(meanAndSDCols))

# Clean Up
rm(DF)
rm(meanAndSDCols)

#-------------------------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set 
#-------------------------------------------------------------------------------------------
AL <- fread("UCI HAR Dataset/activity_Labels.txt")
names(AL) <- c("Activity_Code", "Activity_Name")
DFMeanSD <- merge(AL, DFMeanSD, by.x = 'Activity_Code', by.y = 'Activity_Code', all = TRUE)
rm(AL)

#-------------------------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive variable names. 
#-------------------------------------------------------------------------------------------

names(DFMeanSD) <- sub("tBody", "time_body_",names(DFMeanSD))
names(DFMeanSD) <- sub("tGravity", "time_gravity_",names(DFMeanSD))
names(DFMeanSD) <- sub("fBody", "fft_body_",names(DFMeanSD))
names(DFMeanSD) <- sub("_Acc", "_acceleration_",names(DFMeanSD))
names(DFMeanSD) <- sub("_Gyro", "_gyroscope_",names(DFMeanSD))
names(DFMeanSD) <- sub("_Jerk", "_jerk_",names(DFMeanSD))
names(DFMeanSD) <- sub("_Mag", "_mag_",names(DFMeanSD))
names(DFMeanSD) <- sub("_BodyAccJerkMag", "_body_acceleration_jerk_mag_",names(DFMeanSD))
names(DFMeanSD) <- sub("_BodyGyroMag", "_body_gyroscope_mag_",names(DFMeanSD))
names(DFMeanSD) <- sub("_BodyGyroJerkMag", "_body_gyroscope_jerk_mag_",names(DFMeanSD))
names(DFMeanSD) <- sub("-", "",names(DFMeanSD))

#-------------------------------------------------------------------------------------------
# 5.  From the data set in step 4, creates a second, independent tidy data set with the 
# average of each variable for each activity and each subject.
#-------------------------------------------------------------------------------------------

aggdata <-aggregate(DFMeanSD, by=list(DFMeanSD$Activity_Name,DFMeanSD$Subject_Code), 
                                         FUN=mean, na.rm=TRUE)
finalDF <- cbind(aggdata[1:2], aggdata[6:71])
rm(aggdata)
names(finalDF) <- sub("Group.1", "activity_name",names(finalDF))
names(finalDF) <- sub("Group.2", "subject_code",names(finalDF))
names(finalDF) <- sub("time_", "average_time_",names(finalDF))
names(finalDF) <- sub("fft_", "average_fft_",names(finalDF))
rm(DFMeanSD)
finalDF <- finalDF[order(finalDF$activity_name, finalDF$subject_code),]

#-------------------------------------------------------------------------------------------
# Output the tidy data text file
#-------------------------------------------------------------------------------------------

write.table(finalDF, "data.txt", row.names=FALSE)
rm(finalDF)


