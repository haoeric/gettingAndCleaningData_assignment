# R script to reshape the data collected from the accelerometers from the Samsung Galaxy S smartphone
# haoeric, 21-Jun-2014

# read and store activity labels with names
activity_label <- read.table("activity_labels.txt")
names(activity_label) <- c("label_id", "activity")

#read and store features with names
features <- read.table("features.txt")
names(features) <- c("features_id", "features_name")

# read and combine train data
subject_train_path <- file.path("train", "subject_train.txt")
train_x_path <- file.path("train", "X_train.txt")
train_y_path <- file.path("train", "y_train.txt")

train_subject <- read.table(subject_train_path)
train_x_data <- read.table(train_x_path)
train_y_data <- read.table(train_y_path)
  

# read and combine test data
subject_test_path <- file.path("test", "subject_test.txt")
test_x_path <- file.path("test", "X_test.txt")
test_y_path <- file.path("test", "y_test.txt")

test_subject <- read.table(subject_test_path)
test_x_data <- read.table(test_x_path)
test_y_data <- read.table(test_y_path)

# Merges the training and the test sets to create one data set
combine_x_data <- rbind(train_x_data,test_x_data)
combine_y_data <- rbind(train_y_data,test_y_data)
combine_subject <- rbind(train_subject,test_subject)

combine_data <- cbind(combine_x_data,combine_y_data,combine_subject)


# Appropriately labels the data set with descriptive variable names
fname <- features[,2]
fname <- Vectorize(fname)
names(combine_data) <- c(as.character(fname), "label_id", "subject_id")

# Extracts only the measurements on the mean and standard deviation for each measurement
measurements <- names(combine_data)
mean_measurements <- measurements[grep("mean", measurements)]
std_measurements <- measurements[grep("std", measurements)]
select_mean_measerements <- c(mean_measurements, std_measurements,"label_id", "subject_id")
select_data <- combine_data[,select_mean_measerements]


# Uses descriptive activity names to name the activities in the data set
tidy_combine_data <- merge(select_data, activity_label, by.x="label_id", by.y = "label_id", sort=F, all = T)
 

# Creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject. 
second_tidy_data <- aggregate(x=tidy_combine_data[,2:80],by=list(tidy_combine_data$subject_id, tidy_combine_data$activity),FUN = "mean")


# save the two required datasets
write.table(tidy_combine_data, file = "tidy_combined_data.txt", quote=F, sep= " ", row.names=F, col.names=T)
write.table(second_tidy_data, file = "second_tidy_data.txt", quote=F, sep= " ", row.names=F, col.names=T)





