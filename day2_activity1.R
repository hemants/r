# Day 4

# remove all the global environment variables in R
rm(list=ls(all=T))

# import data set which in form of csv
getwd()
dataset = read.csv("dataset/Data.csv", header = T); 
class(dataset) # turns out it is a data frame.
summary(dataset) # get a summay of the data.
