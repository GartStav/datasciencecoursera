run_analysis <- function() {
  # Read all data
  train_x <- read.table("UCI HAR Dataset/train/X_train.txt")
  test_x <- read.table("UCI HAR Dataset/test/X_test.txt")
  train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
  test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
  train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
  test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
  x <- rbind(train_x, test_x)
  y <- rbind(train_y, test_y)
  subject <- rbind(train_subject, test_subject)
  activities <- read.table("UCI HAR Dataset/activity_labels.txt")
  
  # Adding discriptive activity names instead of activity labels (part 3)
  y$id  <- 1:nrow(y)
  m <- merge(y, activities, by= "V1")
  act <- m[order(m$id),]
  act <- act$V2
  
  # Leave only measurements with mean and standard deviation (part 2)
  features <- read.table("UCI HAR Dataset/features.txt")
  colnames(x) <- features[,2]
  mean_cols <- x[,names(x)[grep("mean\\()", names(x))]]
  std_cols <- x[,names(x)[grep("std\\()", names(x))]]

  # Adding descriptive variable names (part 4)
  nm <- names(mean_cols)
  ns <- names(std_cols)
  names <- c(nm, ns)
  features_new <- gsub("(^|[[:punct:]])([[:alpha:]])", "\\1\\U\\2", names, perl=TRUE)
  f <- gsub("-|\\()", "", features_new)
  f2 <- gsub("\\(", "From", f)
  f3 <- gsub("\\)", "", f2)
  prelim_data <- cbind(mean_cols, std_cols)
  colnames(prelim_data) <- f3

  
  # Merge all the data together (part 1)
  my_data <- cbind(subject, act, prelim_data)
  colnames(my_data)[1] <- "Subject"
  colnames(my_data)[2] <- "Activity"
  
  # Aggregate the values for each activity and subject (part 5)
  aggdata <-aggregate(my_data, by=list(my_data$Subject, my_data$Activity), FUN=mean, na.rm=TRUE)
  aggdata$Subject <- NULL
  aggdata$Activity <- NULL
  colnames(aggdata)[1] <- "Subject"
  colnames(aggdata)[2] <- "Activity"
  write.table(aggdata, "output.txt", row.names=FALSE)

}