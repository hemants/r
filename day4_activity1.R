# Day 4

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

#now converting the column 
dataset_catAttr$ID = as.factor(dataset_catAttr$ID)
str(dataset_catAttr)

#list all the data from global environment
ls()
rm('dataset_numeric')
