subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table(file = "UCI HAR Dataset/test/x_test.txt")
y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table(file = "UCI HAR Dataset/train/x_train.txt")
y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
features <- read.table(file = "UCI HAR Dataset/features.txt")
activity_labels <- read.table(file = "UCI HAR Dataset/activity_labels.txt")
subject_test_train <- rbind(subject_test, subject_train)
colnames(subject_test_train) <- "names_subject_test_train"
label_y <- rbind(y_test, y_train)
names_label_y <- colnames(label_y)
labels_actv_y <- merge(label_y, activity_labels, by=1)
labels_actv_y <- labels_actv_y[,-1]
label_x <- rbind(x_test, x_train)
colnames(label_x) <- features[,2]
alldata <- cbind(subject_test_train, labels_actv_y, label_x)
band <- c("mean\\(\\)", "std\\(\\)")
band0 <- grep(paste(band,collapse="|"), features[,2], value=FALSE)
band0 <- band0+2
DataMeanStd <- alldata[,c(1,2,band0)]
write.table(DataMeanStd, file = "b.txt" , sep = ";")
library("reshape2")
union = melt(alldata, id.var = c("names_subject_test_train", "labels_actv_y"))
a = dcast(union, names_subject_test_train + labels_actv_y ~ variable,mean)
write.table(a, "a.txt" , sep = ";")
