#This file contains the script for the course project 
# for the "Getting and Cleaning Data" course on coursera

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ","Dataset.zip", mode="wb")
unzip("Dataset.zip")

install.packages("read.table")
library(data.table)

# read in all the tables
# features (variables) 561*2
features_set <- data.table(read.table("features.txt", stringsAsFactors=FALSE))
# training and test sets: 7352*561 and 2947*561
train_set <- data.table(read.table("X_train.txt", stringsAsFactors=FALSE))
test_set <- data.table(read.table("X_test.txt", stringsAsFactors=FALSE))
# subject sets for training and test: 7352*1 and 2947*1
subjtrain_set <- data.table(read.table("subject_train.txt", stringsAsFactors=FALSE))
subjtest_set <- data.table(read.table("subject_test.txt", stringsAsFactors=FALSE))
# activity sets for training and test: 7352*1 and 2947*1
acttrain_set <- data.table(read.table("Y_train.txt", stringsAsFactors=FALSE))
acttest_set <- data.table(read.table("Y_test.txt", stringsAsFactors=FALSE))
# activity labels: 6*2
actlabels_set <- data.table(read.table("activity_labels.txt", stringsAsFactors=FALSE))

#step 1: create merge set: 10299*561
merge_set <- rbind(train_set, test_set)
# merge subject sets
subjmerge_set <- rbind(subjtrain_set, subjtest_set)
#merge activity sets
actmerge_set <- rbind(acttrain_set, acttest_set)

#names the columns of the merged set using the features_set
setnames(merge_set,features_set[,features_set$V2])

# step 2: Extracting columns with only mean and std values
# first, extract mean values, then, std values and then concatenate
mean_set <- select(merge_set,contains("mean()"))
std_set <- select(merge_set,contains("std()"))
meanstd_set <- cbind(mean_set,std_set)

#step 3: Replacing activity numbers with names
actmerge_set$V1[actmerge_set$V1 == "1"] <- actlabels_set[1,]$V2
actmerge_set$V1[actmerge_set$V1 == "2"] <- actlabels_set[2,]$V2
actmerge_set$V1[actmerge_set$V1 == "3"] <- actlabels_set[3,]$V2
actmerge_set$V1[actmerge_set$V1 == "4"] <- actlabels_set[4,]$V2
actmerge_set$V1[actmerge_set$V1 == "5"] <- actlabels_set[5,]$V2
actmerge_set$V1[actmerge_set$V1 == "6"] <- actlabels_set[6,]$V2

#step 4: Have descriptive headings: here I only remove "()" and -
new_colnames <- sub("\\(\\)","",names(meanstd_set))
new_colnames <- sub("-","",new_colnames)
new_colnames <- sub("-","",new_colnames)
setnames(meanstd_set, new_colnames)

#step 5: tidy the data
# first make column headings for the subject and activity data
# bind the subject and activity data to the mean/std dev. data
# second average out each measurement by each subject and their activity
setnames(subjmerge_set, "Subject")
setnames(actmerge_set, "Activity")
tmp_tidy_set <- cbind(subjmerge_set, actmerge_set, meanstd_set)
tidy_set <- tmp_tidy_set %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))





