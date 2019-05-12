#----------I. In the following exercise, you will do basic data-preprocessing on a given dataset. ----------

#1. Read the dataset ‘airquality.csv' into the environment with name ‘airquality_data'
airquality_data = read.csv('CUTe/airquality.csv')

#2. See the head and summary and structure of the data
head(airquality_data)
summary(airquality_data)
str(airquality_data)

#3. How many missing values are there in the data?
sum(is.na(airquality_data)) # ANS: 44

#Q4. To impute missing values in each of the columns, what do you think is the best strategy? 
# Hint: You may check the summary, find the skewness and decide on whether to impute with mean/median.
#Keep the imputed data in the data frame airquality_data_clean

length(airquality_data[,1]) 
summary(airquality_data)
manyNAs(airquality_data, 0.1)
# there are total 153 data points, since from Ozone column there are 37 missing values and from  Solar.R there are 7,
# and there are 29 rows with 10% above missing value so instead of removing them, shall use central imputation. 

library(DMwR)
airquality_data_clean<-centralImputation(airquality_data) #Cenral Imputation
sum(is.na(airquality_data_clean))
summary(airquality_data_clean)

#Q5. Now that we don't need the data frame airquality_data, remove it from the environment
list=ls(all=TRUE)
rm(list=list[list=='airquality_data'])

#Q6. Are there any variables that need to be type-converted? 
# Find out from the structure of the data. Do necessary type-conversion if required.

#Converting categorical attributes as factors
airquality_data_clean$Month<-as.factor(airquality_data_clean$Month)
airquality_data_clean$Day<-as.factor(airquality_data_clean$Day)
str(airquality_data_clean)

#7. Create dummies for the variable Month, and cbind the dummy columns to the airquality_data_clean.
library(dummies)
dummyMonths = dummy(airquality_data_clean$Month)
head(dummyMonths)

airquality_data_clean = data.frame(airquality_data_clean,dummyMonths)
head(airquality_data_clean)

#Q8. Now remove the Month column from the dataframe
airquality_data_clean= subset(airquality_data_clean, select=-c(Month))
head(airquality_data_clean)

#Q9. Some columns have varied ranges, and hence standardization is a
#necessary preprocessing technique for them. What are those columns.
#Min-Max standardise them in the data frame airquality_data_clean.
summary(airquality_data_clean)
library(vegan)
# get all numeric columns whihc are required for standardization
airquality_data_std = subset(airquality_data_clean, select= c(Ozone,Solar.R,Wind,Temp))
airquality_data_std = decostand(airquality_data_std,"standardize")
summary(airquality_data_std)
airquality_data_clean = subset(airquality_data_clean, select= -c(Ozone,Solar.R,Wind,Temp))
airquality_data_clean = data.frame(airquality_data_clean,airquality_data_std)
summary(airquality_data_clean)

#10. Observe that the data that you have is processed, clean, and is ready
#for being input to a model! Good job. 

#----------II. In the following question, you will simulate a dataset, and do basic analysis on the data.-----
# Let’s simulate a small transactions data for retail store for a single day. The
# attributes are the purchase time, number of customers checked-in in a time-interval, 
# and the amount spent by the customers and so on..
#1. Set the seed to 123.
#Hint: type the following code.
set.seed(123)

#2. Create a vector "purchase_time" of size 100, with values between 7 to 21. 
# Consider this as the time in hrs of purchasing an item.(15 means 15:00hrs or 3:00PM)
# Hint: use the function sample()
purchase_time = sample(7:21,100,replace = T)

# 3. Create a vector "customers_checkedin", by considering that the customers follow a 
# uniform distribution with a minimum of 1 customer to a maximum of 12 customers, present in the store.
#Hint: use the function runif()
customers_checkedin = runif(100, min=1, max=12)

#4. Create a vector "amount_spent", by considering that the customers’
#spending follows a normal distribution with a mean of 500 and standard deviation of 100
#Hint: use the function rnorm()
amount_spent = rnorm(100, mean=500, sd=100)
  
#5. Create a data frame "retail_data" with all the above vectors as columns. 
# See the head, summary, and structure of the data
retail_data = data.frame(purchase_time,customers_checkedin,amount_spent)
  
#6. As the purchase_time_hrs is in hours, lets bin it based on the following scheme:
#  >=7 and <9 = early_morning
#>=9 and <12 = pre_noon
#>=12 and <15 = after_noon
#>=15 and <18 = early_evening
#>=18 = late_evening
#Hint:
#  • Create an empty factor variable "purchase_time_bins" with levels given above. See the factor() function help.
#  • Then fill it based on the condition on purchase_time_hrs
#Eg: If purchase_time_hrs is (>=7 and <9) then purchase_-
#  time_bins = 'early_morning'
#a) Achieve this using data frame/vector subsetting
#purchase_time_bins

#b) Achieve this using if-else statements
purchase_time_bins = vector(mode = 'character')
for (i in 1:nrow(retail_data)){
  timeTemp = retail_data$purchase_time[i]
  if (timeTemp >=7 && timeTemp < 9){ 
    purchase_time_bins[i]= 'early_morning'
  }
  if (timeTemp >=9 && timeTemp < 12){ 
    purchase_time_bins[i]= 'pre_noon'
  }
  if (timeTemp >=12 && timeTemp < 15){ 
    purchase_time_bins[i]= 'after_noon'
  }
  if (timeTemp >=15 && timeTemp < 18){ 
    purchase_time_bins[i]= 'early_evening'
  }
  if (timeTemp >18){
    purchase_time_bins[i]= 'late_evening'
  }
}
summary(purchase_time_bins)

#7. Add the vector “purchase_time_bins” to the data frame 'retail_data'
retail_data = data.frame(retail_data, purchase_time_bins)

#8. How many number of customers have checked-in to the store, on this given day?
sum(retail_data$customers_checkedin)

#9. What is the total amount spent by the customers, on this given day?
sum(retail_data$amount_spent)

#  10.What is the average amount spent by per customer, on this day?
sum(retail_data$amount_spent) / sum(retail_data$customers_checkedin)

#  11.What is the time-bin in which the most transactions have happened?
tapply(retail_data$amount_spent,retail_data$purchase_time_bins,sum) #pre_noon

#  12.For each of the time bins, find the average amount spent by the customers. 
# Use appropriate function from apply family of functions to achieve this.
tapply(retail_data$amount_spent,retail_data$purchase_time_bins,mean)

#13.Plot a bar plot to find average number of customers on the floor,
#across time-bins.
#Hint: use barplot()
barplot(retail_data$customers_checkedin)

#14.Make sure to keep question numbers, and observation in comments.
