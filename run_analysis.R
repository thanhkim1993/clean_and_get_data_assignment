### Package used
library(readr)
library(dplyr)

#1. Merges the training and the test sets to create one data set
### A. Working with test data set
### Load the test data set
X_test <- read_table2("Course 3 - Getting and Cleaning data/data/UCI HAR Dataset/test/X_test.txt", 
                      col_names = FALSE)

### Label the test data set's variable with names from 'features.txt'
features <- read_table2("Course 3 - Getting and Cleaning data/data/UCI HAR Dataset/features.txt", 
                        col_names = FALSE)
names(X_test) <- features$X2

### Load the test label file 'y_text.txt'
y_test <- read_table2("Course 3 - Getting and Cleaning data/data/UCI HAR Dataset/test/y_test.txt", 
                      col_names = FALSE)

### Load the subject ID file 'subject_text.txt'
subject_test<- read_table2("Course 3 - Getting and Cleaning data/data/UCI HAR Dataset/test/subject_test.txt", 
                            col_names = FALSE)

### Combine all above into a data frame called "test"
test <- data.frame(subject_test,group = "test",y_test,X_test)


### B. Working with train data set
### Load the train data set
X_train <- read_table2("Course 3 - Getting and Cleaning data/data/UCI HAR Dataset/train/X_train.txt", 
                      col_names = FALSE)

### Label the test data set's variable with names from 'features.txt'
names(X_train) <- features$X2

### Load the test label file 'y_text.txt'
y_train <- read_table2("Course 3 - Getting and Cleaning data/data/UCI HAR Dataset/train/y_train.txt", 
                      col_names = FALSE)

### Load the subject ID file 'subject_text.txt'
subject_train <- read_table2("Course 3 - Getting and Cleaning data/data/UCI HAR Dataset/train/subject_train.txt", 
                            col_names = FALSE)

### Combine all above into a data frame called "test"
train <- data.frame(subject_train,group = "train",y_train,X_train)


### C. Combine two data 
BodyAccelerometerTime <- rbind(train,test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
### Extracts mean and standard deviation using a search logic
searchLogic <- grep("X1|group|[Mm]ean|std",names(BodyAccelerometerTime),value = TRUE)
BodyAccelerometerTime <- BodyAccelerometerTime[,searchLogic]

### Moreover, data from magnitude of body accelerometer signals (time domain) on X-axis were chosen using search logic
### Not from Magnitude and Jerk movement
searchLogic <- grep("X1|group|^tBodyAcc[^Mag|^Jerk]",names(BodyAccelerometerTime),value = TRUE)
BodyAccelerometerTime <- BodyAccelerometerTime[,searchLogic]

# 3. Uses descriptive activity names to name the activities in the data set
### Create a vector of activity names
activity_labels <- read_table2("Course 3 - Getting and Cleaning data/data/UCI HAR Dataset/activity_labels.txt", 
                               col_names = FALSE)

### Match activity names to index in the activity collumn of data set "BodyAccelerometerTime"
for (i in 1:nrow(BodyAccelerometerTime)) {
  for (j in 1:length(activity_labels$X2)) {
    if (BodyAccelerometerTime$X1.1[i] == j){
      BodyAccelerometerTime$X1.1[i] = activity_labels$X2[j]
    }
  }
}

### Transform activity names to lower case
BodyAccelerometerTime$X1.1 <- tolower(BodyAccelerometerTime$X1.1)

# 4. Appropriately labels the data set with descriptive variable names
### Create a vector of variable names
descriptiveNames <- c("subjectID",
                      "group",
                      "activity",
                      "XaxisMean",
                      "YaxisMean",
                      "ZaxisMean",
                      "XaxisStd",
                      "YaxisStd",
                      "ZaxisStd")
### Match the names to collumns
names(BodyAccelerometerTime) <- descriptiveNames

# 5. From the data set in step 4, creates a second, independent tidy data set 
# with the average of each variable for each activity and each subject

### Calcuing average vlues by subject ID, groups (train/test), and activities
averageBodyAccelerometerTime <- BodyAccelerometerTime %>% 
  group_by(subjectID,group,activity) %>% 
  summarise(averageXaxisMean = mean(XaxisMean),
            averageYaxisMean = mean(YaxisMean),
            averageZaxisMean = mean(ZaxisMean),
            averageXaxisStd = mean(XaxisStd),
            averageYaxisStd = mean(YaxisStd),
            averageZaxisStd = mean(ZaxisStd))

### Moreover, to make it tidier, I perform a few more jobs
### Factorise activity variable in the right order
averageBodyAccelerometerTime$activity <- factor(averageBodyAccelerometerTime$activity,
                                         levels = c("walking",
                                                    "walking_upstairs",
                                                    "walking_downstairs",
                                                    "sitting",
                                                    "standing",
                                                    "laying"))

### Also, values in collumns of average values were rounded to 5 significant digits
averageBodyAccelerometerTime[,4:9] <- sapply(averageBodyAccelerometerTime[,4:9],round,4)
# Export the tidy data set
write.table(averageBodyAccelerometerTime,
            "./Course 3 - Getting and Cleaning data/averageBodyAccelerometerTime.csv",
            sep =",",
            row.names = F)

