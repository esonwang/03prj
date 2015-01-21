x_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
x_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
features<-read.table("./UCI HAR Dataset/features.txt")
datax<-rbind(x_test,x_train)
datay<-rbind(y_test,y_train)
colnames(datax)<-c(as.character(features[,2]))
Mean<-grep("mean()",colnames(all.x),fixed=TRUE)
SD<-grep("std()",colnames(datax),fixed=TRUE)
needdata<-datax[,c(Mean,SD)]
dataxy<-cbind(datay,needdata)
activity_labels[,2]<-as.character(activity_labels[,2])
for (i in 1:length(dataxy[,1]))
{dataxy[i,1]<-activity_labels[dataxy[i,1],2]}
subject<-rbind(subject_test,subject_train)
need<-cbind(subject,dataxy)
colnames(need)[1]<-c("subject")
colnames(need)[2]<-c("activity")
Tidy <- aggregate( need[,3] ~ subject+activity, data = need, FUN= "mean" )
for(i in 4:ncol(need)){
             Tidy[,i] <- aggregate( need[,i] ~ subject+activity, data = need, FUN= "mean" )[,3]
        }
colnames(Tidy)[3:ncol(Tidy)] <- colnames(dataxy)
write.table(Tidy,file="fd.txt")
