## Introduction

The data in this project related to the study detailed here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Retrieving initial data set

The data should be downloaded from the following link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
The zip file should be unzipped giving a folder named "UCI HAR Dataset", this should be placed in the same working directory as the run_analysis.R script file.

## Running the script file

File run_analysis.R should be loaded into the R or RStudio environment and all statements should run in the order in the script file.

The script does the following:-

(1). Read and merge the training and test data

Using fread from the library data.table, reads training files
"UCI HAR Dataset/train/x_train.txt" (test observations),
"UCI HAR Dataset/train/y_train.txt" (activity codes matching observations),
"UCI HAR Dataset/train/subject_train.txt" (test subjects matching observations)
into separate data fromes. 
The columns in data frames are then merged into a new training data frame in the order activity code, subject code and observations. The individual data frames are then removed.

Then reads test files
"UCI HAR Dataset/test/x_test.txt" (test observations),
"UCI HAR Dataset/test/y_test.txt" (Activity code matching observations),
"UCI HAR Dataset/test/subject_test.txt" (test subjects matching observations)
into separate data fromes. 
The columns in data frames are then merged into a new test data frame in the order activity code, subject code and observations. The individual data frames are then removed.

The rows in the test and training data frames are combined into a new combined data frame and the individual test and training data frames are removed.

The "UCI HAR Dataset/features.txt" feature name file is read into a data frame and is used to set a list of column names for the combined data frame above. "Activity_Code" and "Subject_Code" are added for the 1st two columns. The features data frame is then removed.

(2). Extracts only the measurements on the mean and standard deviation for each measurement.

Using the dplyr package, a list of column names containing the words "-mean()" or "-std()" are extracted plus the "Activity_Code" and "Subject_Code" columns.
A cut down data frame with just those columns is extracted from the combined data frame above. The combined data frame and the list of columns to extract is then removed.

(3). Uses descriptive activity names to name the activities in the data set

The "UCI HAR Dataset/activity_Labels.txt" file is read into a data frame. This has the activity names related to the activity codes. Column names are changed to "Activity_Code" and "Activity_Name". The activity labels data frame is merged with the cut down data frame matching the rows on the Activity_Code column.
The activity labels data frame is then removed.

(4). Appropriately labels the data set with descriptive variable names. 

The names on the cut dowm data frame are then amended to make them more readable.

(5). From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

An aggregate data frame is then created using the aggregate function on fields Activity_Name and Subject_code. A final data frame is created by removing the aggregated Activity_code, Activity_Name and Subject_code columns. The aggregate data frame is then removed. Column headings on the final data fram are changed to set the Group.1 and Group.2 columns to activity_name and subject_code and the other columns are all prefixed by average_. The final data frame is then ordered by activity_name, subject_code.

(6). Output to a text file

The final data frame is then written to a text file "data.txt" in the working directory.

The data frame is then removed.
