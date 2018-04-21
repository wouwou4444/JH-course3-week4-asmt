# CodeBook.md

## General information
tidy data are stored in tidyDataSet.csv in a dataframe table format
separator is default " " of write.table command

Data in this data set are the average values of each mean and standard variable from the original data.

original data source is "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Data transformation

### Retrieve data from web site
collect and store original data in a working folder
unzip the data

### Load training and test set
load data training and test dataset (read.table from X_train.txt and X_test.txt) and merge them into a single dataset
load column names from "features.txt" file (561 column names)
change column names of new dataset

### Filter dataset
select columns with mean() or std pattern in their names
reduce merged data set to these columns (66 column)

### Load training and test labels
load data training and test labels (read.table from y_train.txt and y_test.txt) and merge them into a yDataSet$activity dataframe
load activity names from "activity_labels.txt" file (6 activity names) into activityNames dataframe

transform activity labels  in factor in yDataSet
change levels name with the information from activityNames

### Normalize variable names
For each variable (mean and std)
  remove ( (  characters
  replace - by _
  replace inital t by time_
  replace initial f by fft_

### Add subject information
load subject information from "train/subject_train.txt" an "test/subject_test.txt"
merge these 2 vectors (rbind)
add this merged vector to the previous global dataframe dataSet (cbind)
output subjectDataSet
Transform subject in a factor variable

### Add label vector to Dataframe
add labels to subjectDataSet dataframe
output fullDataSet

### Compute average by subject and activity for each variable
split by subject and activity
compute the mean by sapply and apply

## tidyDataSet structure

### row
each row contains information for one veriable (mean or std) 
row 1 : "time_bodyacc_mean_x"
row 2 : "time_bodyacc_mean_y"
row 3 : "time_bodyacc_mean_z"

### column
each column contains information for a couple of activity/subject
column 1 : "WALKING.1" 
column 2 : "WALKING_UPSTAIRS.1" 
column 3 : "WALKING_DOWNSTAIRS.1" 
column 4 : "SITTING.1" 
column 5 : "STANDING.1" 
column 6 : "LAYING.1" 
column 7 : "WALKING.2" 
column 8 : "WALKING_UPSTAIRS.2" 


### value
each value contains the average value of this variable for the given activity/subject couple
