#1. For the data given above, create a data frame in R, and do the following

group1 = c(0,0,0,0,0,0,1,1,1,16)
group2 = c(3,12,3.5,14,3,2.8,5,9,5.5,9)
group3 = c(14,9.5,4.5,7.5,5,2,4.8,3.6,6,8.5)
group4 = c(9,4.5,9,8,4,6,5,3.5,2.8,12)
group5 = c(16,12,6.5,1,11,5,3,8,3,4)
group6 = c(13,10,10,1,3,4,6,3.8,4,8)

dataFrame = data.frame(group1, group2, group3, group4, group5, group6)

#a. Compute the mean, variance and standard deviation of each group
summary(dataFrame) # gives summary of df

#mean value: by converting data frame to column vector
mean(dataFrame[,1])
mean(dataFrame[,2])
mean(dataFrame[,3])
mean(dataFrame[,4])
mean(dataFrame[,5])
mean(dataFrame[,6])

#mean value: on entire data frame
colMeans(dataFrame)

#variance:
var(dataFrame[,1])
var(dataFrame[,2])
var(dataFrame[,3])
var(dataFrame[,4])
var(dataFrame[,5])
var(dataFrame[,6])

#standard deviation:
sd(dataFrame[,1])
sd(dataFrame[,2])
sd(dataFrame[,3])
sd(dataFrame[,4])
sd(dataFrame[,5])
sd(dataFrame[,6])

#b. Compute mean, variance and standard deviation for the entire data

# join all the data frame column to a vector
df_vector = c(dataFrame[,1],dataFrame[,2])
df_vector = c(df_vector, dataFrame[,3])
df_vector = c(df_vector, dataFrame[,4])
df_vector = c(df_vector, dataFrame[,5])
df_vector = c(df_vector, dataFrame[,6])
length(df_vector)

mean(df_vector)
sd(df_vector)
var(df_vector)

#2. boxplot is a function in R to visualize a boxplot in R. 
# Study the syntax and get the boxplot of the data given above.
boxplot(dataFrame)

# Do you observe any extreme values in any of the groups and 
# Ans: Group 1 have extream value, outlier

# which groups are more similar than others?
# Ans:  Group 3 & 4 

#3. Please review the probability lecture notes and solutions covered previously

#-----------------------------------------------------------------------------------------------
# R Assignment

#1. Create two numeric vectors (elements of your choice). 
# Both these vectors should be of different lengths
# [ Case 1: when longer length is a multiple of shorter length. 
# Case 2: longer length is not a multiple of shorter length]

#a. Combine these two vectors to create a matrix

#b. Combine these two vectors to create a data frame. What are your observations
#Hint: To create a matrix you may use cbind and to create a data frame use data.frame