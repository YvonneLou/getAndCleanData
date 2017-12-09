#load the files to R
dat_train<-read.table(paste(getwd(),"/UCI HAR Dataset/train/X_train.txt",sep = ""))
dat_test<-read.table(paste(getwd(),"/UCI HAR Dataset/test/X_test.txt",sep = ""))

dat_trainY<-read.table(paste(getwd(),"/UCI HAR Dataset/train/Y_train.txt",sep = ""))
dat_testY<-read.table(paste(getwd(),"/UCI HAR Dataset/test/Y_test.txt",sep = ""))

#combine
master<-rbind(dat_train,dat_test)
labcol<-rbind(dat_trainY,dat_testY)

#get column name
features<-read.table(paste(getwd(),"/UCI HAR Dataset/features.txt",sep = ""))
coln<-as.character(features[,2])

#rename dataset
names(master)<-coln
#extract mean and std 
colidx<-grep("(\\bmean\\b)|(\\bstd\\b)",coln)
master2<-master[,colidx]

#get activity labels
activity<-read.table(paste(getwd(),"/UCI HAR Dataset/activity_labels.txt",sep = ""))
levl<-activity$V1
labl<-activity$V2

#combine activity(label) column
master2<-cbind(master2,labcol)
master2$V1<-factor(master2$V1,levels = levl,labels = labl)

names(master2)[names(master2)=="V1"] <- "activity"

result<-aggregate(.~activity,master2,FUN = mean)
write.table(result,paste(getwd(),"/UCI HAR Dataset/result.txt",sep = ""),row.names = FALSE)