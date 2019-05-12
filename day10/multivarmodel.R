#Read the ‘CustomerData.csv’ data into R. Our objective here is to predict ‘TotalRevenueGenerated’.
customerData = read.csv('day10/CustomerData.csv',header = T)
str(customerData)
summary(customerData) # find anamolies
sum(is.na(customerData)) # no missing values

# sub set the data, remove the age with 113 value.
customerDataClean = customerData[!(customerData$MinAgeOfChild == max(customerData$MinAgeOfChild) | 
                              customerData$MaxAgeOfChild == max(customerData$MaxAgeOfChild)),]
#customerData1 = subset(customerData, !(MinAgeOfChild == max(customerData$MinAgeOfChild))


# convert city to factor
customerDataClean$City = as.factor(as.character(customerDataClean$City))
str(customerDataClean)

# split the data in train and validation set, using random smapling
rows = seq(1,nrow(customerDataClean),1)
set.seed(123)
trainRows= sample(rows, (70*nrow(customerDataClean))/100)
trainCustDataSet = customerDataClean[trainRows,]
validationCustDataSet = customerDataClean[-trainRows,]

# removing customerID column, as this is not required
trainCustDataSet$CustomerID = NULL
validationCustDataSet$CustomerID = NULL

# build the linear regression model
custModel = lm(TotalRevenueGenerated~., data=trainCustDataSet)
summary(custModel)

#residual analysis
par(mfrow=c(2,2))
plot(custModel)

# model evaluation
library(DMwR)
# model performance on train dataset...
regr.eval(trainCustDataSet$TotalRevenueGenerated,custModel$fitted.values)

# model performance on validation dataset...
modelValidate = predict(custModel, newdata = validationCustDataSet)
regr.eval(validationCustDataSet$TotalRevenueGenerated,modelValidate)

# Important: since mape value is similar, we can say model is performing well

#Try different models by performing residual analysis, stepAIC, VIF, p-value analysis
#etc., and try to select significant attributes that improve model’s performance
install.packages('car')
library(car)
vif(custModel) # test for multicov

# Assingment: remove all the columns\variable where VIF from the dataset... and test it on the data set
#trainCustDataSet$CustomerID = NULL
#validationCustDataSet$CustomerID = NULL

install.packages('MASS')
library(MASS)
stepCustModel = stepAIC(custModel, direction = 'both')
stepCustModel
