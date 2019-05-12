#rm(list=ls(all=TRUE))
#setwd("F:\\Academics\\Batch_63\\naivebayesb53activity")

#Read the data into R

data=read.csv(file="day11/FlightDelays.csv", header=T)

data = subset(data,select=-c(FL_DATE,FL_NUM,TAIL_NUM))

DEP_TIME_BIN=0
for(i in 1:2201) {
  if(data$DEP_TIME[i]<600){DEP_TIME_BIN[i]="0500-0559"} 
  else if(data$DEP_TIME[i]<700) {DEP_TIME_BIN[i]="0600-0659"}
  else if(data$DEP_TIME[i]<800) {DEP_TIME_BIN[i]="0700-0759"}
  else if(data$DEP_TIME[i]<900) {DEP_TIME_BIN[i]="0800-0859"}
  else if(data$DEP_TIME[i]<1000) {DEP_TIME_BIN[i]="0900-0959"}
  else if(data$DEP_TIME[i]<1100) {DEP_TIME_BIN[i]="1000-1059"}
  else if(data$DEP_TIME[i]<1200) {DEP_TIME_BIN[i]="1100-1159"}
  else if(data$DEP_TIME[i]<1300) {DEP_TIME_BIN[i]="1200-1259"}
  else if(data$DEP_TIME[i]<1400) {DEP_TIME_BIN[i]="1300-1359"}
  else if(data$DEP_TIME[i]<1500) {DEP_TIME_BIN[i]="1400-1459"}
  else if(data$DEP_TIME[i]<1600) {DEP_TIME_BIN[i]="1500-1559"}
  else if(data$DEP_TIME[i]<1700) {DEP_TIME_BIN[i]="1630-1659"}
  else if(data$DEP_TIME[i]<1800) {DEP_TIME_BIN[i]="1700-1759"}
  else if(data$DEP_TIME[i]<1900) {DEP_TIME_BIN[i]="1800-1859"}
  else if(data$DEP_TIME[i]<2000) {DEP_TIME_BIN[i]="1900-1959"}
  else if(data$DEP_TIME[i]<2100) {DEP_TIME_BIN[i]="2000-2059"}
  else if(data$DEP_TIME[i]<2200) {DEP_TIME_BIN[i]="2100-2159"}
  else if(data$DEP_TIME[i]<2300) {DEP_TIME_BIN[i]="2200-2259"}
  else {DEP_TIME_BIN[i]="2300-2359"}
}

Flight.Status = factor(ifelse(data$Flight.Status == "delayed", 1, 0))

data2 = data.frame(data,DEP_TIME_BIN)
data2$DEP_TIME = NULL

head(data2)
str(data2)
unique(data2$Weather)
data2$Weather = factor(data2$Weather)
rows=seq(1,nrow(data2),1)
set.seed(123)
trainRows=sample(rows,round(nrow(data2)*0.6))
testRows=rows[-(trainRows)]

data_train = data2[trainRows,] 
data_test=data2[testRows,] 

install.packages("e1071")
library(e1071)
model = naiveBayes(Flight.Status ~ CARRIER+DEP_TIME_BIN+DEST+ORIGIN, data = data_train)
model
model2 = naiveBayes(Flight.Status ~ ., data = data_train)
model2
pred = predict(model, data_train)
table(pred, data_train$Flight.Status)

pred = predict(model, data_test)
tabtest = table(pred, data_test$Flight.Status)
library(caret)
confusionMatrix(tabtest)
#Accuracy : 0.8318
pred2 = predict(model2, data_test)
tabtest1 = table(pred2, data_test$Flight.Status)
confusionMatrix(tabtest1)
#Accuracy : 0.8136

#assignment
