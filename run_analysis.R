#Download Data from URL and put into /data folder.
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

#Unzip File.
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Set path to UCI HAR Dataset folder and get a list of all files in it.
path_rf <- file.path("./data" , "UCI HAR Dataset")
files <- list.files(path_rf, recursive=TRUE)

#Reading data from files into variables.
#   1.Activity.
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
#   2.Subject.
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)
#   3.Features.
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)
#   4.Read Activity labels and Features names.
ActivityLabels <- read.table(file.path(path_rf, "activity_labels.txt"), header = FALSE)
FeaturesNames <- read.table(file.path(path_rf, "features.txt"), header = FALSE)

#Merge Datasets
Activity<- rbind(dataActivityTrain, dataActivityTest)
Subject <- rbind(dataSubjectTrain, dataSubjectTest)
Features<- rbind(dataFeaturesTrain, dataFeaturesTest)

#Set names for all variables
names(Activity) <- "ActivityName"
names(ActivityLabels) <- c("ActivityName", "Activity")
names(Subject)<- "SubjectName"
names(Features)<- FeaturesNames$V2

#Create one large Dataset with: Subject,  Activity,  Features
dataCombine <- cbind(Subject, Activity)
The_Data <- cbind(Features, dataCombine)

#Extracts only the measurements on the mean and standard deviation for each measurement
subFeaturesNames <- FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]
DataNames <- c("SubjectName", "ActivityName", as.character(subFeaturesNames))
The_Data <- subset(The_Data, select=DataNames)

#Rename the columns using more descriptive activity names
names(The_Data) <- gsub("^t", "time", names(The_Data))
names(The_Data) <- gsub("^f", "frequency", names(The_Data))
names(The_Data) <- gsub("Acc", "Accelerometer", names(The_Data))
names(The_Data) <- gsub("Gyro", "Gyroscope", names(The_Data))
names(The_Data) <- gsub("Mag", "Magnitude", names(The_Data))
names(The_Data) <- gsub("BodyBody", "Body", names(The_Data))

#Create a second, independent tidy data set with the average of each variable for each activity and each subject
SecondData <- aggregate(. ~SubjectName + ActivityName, The_Data, mean)
SecondData <- SecondData[order(SecondData$Subject,SecondData$Activity),]

#Save this tidy dataset to local file
write.table(SecondData, file = "tidydata.txt",row.name=FALSE)