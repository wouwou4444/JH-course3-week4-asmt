#####

urlFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "./dataset.zip"

### unzip file in folder

setwd("d:/machine-learning/Johns_Hopkins/course3/week4/")
download.file(urlFile, destfile = destfile)

setwd("d:/machine-learning/Johns_Hopkins/course3/week4/dataset/UCI HAR Dataset/")
list.files()
list.files("./train/")
list.files("./test/")


### Load training and test set
### check the dimensions and number of columns
trainingSet <- read.table("./train/X_train.txt")
testSet <- read.table("./test/X_test.txt")
head(rainingSet)
str(trainingSet)
dim(trainingSet)
dim(testSet)

### load the column names
featuresNames <- read.table("./features.txt")
dim(featuresNames)
head(featuresNames)
tail(featuresNames)

### merge the training set and the test set
dataSet <- rbind(trainingSet, testSet)
dim(dataSet)

### change the names of the columns for the merged dataset
### change the name to lower case
colnames(dataSet) <- tolower(featuresNames$V2) 
head(colnames(dataSet))

# Select column with machine mean and std
filteredColums <- grep("(mean\\())|(std\\()",tolower((featuresNames)$V2),value = TRUE) 
length(filteredColums)

### extract columns from dataSet
dataSet[1:2, filteredColums]
dataSet <- dataSet[,filteredColums]
dim(dataSet)

### read the activity labels
activityNames <- read.table("activity_labels.txt")

yTrainSet <- read.table("./train/y_train.txt")
yTestSet <- read.table("./test/y_test.txt")
yDataSet <- rbind(yTrainSet, yTestSet)

names(yDataSet) <- "activity"
yDataSet$activity <- as.factor(yDataSet$activity)
levels(yDataSet$activity) <- activityNames$V2

### Normalize names

names(dataSet) <- gsub("\\(","",names(dataSet))
names(dataSet) <- gsub("\\)","",names(dataSet))
names(dataSet) <- gsub("-","_",names(dataSet))
names(dataSet) <- gsub("^t","time_",names(dataSet))
names(dataSet) <- gsub("^f","fft_",names(dataSet))


### 
# factor(levels = 1:6, labels = activityNames$V2)

### Load training and test Subject information
### check the dimensions and number of columns
trainingSubject <- read.table("./train/subject_train.txt")
testSubject <- read.table("./test/subject_test.txt")
dim(trainingSubject)
dim(testSubject)
dataSubject <- rbind(trainingSubject, testSubject)
class(dataSubject)
names(dataSubject) <- "subject"

# Add subject information to existing dataSet
subjectDataSet <- cbind(dataSubject, dataSet)
subjectDataSet$subject <- factor(subjectDataSet$subject)

# Add activity information to existing dataSet
fullDataSet <- cbind(subjectDataSet, yDataSet)

# str(split(fullDataSet, f = list(fullDataSet$activity,fullDataSet$subject)))
fullDataSetSplit <- ((split(fullDataSet[-c(1,length(names(fullDataSet)))], f = list(fullDataSet$activity,fullDataSet$subject))))

interDataSet <- sapply(fullDataSetSplit, function (x) {x})
tidyDataSet <- apply(interDataSet, c(1,2), function (x) {mean(x[[1]])})

setwd("d:/machine-learning/Johns_Hopkins/course3/week4-asmt/")
write.table(file = "./tidyDataSet.csv", x = tidyDataSet)

# tidyDataSet2 <- sapply(fullDataSetSplit, function (x) {apply(x, c(1,2), function (y) { mean(y[[1]])})})
