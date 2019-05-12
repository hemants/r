# regularization
customerData = read.csv(file = "day12/CustomerData.csv", header = T,sep = ",")
str(customerData)
summary(customerData)
ncol(customerData)
nrow(customerData)
sum(is.na(customerData))

# preprocessing...
customerData$City = as.factor(as.character(customerData$City))
customerData$CustomerID = NULL
head(customerData,1)

# dummies using mlr
install.packages("mlr")
library(mlr)
customerDataWithDummy = createDummyFeatures(customerData, method = 'reference')

# split data...
set.seed(123)
library(caret)
rowsplit = createDataPartition(customerDataWithDummy$TotalRevenueGenerated, p = 0.7, list = F)
trainingDataset = customerDataWithDummy[rowsplit,]
validationDataSet = customerDataWithDummy[-rowsplit,]

# fit linear reg model
lrModel = lm(TotalRevenueGenerated~.,data=trainingDataset)
summary(lrModel)
predictedVals = predict(lrModel, newdata = validationDataSet)
regr.eval(validationDataSet$TotalRevenueGenerated,predictedVals)

# lassos model
install.packages("glmnet")
library(glmnet)

trainingDataset_x = as.matrix(data.frame(subset(trainingDataset,select=-c(TotalRevenueGenerated))))
trainingDataset_y = as.matrix(data.frame(subset(trainingDataset,select=c(TotalRevenueGenerated))))

validationDataSet_x = as.matrix(data.frame(subset(validationDataSet,select=-c(TotalRevenueGenerated))))
validationDataSet_y = as.matrix(data.frame(subset(validationDataSet,select=c(TotalRevenueGenerated))))

lassosModel = glmnet(trainingDataset_x, trainingDataset_y, alpha = 1, family = 'gaussian')
summary(lassosModel)
plot(lassosModel,xvar = 'lambda')

# now model selection wiht k-fold validation
lassosModel_cv = cv.glmnet(trainingDataset_x, trainingDataset_y, alpha = 1, family = 'gaussian')
plot(lassosModel_cv)
lassosModel_cv$lambda.1se
lassosModel_cv$lambda.min

# predict
lassosPredictTrain = predict(lassosModel_cv,trainingDataset_x)
regr.eval(trainingDataset_y, lassosPredictTrain)

lassosPredictValidation = predict(lassosModel_cv, validationDataSet_x )
regr.eval(validationDataSet_y, lassosPredictValidation)

# coefficient
coef(lassosModel_cv)

# ridge model
library(glmnet)

ridgeModel = glmnet(trainingDataset_x, trainingDataset_y, alpha = 0, family = 'gaussian')
summary(ridgeModel)
plot(ridgeModel,xvar = 'lambda')

# now model selection wiht k-fold validation
ridgeModel_cv = cv.glmnet(trainingDataset_x, trainingDataset_y, alpha = 0, family = 'gaussian')
plot(ridgeModel_cv)
ridgeModel_cv$lambda.1se
ridgeModel_cv$lambda.min

# predict
ridgePredictTrain = predict(ridgeModel_cv,trainingDataset_x)
regr.eval(trainingDataset_y, ridgePredictTrain)
regr.eval(trainingDataset_y, lassosPredictTrain)

ridgePredictValidation = predict(ridgeModel_cv, validationDataSet_x )
regr.eval(validationDataSet_y, ridgePredictValidation)
regr.eval(validationDataSet_y, lassosPredictValidation)

# coefficient
coef(lassosModel_cv)
coef(ridgeModel_cv)