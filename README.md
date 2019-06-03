# getting_cleaning_data

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The run_analysis script achieves this by;

1) reading in all required data from the HCI HAR Dataset
2) combines the test and train datasets into one dataset as well as combining the subject datasets.
3) Adds the appropiate column names to the datasets
4) combines the datasets into one large dataset called "meqan_std_data"
5) Extracts only columns that have mean or std in the column name
6) Tidy's up the column names to make them more readable
7) substitutes the activity types into the activity column to replace the numbers.
8) Then it creates a seconf dataframe called "average_data" that takes "mean_std_data" and averages all columns.

