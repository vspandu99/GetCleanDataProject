# GetCleanDataProject
 
BACKGOUND:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

DATA: The data used for this project is taken from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

PROJECT TASKS:
The project has several tasks as detailed below:
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Use descriptive activity names to name the activities in the data set
4. Label the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

SCRIPT: 
* The R script used to acheive the project goals is named as run_analysis.R. Each step is seperately shown in the script.
* The script uses two functions:
    1. iterator : This function makes up filenames for given set of parameters i.e. type and file.
    2. get_rslt_set : This function calls the 'iterator' function with sets of types(test, train) and files(X, Y, subject) and get the full name of the full name of the file to read. Then it reads respective tables and merges the data sets X, Y and subject into one and returns the resulting dataset.
* In step1, the script calls get_rst_set finction twice for train and test data sets and merges them into one dataset named merged_data.
* In step2, the script picks the mean and stadard deviation columns of the merged data and adds label and subject columns to it.
* In step3, the script reads the labels from activity_labels.txt file and joins(by id and label) it with resulting dataset from step2. Now there are duplicates columns with label.
* In step4, the script removes the duplicate label columns.
* For step5, plyr package is used. So, it needed to be loaded first. Then get column wise mean for each subject and for each activty label. Finally write the output( the tidy dataset) into a file called actvtyAvgs.txt

OUTPUT: The output of the above tasks is written into actvtyAvgs.txt
