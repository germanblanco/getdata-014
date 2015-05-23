## Function run_analysis created May 23rd 2015 by German Blanco
## 
## This function processes the dataset "Human Activity Recognition Using Smartphones"
## This dataset can be found in the following URL:
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## The goal is to generate a tidy dataset with the average per subject and activity
## of all variables containing the standard deviation and mean values.

run_analysis <- function(download.file = FALSE) {
    
    library(dplyr)
    
    ## Optionally download the original data set from internet
    ##
    if (download.file) {
        url <- "https://d396qusza40orc.cloudfront.net/"
                "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(url, method = "curl", destfile="dataset.zip")
        unzip("dataset.zip")
    }
    
    ## Read data files of the dataset
    ## All variables are numeric, providing this indication speeds up the reading process.
    main.folder <- "UCI HAR Dataset//"
    test.folder <- paste0(main.folder, "test//")
    train.folder <- paste0(main.folder, "train//")
    classes <- rep.int("numeric", 561)
    X_test <- read.table(paste0(test.folder, "X_test.txt"), colClasses=classes)
    X_train <- read.table(paste0(train.folder, "X_train.txt"), colClasses=classes)
    ## activity values are more "factor" than numeric, but this will be fixed later
    ## They will be used as indexes to find the descriptive label
    Y_test <- read.table(paste0(test.folder, "Y_test.txt"), colClasses="numeric")
    Y_train <- read.table(paste0(train.folder, "Y_train.txt"), colClasses="numeric")

    ## Merge all relevant files of the dataset into one
    subject_test <- read.table(paste0(test.folder, "subject_test.txt"), colClasses="factor")
    subject_train <- read.table(paste0(train.folder, "subject_train.txt"), colClasses="factor")
    d_test <- data.frame(subject = subject_test, subject_group="test", activity = Y_test)
    d_test <- cbind(d_test, X_test)
    d_train <- data.frame(subject = subject_train, subject_group="train", activity = Y_train)
    d_train <- cbind(d_train, X_train)
    d <- rbind(d_test, d_train)
    
    ## Select columns with mean and standard deviation
    ## This is done by searching in the features names provided with the 
    ## original dataset for the strings used for standard deviation ("std")
    ## and mean values ("mean")
    features <- read.table(paste0(main.folder, "features.txt"), as.is = TRUE)
    std.and.mean <- c(grep("std", features[,2]), grep("mean", features[,2]))
    d <- d[,c(1,2,3,3+std.and.mean)]
    
    ## Put descriptive activity names
    ## Activity names are taken from the activity labels file in the 
    ## original dataset.
    ## The process uses sapply to run through all elements of the column
    ## with the activity levels (d[,3]), and it finds the element in the
    ## activity_labels dataframe that has the same index as that level.
    activity_labels <- read.table(paste0(main.folder, "activity_labels.txt"))
    d[,3] <- sapply(d[,3], function(x) {activity_labels[x,2]})
    
    ## Put descriptive variable names
    ## The first three columns have been created in this script
    ## The rest of the columns come from the features data in the original dataset
    ## The same vector that was used to add the columns with features, is used
    ## here to find the feature names.
    colnames(d) <- c("subject", "subject_group", "activity", features[std.and.mean,2])
    
    ## Create new dataset
    ## Mean of each column, except for activity, subject and subject_group
    ## grouped by subject and activity. The group (test or train) is removed.
    d2 <- summarise_each(group_by(d, activity, subject), funs(mean), -c(1,2,3))
    
    ## It looks better if the column names are changed accordingly
    colnames(d2)[3:ncol(d2)] <- paste0("MeanOf-", colnames(d2)[3:ncol(d2)])
    
    ## Return the result
    d2
}