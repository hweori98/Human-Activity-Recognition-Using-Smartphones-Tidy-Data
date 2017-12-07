#let's install and load packages necessary first
install.packages("Hmisc", "data.table", "dplyr", "utils")
library(Hmisc)
library(data.table)
library(dplyr)
library(utils)

#let's download data set and explore it
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "./dataset.zip")
unzip("./dataset.zip", exdir = "./dataset")
list.files("./dataset", recursive = TRUE, full.names = TRUE)

#let's identify necessary dataset files
filenames <- list.files("./dataset", pattern = "^X|^y",recursive = TRUE, full.names = TRUE)
testfilenames <- filenames[1:2]
trainfilenames <- filenames[3:4]

#let's load list of feature names
featuresfilename <- list.files("./dataset", pattern = "features.txt",recursive = TRUE, full.names = TRUE)
features <- read.table(featuresfilename, check.names = TRUE)
features <- features$V2

#let's load subject id's
testsubjectfilename <- list.files("./dataset", pattern = "subject_test.txt",recursive = TRUE, full.names = TRUE) 
trainsubjectfilename <- list.files("./dataset", pattern = "subject_train.txt", recursive = TRUE, full.names = TRUE)
testsubject <- read.table(testsubjectfilename, check.names = TRUE, col.names = "id")
trainsubject <- read.table(trainsubjectfilename, check.names = TRUE, col.names = "id")

#let's load feature data with feature names and actiivty column
xtest <- read.table(testfilenames[1], col.names = features)
ytest <- read.table(testfilenames[2], col.names = "activity")
xtrain <- read.table(trainfilenames[1], col.names = features)
ytrain <- read.table(trainfilenames[2], col.names = "activity")

#let's merge data.frames to assign subject id's and to combine test and train data
testmerged <- cbind(ytest, xtest)
testmerged <- cbind(testsubject, testmerged)
trainmerged <- cbind(ytrain, xtrain)
trainmerged <- cbind(trainsubject, trainmerged)
merged <- rbind(testmerged, trainmerged)

#let's extract variables that are mean, sd, activity, and subject id
extract <- merged[grepl("mean|std|activity|id", names(merged))]
#found a really neat subsetting method using grepl() to select which columns to subset

#let's convert activity id's to descriptive activity labels
actfilename <- list.files("./dataset", pattern = "activity_labels", recursive = TRUE, full.names = TRUE)
actlabels <- read.table(actfilename)
extract$activity <- actlabels$V2[match(extract$activity, actlabels$V1)]

#cleaning up the variable names: all lowercase, removing non-alphanumerics, expanding acronyms 't' and 'f'.
names(extract) <- gsub("\\.", "", names(extract))
names(extract) <- gsub("^t", "timedoman_", names(extract))
names(extract) <- gsub("^f", "freqdomain_", names(extract))
names(extract) <- tolower(names(extract))

#let's produce a tidy data table for averages
tidydata <- extract %>%
  group_by(id, activity) %>%
  summarise_each(funs(mean))

#finally, outputing a txt file of the dataset
write.table(tidydata, "./tidydata.txt", row.names = FALSE)
