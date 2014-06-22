 a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data

1.Merges the training and the test sets to create one data set.

2.Appropriately labels the data set with descriptive variable names. 
  The variable names are read from the features.txt file
  The activity lebels are read from the activity_labels.txt file
  

3.Extracts only the measurements on the mean and standard deviation for each measurement. 
  Here we use the pattern match fun grep to search the measurements with "mean" and "std", and select columes of data with thses selected measurements

4.Uses descriptive activity names to name the activities in the data set
  Use the merge fun to map the activity labels to get the descriptive activity of each row


5 Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
  Use the aggregate fun to group the data with activity_label and subject_id, and calculate the mean of each variable