housingData = read.csv(file = "day12/Housing_data.csv", header = T,sep = ",")
str(housingData)
summary(housingData)

ncol(housingData)
nrow(housingData)
unique(housingData$RAD)
unique(housingData$CHAS)

housingData$CHAS = as.factor(as.character(housingData$CHAS))
housingData$RAD = as.factor(as.character(housingData$RAD))

# drop missing values in MV (target variable)
is.na(housingData$MV)
sum(is.na(housingData$MV))
housingData = housingData[!is.na(housingData$MV),]
nrow(housingData)

# split data in train and validation
set.seed(123)
library(caret)
rowsplit = createDataPartition(housingData$MV, p = 0.7, list = F)
trainingDataset = housingData[rowsplit,]
validationDataSet = housingData[-rowsplit,]

# split into x(independent) and y (dependent)
trainingDataset_x = trainingDataset[,-14]
trainingDataset_y = trainingDataset[,14]

validationDataSet_x = validationDataSet[,-14]
validationDataSet_y = validationDataSet[,14]

# impute other missing values using 
library(DMwR)
trainingDataset_full = knnImputation(trainingDataset_x)
validationDataSet_full = knnImputation(validationDataSet_x, distData = trainingDataset_x)

# combine imputed values back with dependent column, since we are using knn for imputation.
# we didn't involve y values. And now combining the dataset.
trainingDataset_full = data.frame(trainingDataset_full, Target=trainingDataset_y)
validationDataSet_full = data.frame(validationDataSet_full, Target=validationDataSet_y)

# check
head(trainingDataset_full,1)

# build linear model now
linearModel = lm(Target~.,data = trainingDataset_full)
summary(linearModel)

# predict values
predictVals = predict(linearModel, newdata = validationDataSet_full)

# evaluate the model
regr.eval(validationDataSet_full$Target,predictVals) # mape - 0.1684836

# ____now lets try with PCA_________
# for this case let's remove categorical and target values.
pcaTrainDataset = subset(trainingDataset_full, select = -c(CHAS,RAD,Target))
pcaValidationDataset = subset(validationDataSet_full, select = -c(CHAS,RAD,Target))

# get PCA components
pcaTrain = princomp(pcaTrainDataset)
summary(pcaTrain)
pcaTrain$loadings

pcaPredictTrainData = predict(pcaTrain, pcaTrainDataset)
head(pcaPredictTrainData,1)
pcaPredictValidationData = predict(pcaTrain, pcaValidationDataset)
head(pcaPredictValidationData,1)

# check how many components are really required, draw a graph
plot(pcaTrain)

# now comnbine with first 3 components and train a model again
head(trainingDataset_full)
pcaTrainCombined = data.frame(pcaPredictTrainData[,1:3], trainingDataset_full[,c(4,9,14)])
head(pcaTrainCombined)

pcaValidationCombined = data.frame(pcaPredictValidationData[,1:3], validationDataSet_full[,c(4,9,14)])
head(pcaTrainCombined)

pcaTransformedModel = lm(Target~., data=pcaTrainCombined)
summary(pcaTransformedModel)
summary(linearModel)

class(pcaPredictValidationData)
pcsPredictVals = predict(pcaTransformedModel, newdata = data.frame(pcaPredictValidationData))
# evaluate the model
regr.eval(pcaTrainCombined$Target,pcsPredictVals) # mape - 0.1684836 ERROR

#_______ now standardize the data __________
finalTrainObject = preProcess(trainingDataset_full, method = 'scale')
finalTrainDataset = predict(finalTrainObject, trainingDataset_full)
head(finalTrainDataset,1)
finalValidationDataset = predict(finalTrainObject, validationDataSet_full)
head(finalValidationDataset,1)

# now do PCA on final dataset (train)

pcaFinalTrain = princomp(subset(finalTrainDataset, select = -c(CHAS,RAD,Target)))
summary(pcaFinalTrain)
pcaFinalTrain$loadings

#now take only first 5 component
head(finalTrainDataset,1)
pca_std_dataTrain = data.frame(finalTrainDataset[,1:7],finalTrainDataset)
