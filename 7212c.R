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
num_vector_case1_1 = c(1:5)
num_vector_case1_2 = c(1:10)

num_vector_case2_1 = c(1:5)
num_vector_case2_2 = c(1:7)
#a. Combine these two vectors to create a matrix
matrix_case1 = cbind(num_vector_case1_1, num_vector_case1_2);matrix_case1

matrix_case2 = rbind(num_vector_case2_1, num_vector_case2_2);matrix_case2 
#warning: number of columns of result is not a multiple of vector length

#b. Combine these two vectors to create a data frame. What are your observations
#Hint: To create a matrix you may use cbind and to create a data frame use data.frame
dataFrame_case1 = data.frame(num_vector_case1_1, num_vector_case1_2);dataFrame_case1

dataFrame_case2 = data.frame(num_vector_case2_1, num_vector_case2_2);dataFrame_case2
#error: arguments imply differing number of rows: 5, 7


#2. We have seen that in a two-dimensional object for e.g., a matrix, to perform the subset, 
# we use square brackets [ ]. Inside this, the index is given as [rows , columns]. 
# For e.g., If m is a matrix, m[2,3] gives out the element at 2nd row and 3rd column and so on. 
# Now let’s create a matrix of size 3 X5 with the values 1,7, 10, 15, 8, 3, 2, 23, 9, 11, 7, 2, 8,19,1 
# and values filled by row

q2Matrix = matrix(data = c(1,7, 10, 15, 8, 3, 2, 23, 9, 11, 7, 2, 8,19,1 ),nrow = 3, byrow = T );q2Matrix

#a. Extract all the elements that are greater than or equal to 10 from the matrix. Observe the format of the output
for(row in 1:nrow(q2Matrix)){
  for(col in 1:ncol(q2Matrix)){
    if(q2Matrix[row,col] >= 10){
      print(q2Matrix[row,col]); 
    }
  }
}

#b. Now, I want to extract all the rows, if the row has value 10 in any of the second column.
for(row in 1:nrow(q2Matrix)){
  for(col in 1:ncol(q2Matrix)){
    if(col %% 2 ==0 && q2Matrix[row,col] == 10){
      print(q2Matrix[row,]);
      break;
    }
  }
}

#c. Name the rows as r1,r2 and so on and columns as c1,c2 and so on. This can be done
# using function dimnames.
q2Matrix = matrix(data = c(1,7, 10, 15, 8, 3, 2, 23, 9, 11, 7, 2, 8,19,1 ),nrow = 3, byrow = T, dimnames= list(c("r1","r2","r2"),c("c1","c2","c3","c4","c5")) );
q2Matrix;
# Please look in help on how to use it. We have used this
# function in matrix function in class as well. 
# Let’s subset the matrix using the row and column names instead of indices.

# Since these are names and not indices, we may need to use quotes.
# i. Get the element of second row and third columns
q2Matrix[2,3]
# ii. Get all elements of third column
q2Matrix[,3]
# iii. Get elements of first and second row of first column
q2Matrix[c(1,2),1]



