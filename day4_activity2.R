# Day 4 -session 2
# case study 2:
# Data, you have seen in case study1 is difficult to get. It is almost like food served on plate ready to eat. Most often, 
# we need to prepare our own food(-Data). Here are some of the scenarios of how data might be received.
# 1. Data in multiple files. For simplicity, let us assume we have two data files for the same data that we worked with in case study1
# 2. Data with missing values- Should you ignore the records or is there another way
# 3. Transactional data- For the same customer, there might be multiple transactions how to work on such data.
# 4. If the data has time stamps from which important information can be extracted, how to work with time.

custData = read.csv("dataset/Customer_Bank Details_MV.csv")
str(custData)
summary(custData)

demoData = read.csv("dataset/Customer_Demographics_MV_DOB.csv")
str(demoData)
summary(demoData)

transData = read.csv("dataset/Transactions.csv")
str(transData)
summary(transData)

# get unique customer
length(unique(custData$ID))
length(unique(demoData$Customer.ID))
length(unique(transData$ID))

#aggregate the transaction file data for each customer, this shall make it easy to mearge the records 
#with other data file.
custTrans = aggregate(Amount~ID, data=transData, FUN=sum)
head(custTrans)

#replacing all the with missing value with NA
custData[custData=="?"] = NA
summary(custData)
demoData[demoData=="?"] = NA
summary(demoData)

#now mearge the record
processedCustomerData = merge(custData,demoData, by.x="ID", by.y="Customer.ID")
head(processedCustomerData)

#Observer the data , find missing values
sum(is.na(processedCustomerData))
summary(processedCustomerData)

#drop all the NA data points
processedCustomerDatav2 = na.omit(processedCustomerData)
summary(processedCustomerDatav2)

install.packages("DMwR")
library(DMwR)

# To identify rows where more than 10% attributes are missing
manyNAs(processedCustomerData,0.1)

#imputting missing values
processedCustomerData_imputed = centralImputation(processedCustomerData)
sum(is.na(processedCustomerData_imputed))
summary(processedCustomerData_imputed)


