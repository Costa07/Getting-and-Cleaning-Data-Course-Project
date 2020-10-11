##This document is a codebook that provides descriptions of the variables, the data, and all transformations and work that I performed to clean up the data.
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##RScript
1.Download, Unzip and set Path to UCI HAR Dataset folder
2.Reading Files
    2.1 Reading Activity tables
    2.2 Reading Subject tables
    2.3 Reading Features tables
    2.4 Reading Activity labels
    2.5Merge Datasets
    2.6 Set names for all variables
3.Create one large Dataset
    3.1 Extracts only the measurements on the mean and standard deviation for each measurement
    3.2 Rename the columns using more descriptive activity names
    3.3 Create a second, independent tidy data set with the average of each variable for each activity and each subject
    3.4 Save this tidy dataset to local file
    
##Variables
1. y_train, x_train, x_test, y_test, subject_train, subject_test - contain the data from the downloaded files
2. Activity, Subject, Features - merge downloaded data for further use