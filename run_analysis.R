library(plyr)
#make sure the train and test folders are unzipped and in your working directory, as well as the other txt files in the zipped folder...
#1
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subtr <- read.table("train/subject_train.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subte <- read.table("test/subject_test.txt")
X <- rbind(X_train, X_test) #combine X
y <- rbind(y_train, y_test) #combine y
sub <- rbind(subtr, subte) #combine sub

#2
feat <- read.table("features.txt")
featmeanstd <- grep("-(mean|std)\\(\\)", feat[, 2]) 
X <- X[, featmeanstd]
names(X) <- feat[featmeanstd, 2]

#3
Act <- read.table("activity_labels.txt")
y[, 1] <- Act[y[, 1], 2]
names(y) <- "act"

#4
names(sub) <- "subj"
Tot <- cbind(X, y, sub)

#5
av <- ddply(Tot, .(subj, act), function(x) colMeans(x[, 1:66]))
write.table(av, "averages_data.txt", row.name=FALSE)
