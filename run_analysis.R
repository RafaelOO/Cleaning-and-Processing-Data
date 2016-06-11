#Preamble
##Environmental variables
setwd("/home/rafael/Dropbox/Courses/R/Cleaning and Processing Data/Week 4/UCI HAR Dataset/")
##Packages
#library(data.table)
library(data.table)
#reading features for labeling the columns
features<-read.table("./features.txt")
#reading equivalence to name the rows 
activity_labels<-read.table("./activity_labels.txt")
#Loading and processing the train data
##Loading
###Different type of information. It will need the features to label then
x_train<-read.table("./train/X_train.txt")
###These are the labels of the type of exercise.
y_train<-read.table("./train/y_train.txt")
#The following are the ids of the people who took part of the experiment and assigned to the train set.
subject_train<-read.table("./train/subject_train.txt")
##Adding information of the activities
colnames(x_train)<-features[,2]
#Extracting only the columns that refer to the mean or standard deviation
x_train<-x_train[,c(grep(".*mean",colnames(x_train)),grep(".*std",colnames(x_train)))]
###Processing type of activities
y_train_text<-y_train
for (i in 1:6){
        y_train_text[,1]<-gsub(i,activity_labels[i,2],y_train_text[,1])
}
y_train_text<-as.data.frame(y_train_text)
#Combining type of activities
train<-cbind(y_train_text,subject_train,x_train)
names(train)[1:2]<-c("activity","id")
#Loading and processing the test data
##Loading
###Different type of information. It will need the features to label then
x_test<-read.table("./test/X_test.txt")
###These are the labels of the type of exercise.
y_test<-read.table("./test/y_test.txt")
#The following are the ids of the people who took part of the experiment and assigned to the train set.
subject_test<-read.table("./test/subject_test.txt")
##Adding information of the activities
colnames(x_test)<-features[,2]
#Extracting only the columns that refer to the mean or standard deviation
x_test<-x_test[,c(grep(".*mean",colnames(x_test)),grep(".*std",colnames(x_test)))]
###Processing type of activities
y_test_text<-y_test
for (i in 1:6){
        y_test_text[,1]<-gsub(i,activity_labels[i,2],y_test_text[,1])
}
y_test_text<-as.data.frame(y_test_text)
#Combining type of activities
test<-cbind(y_test_text,subject_test,x_test)
names(test)[1:2]<-c("activity","id")
#Combining sets
data<-rbind(train,test)
tidy<-data.table(data)
#Just in case want tapply more than a function.
#tidy<-tidy[, sapply(.SD, function(x) list(mean=mean(x), sd=sd(x))), by= c("id","activity")]
tidy<-tidy[, sapply(.SD, function(x) list(mean=mean(x))), by= c("id","activity")]
setorder(tidy,id)
<<<<<<< HEAD
=======

>>>>>>> d382fabe7478393f56513a20c27cf2d3c30eaae0


