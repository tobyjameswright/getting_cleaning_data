library(dplyr)

#load data
train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")
train_activity <- read.table("UCI HAR Dataset/train/y_train.txt")
test_activity <- read.table("UCI HAR Dataset/test/y_test.txt")
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

#merge data sets
data <- rbind(test, train)
subject <- rbind(subject_test, subject_train)
activity <- rbind(test_activity, train_activity)

# add col names
colnames(data) <- features$V2
colnames(subject) <- "Subject"
colnames(activity) <- "Activity"

#combine data
subject_activity <- cbind(subject, activity)
all_data <- cbind(subject_activity, data)


# extract only columns that have mean or std in col name

mean_or_std <- grep("mean|std", names(all_data))
mean_std_data <- all_data[,c(1,2,mean_or_std)]

# add descriptive activity names
mean_std_data$Activity <- factor(mean_std_data$Activity, levels = c(1,2,3,4,5,6),
                                 labels=activity_label$V2)

#label dataset with descriptive variable names
names(mean_std_data) <- gsub("BodyBody", "Body ", names(mean_std_data))
names(mean_std_data) <- gsub("Acc", "Acceleration ", names(mean_std_data))
names(mean_std_data) <- gsub("^t","Time of ", names(mean_std_data))
names(mean_std_data) <- gsub("^f", "Frequency of ", names(mean_std_data))
names(mean_std_data) <- gsub("mean()", "mean", names(mean_std_data))
names(mean_std_data) <- gsub("std()", "standard_deviation", names(mean_std_data))

# create a second data set with average of each variable

library(dplyr)

#group by Activity and Subject and then return mean of each

average_data <- mean_std_data %>%
        group_by(Activity,Subject) %>%
        summarise_each(mean)

#write a txt file with the summarised data

write.table(average_data, file="average_data.txt", row.names = F)


