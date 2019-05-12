# Day 4
# Case study 1
# Given is a data about customers of a bank. At some point, the bank wants to use an automatic system to predict whether loan can be granted to a customer based on his/her credentials. But before building that system, we need to clearly understand the data and prepare the data accordingly. This exercise gives you a glimpse of general pre-processing aspects followed during data preparation. However, please note that not every time, and not on all kinds of data, we need to perform all these steps.
# 1. Reading a file into R
# a. How to read a csv file into R
# 2. Data 30000 ft overview
# a. Structure of the data
# b. Summary of the data
# c. Viewing the first ‘n’ and last ‘n’ records of the data
# 3. You might now observe that the data type interpretation by R for some of the variables might not be appropriate.
# a. Convert variables to appropriate data types
# 4. Creating different kinds of data- What kind of data type might give better prediction capabilities and also what kind of data appropriate for algorithms
# a. A numeric variable values converted into several buckets i. Binning- Equal width and equal frequency binning
# b. A categorical variable levels converted to individual columns i. Dummification
# 5. Importance of standardization and scaling a. Standardization of data

# remove all the global environment variables in R
rm(list=ls(all=T))
getwd()

# Import data set which in form of csv, since first row in csv is headers set 'header=T'
dataset = read.csv("dataset/Data.csv", header = T);

# Turns out it is a data frame.
class(dataset)

# -- Understanding the dataset --
head(dataset)       #get first 6 records, default
head(dataset,7)     #get first 7 records
tail(dataset)       #get last 6 records, default
tail(dataset,7)     #get last 7 records
str(dataset)        #get the view of the dataset
summary(dataset)    #get a summay of the dataset
sum(is.na(dataset)) #checks for null values in the dataset
names(dataset)      #gives the names of all columns in the dataset
      
# -- Read few records from the dataset --
temp_ds=dataset[1:5,1:6]
is.na(temp_ds) # how is.na works ?

# Now to set correct dataype of column to R
dataset$ID = as.factor(dataset$ID) # set correct type for ID column
summary(dataset) 
str(dataset)

#--Sub setting the datset by column names --

#get all numeric columns
dataset_numericAttr = subset(dataset, select = c(Age,Experience, Income, CCAvg, Mortgage))
head(dataset_numericAttr)

#get all categorical colums, by excluding numeric column
dataset_catAttr = subset(dataset, select = -c(Age,Experience, Income, CCAvg, Mortgage))
head(dataset_catAttr)
str(dataset_catAttr)

#now converting the column 
#dataset_catAttr$ID = as.factor(dataset_catAttr$ID)
dataset_catAttr = data.frame(apply(dataset_catAttr, 2, function(x){as.factor(x)}))
str(dataset_catAttr)

#Install and load the library ***
install.packages("infotheo")
library(infotheo)

#Converting the ratio value to categeory

#use the above package and use equal frequency method to create bin
#this first sort the values and consolidate duplicate value and then divide them to equal frequency.
incomeBin = discretize(dataset$Income, disc="equalfreq", nbins = 4)
table(incomeBin)

#get min and max value for income
tapply(dataset$Income, incomeBin, min)
tapply(dataset$Income, incomeBin, max)

#this first sort the values and consolidate duplicate value and then divide them to equal frequency.
incomeBin = discretize(dataset$Income, disc="equalwidth", nbins = 4)
table(incomeBin)

#get min and max value for income
tapply(dataset$Income, incomeBin, min)
tapply(dataset$Income, incomeBin, max)


#spliting data into bin manually.
summary(dataset$Age)
dataset$newAge = 0
summary(dataset$newAge)
for(i in 1:nrow(dataset)){
  if(dataset$Age[i] >= 45){
    dataset$newAge[i] = 2;
  } else {
    dataset$newAge[i] = 1;
  }
}
summary(dataset$newAge)
table(dataset$newAge)
tapply(dataset$Age, dataset$newAge, min)
tapply(dataset$Age, dataset$newAge, max)

# using dummy value for cat variables
install.packages("dummies");
library(dummies);
dummyVars = dummy(dataset$Education);
head(dummyVars)
dataset = data.frame(dataset,dummyVars)
head(dataset)

#standardizing the data
install.packages("vegan")
library(vegan)
# standardize value in range of 0 to 1.
dataset_numericAttr1 = decostand(dataset_numericAttr, "range");head(dataset_numericAttr1)
# 
dataset_numericAttr2 = decostand(dataset_numericAttr, "standardize");head(dataset_numericAttr2)

#list all the data from global environment
#ls()
#rm('dataset_numeric')
