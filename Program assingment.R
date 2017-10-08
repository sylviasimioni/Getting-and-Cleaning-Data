#Merges the training and the test sets to create one data set.

setwd("C:\\Users\\Sylvia Simioni\\Documents\\coursera\\Getting and Cleaning Data\\Program assignment")
test.x <- read.table("test/X_test.txt")
test.y <-  read.table("test/Y_test.txt")
subject_test <- read.table("test/subject_test.txt")
train.x <- read.table("train/X_train.txt")
train.y <- read.table("train/Y_train.txt")
subject_train <- read.table("train/subject_train.txt")
features <- read.table ("features.txt")
activity_labels <- read.table ("activity_labels.txt")

#Uses descriptive activity names to name the activities in the data set

colnames(train.x) <- features[,2]
colnames(train.y) <- "activityId"
colnames(subject_train) <- "subjectId"
colnames(test.x)<- features[,2]
colnames(test.y) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames (activity_labels) <- c("activityId", "activityType")

#merge all data set

merge_train <- cbind(train.y, subject_train, train.x)
merge_test <- cbind(test.y, subject_test, test.x)
mergeall <- rbind(merge_train, merge_test)

#Extracts only the measurements on the mean and standard deviation for each measurement

exercices <- colnames(mergeall)

mean_standard <- (grepl("activityId", exercices)|
                  grepl("subjectId", exercices)|
                  grepl("mean..", exercices)|  
                    grepl("std..", exercices) )

newtable <- mergeall[, mean_standard == TRUE]

#Uses descriptive activity names to name the activities in the data set

newtablenames <- merge (newtable, activity_labels, by = "activityId", all.x = TRUE)

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

secdata <- aggregate(. ~subjectId + activityId, newtablenames, mean)
secdata <- secdata [order(secdata$subjectId, secdata$activityId), ]

