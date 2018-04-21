# JH-course3-week4-asmt
# JH course3 assignment

## List of files
run_analysis.R : R script
tidyDataSet.csv : csv file
activity-list.csv : list of activity names
subject-list.csv : list of subject
variable-list.csv : list of variables

## description of files

### run_analysis.R
R script to transform data from original data source
original data source : "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
retrieves mean and standard deviation variables
produces a tidyDataSet with the average of each variable (by user and activity)

### tidyDataSet
dataframe with the average value of each variable for each couple activity.user

### activity-list.csv
dataframe list of activities and mapping to the original data source

### variable-list.csv
list of mean and standard deviation variables selected from the original data source
