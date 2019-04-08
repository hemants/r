#mean, median and range
data = c(15,21,20,20,20)
mean(data)
median(data)
range_data = range(data)
range_data[2] - range_data[1]

#standard deviation
sd(data)

#mode
table_data=table(data) #gives frequency of unique number
table_data
#now get max from above table
max(table_data)
index = which.max(table_data)
index
names(index) #20

#bi-mode - assingment
vec = c(100,7,21,100,13)
which.max(vec)
vec[vec==names(which.max(vec))]

#quartiles
scores = c(7,7,8,10,6,7,4,9,8,9,10,9)
quantile(scores)

#Inter quartile range
IQR(scores)

# outliers - assingment

#Z-score
z_data=c(13,46,2,17,5,9,8,43,3,18)
z_mean = mean(z_data)
z_mean
z_sd = sd(z_data)
z_sd
(z_data-z_mean)/z_sd
