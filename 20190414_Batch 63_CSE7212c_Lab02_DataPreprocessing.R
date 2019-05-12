#######Introduction to Data Preprocessing########
###Case Study1
rm(list=ls(all=TRUE))
setwd("")
#Importing & exporting data
data<-read.csv("dataset/Data.csv",header=T)

#Undertanding data structure
head(data)
head(data,3)
tail(data)
str(data)
summary(data)
sum(is.na(data))#To check null values in data
names(data)




#Subsetting data
Data_NumAtr<-subset(data,
                    select=c(Age,Experience,
                                  Income,CCAvg,Mortgage))
Data_CatAtr<-subset(data,
                    select=-c(Age,Experience,
                                   Income,CCAvg,Mortgage))


str(Data_CatAtr)
#Converting categorical attributes as factors
Data_CatAtr$ID<-as.factor(Data_CatAtr$ID) # One by one
str(Data_CatAtr)




#All at once  using apply function
Data_CatAtr<-data.frame(
  apply(Data_CatAtr,2,function(x){as.factor(x)}))
str(Data_CatAtr)


#Discretizing the variable
install.packages("infotheo")
library(infotheo)









IncomeBin <- discretize(data$Income, disc="equalfreq",
                        nbins=4)
table(IncomeBin)
#tapply usage
tapply(data$Income,IncomeBin,min)
tapply(data$Income,IncomeBin,max)

IncomeBin <- discretize(data$Income, 
                        disc="equalwidth",nbins=4)
table(IncomeBin)
#tapply usage
tapply(data$Income,IncomeBin,min)
tapply(data$Income,IncomeBin,max)

#Manual recoding (Also learning for loop & if else statements)
summary(data$Age)
data$AgeNew<-0
for (i in 1:nrow(data)){
  if (data$Age[i]>=45){ 
    data$AgeNew[i]=2
  }
  else {
    data$AgeNew[i]=1
  }
}
table(data$AgeNew)
tapply(data$Age,data$AgeNew,min)
tapply(data$Age,data$AgeNew,max)




#Creating dummy variables and adding to original table
library(dummies)
EduDummyVars<-dummy(data$Education)
head(EduDummyVars)
Data<-data.frame(data,EduDummyVars)








#Standardizing the data 
library(vegan)
Data_NumAtr2 <- decostand(Data_NumAtr,
                          "range") # using range method 
Data_NumAtr2 <- decostand(Data_NumAtr,
                          "standardize") # Using Z score method












###Case 2
#Here we have three datasets, customer demographics, back info and transactions info
#we first read these into R
Customer_Bank<-read.csv("dataset/Customer_Bank Details_MV.csv",header=T)
Customer_Demographics<-read.csv("dataset/Customer_Demographics_MV_DOB.csv",header=T)
transactions<-read.csv("dataset/Transactions.csv",header=T)

#Understanding the data 
summary(Customer_Bank)
summary(Customer_Demographics)
summary(transactions)

str(Customer_Bank)
str(Customer_Demographics)
str(transactions)

##There are missing values in the forms of NA and ? in the data, transactions
#data is in melted form, which we need to append to the customer data

#We shall solve each of these step by step
#First aggregating the values in transactions
##Aggregation
cust_level<-aggregate(Amount~ID,data = transactions,FUN=sum)
#Now you can merge this with the original data from analysis

##Working with Missing Values
Customer_Bank[Customer_Bank=="?"]<-NA
Customer_Demographics[Customer_Demographics=="?"]<-NA
#Merging two datasets
MergedData<-merge(Customer_Demographics,Customer_Bank,
                  by.x="Customer.ID",by.y="ID") #inner join

##Observe the data as done in case 1:
#You find there are missing values. 
sum(is.na(MergedData))#To check null values in data
summary(MergedData)

#Dropping the recrods with missing values
MergedData_mv2<-na.omit(MergedData)

#To identify rows where more than 10% attributes 
#are missing
library(DMwR)
manyNAs(MergedData, 0.1) 

#Imputing missing values
library(DMwR)
MergedData_imputed<-centralImputation(MergedData) #Cenral Imputation
sum(is.na(MergedData_imputed))

##There are other ways/methods of imputing. You will learn them soon
## either in class or through assignments

########However, we can work with NA strings while reading the file itself
cus=read.csv("dataset/Customer_Bank Details_MV.csv",header=T,na.strings = c(NA,"?"))
#The advantage of this method is that, the '?' is not treated as factor as
#you might have observed


#In this data set you are now working with Date of birth and not age
#How to extract age from date of birth
install.packages("lubridate")
library(lubridate)
MergedData_imputed$DOB<-as.character(MergedData_imputed$DOB)
MergedData_imputed$DOB<-strptime(MergedData_imputed$DOB,format="%m/%d/%Y")
MergedData_imputed$Age<-year(today())-year(MergedData_imputed$DOB)

#NOw we can remove DOB column and work with age as we have done in Case1

#IN addition to this, we now have the transactional data of the customers for the last year.
#Now we have to add this transctions data to our data. How can we do this
  

#subset


