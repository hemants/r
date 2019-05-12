# read bank data
bank_data <- read.csv(file = "day11/bank.txt", header = T,sep = ";")

# describe\study data
str(bank_data);
summary(bank_data)
sum(is.na(bank_data)) #0

# make y to category
bank_data$y = ifelse(bank_data$y=='yes',1,0)
bank_data$y = as.factor(as.character(bank_data$y))

# split data in train and validation
set.seed(123)
rows = seq(1,nrow(bank_data),1)
tainRows = sample(rows,(70*nrow(bank_data))/100)
train_data = bank_data[tainRows,]
val_data = baank_data[-tainRows,]

str(train_data)

#using caret package, to split data using partition method
# Note: caret stands for Classification and Regression Training
# set.seed(123)
install.packages("caret")
library(caret)
train_rows <- createDataPartition(bank_data$y, p = 0.7, list = F)
# The argument "y" to the function is the response variable
# The argument "p" is the percentage of data that goes to training
# The argument "list" should be input a boolean (T or F). Remember to put list = F, else the output is going to be a list and your data can't be subsetted with it
train_data <- bank_data[train_rows, ]
val_data <- bank_data[-train_rows, ]
str(train_data)

#building the model
logRegModel = glm(y~., data=train_data, family = binomial)
summary(logRegModel)

#predict on trained data
prob_train = predict(logRegModel, type = 'response')
prob_val = predict(logRegModel,val_data, type = 'response')

#adding a column named y_hat with outcome
#predict_train = ifelse(prob_train > 0.5,1,0)
#table(train_data$y_hat,predict_train)

# get best threshold value
#install.packages("ROCR")
library(ROCR)
pred_train = prediction(prob_train,train_data$y)
perf_train = performance(pred_train,measure = 'tpr',x.measure = 'fpr')

plot(perf_train, col=rainbow(10), colorize=T, print.cutoffs.at=seq(0,1,0.05))
perf_auc <- performance(pred_train, measure="auc")
auc <- perf_auc@y.values[[1]]
print(auc)

prob_val <- predict(logRegModel, val_data, type = "response")
preds_val <- ifelse(prob_val > 0.1, 1, 0) 
table(preds_val)

# Confusion matrix


#Validation TPR 
#1. 0.5 - 
#2. Custom rock
#3. GVIF
#4. AIC