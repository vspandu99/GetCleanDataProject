# This program: 
# merges the training and the test sets to create one data set.
# extracts only the measurements on the mean and standard deviation for each measurement. 
# uses descriptive activity names to name the activities in the data set
# appropriately labels the data set with descriptive variable names. 
# from the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# Data downloaded from: vhttps://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Load featrure names
ftrs <- read.table("./data/UCI HAR Dataset/features.txt", header=FALSE, col.names=c('id', 'fName')) 

iterator <- function(type, file) {
  tmpName <- paste("./data/UCI HAR Dataset/",type,"/",file,"_",type,".txt", sep='')
}

get_rslt_set <- function(type){
  type <- type
  tmp_rslt <- read.table(iterator(type,'X'), header = FALSE, col.names = ftrs$fName, colClasses = rep('numeric', nrow(ftrs)))
  tmp_tr_Y_rslt <- read.table(iterator(type,'Y'), header = FALSE, col.names=c('label'),colClasses = c('numeric'))
  tmp_tr_sub_rslt <- read.table(iterator(type,'subject'), header = FALSE, col.names = c('subject'),colClasses = c('numeric'))
  # merge labels and features for data set.
  tmp_rslt$label <- tmp_tr_Y_rslt$label
  tmp_rslt$subject <- tmp_tr_sub_rslt$subject
  tmp_rslt  
}

# Step1:
# merge training and test data
merged_data <- rbind(get_rslt_set("train"), get_rslt_set("test"))


#Step2:
step2_mean_std <- merged_data[,grepl("mean|std|Subject|ActivityId", ignore.case = TRUE, names(merged_data))]
# append label and subject to step2_data
step2_mean_std$label <- merged_data$label
step2_mean_std$subject <- merged_data$subject

#Step3:
# Read names
actvty_names <- read.table("./data/UCI HAR Dataset/activity_labels.txt",header=FALSE, col.names=c('id', 'activity_label'),
                      colClasses = c('numeric', 'character'))
# Join activity labels with the data
step3_data <- merge(step2_mean_std, actvty_names, by.x = 'label', by.y = 'id')

# Step4:
# Remove duplicate columns
step4_data <- step3_data[, !(names(step3_data) %in% c('label'))]

# Step5:
library(plyr)
tidyDataSet = ddply(step4_data, c("subject","activity_label"), numcolwise(mean))
write.table(tidyDataSet, file = "./data/actvtyAvgs.txt", row.names = FALSE)
