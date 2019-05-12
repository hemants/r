###Covariance and correlation
data<-data.frame(X=c(10,12,11,15,18), Y= c(18,24,20,29,35))
cov(data$Y,data$X)  #H-> is the vriables related in positve or nagetive manner, and dependent on scale
cor(data$X,data$Y)  #H-> this standardize the scale and the value will not get effected by scale 
data

data$newx=data$X*230; data$newy=data$Y*1000
cov(data$newy,data$newx)
cor(data$newx,data$newy)

#Observe that when the scales are changed, cov changed but correlation did not


######Simple linear Regression- 
#Plan- Consider a data set-- simple linear regression, identify outliers, 
#influentiential observations leverages and 
# remove those observations again build the lm model- Interpretation

#For simplicity
getwd()
#setwd(" ")
library(DMwR) # For obtaining evaluation metrics, data mining with R

data_reg <- read.csv("day9/dataset/Data_Regression.csv",header=T,sep=",")
summary(data_reg)

#Is there any relationship between X and Y
plot(data_reg$X,data_reg$Y)

#The relation in Quantitative terms
cor(data_reg$X,data_reg$Y)

#Linear Regression model
mod_lm <- lm(Y~X,data=data_reg)

##Is the model significant
summary(mod_lm) #p-value for F statistic is less than 0.05 implies that the model is better than 
#naive one(predicting mean value of 'Y' for any value of 'X')

# Is 'X' significant in predicting 'Y'
# As the p-value for estimated slope is less than 0.05, it is significant

#Looking at the R square value (0.23).  23% variance in Y is explained by X 

## Predict
data_reg$pred <- predict(mod_lm,newdata = data_reg) # These are the predicted values

# predict(mod_lm,newdata = data.frame(X = c(1,2,3)))

## Evaluate
regr.eval(data_reg$Y,data_reg$pred)

# MAE: mean absolute error 
# MSE: mean square error
# rmse: root mean square error
# mape: mean absolute percentage error

#Plotting the residuals and checking the assumptions
par(mfrow=c(2,2))
plot(mod_lm)
#From the residual plots, What is point 10. 
#Does it have a high leverage, is it influential.
#Is it an outlier

#Lets compute Leverage values and the residual
data_reg$lev<-(((data_reg$X - mean(data_reg$X))/sd(data_reg$X))^2 +1)/36
data_reg$resid<-mod_lm$residuals

#There is an underlying assumption in linear regression that 
#the errors are normally distributed.
#To check this, lets perform Shapiro wilk test on the residuals
shapiro.test(data_reg$resid)
# Shapiro-Wilk normality test
# 
# data:  data$resit
# W = 0.83897, p-value = 0.0001072 
#We reject the null hypothesis that this is normally distributed

#Which datapoint has the highest leverage
data_reg[which.max(data_reg$lev),] 
# Observe that the point with highest leverage is point 33 which has a residual of 171.18

#From the plot, we observe that point 10 has a highest residual
data_reg[which.max(data_reg$resid),]
#Observe that though, this point has high residual its leverage is not very high.

#Which of these points are outliers. Lets consider cook's distance
data_reg$cook <- round(cooks.distance(mod_lm),2)

#Influential points are those, which change the regression line too much. What if 
#we remove these points and build the lm model again

data_reg_1 <- data_reg[-c(10,33),c(1,2)]
mod_lm_1 <- lm(Y~X,data=data_reg_1)
summary(mod_lm_1)
plot(data_reg_1$X,data_reg_1$Y)
par(mfrow=c(2,2))
plot(mod_lm_1)

#Observe that the model significance, variable significance and R2 values improved over the previous
#model. Now X is able to explain 31.4% variance in Y. 
data_reg_1$pred <- predict(mod_lm_1,data_reg_1)
data_reg_1$resid <- mod_lm_1$residuals

#Does this follow a nortmality assumption
shapiro.test(data_reg_1$resid)
# Shapiro-Wilk normality test
# 
# data:  data_reg_1$resid
# W = 0.97314, p-value = 0.5531 #We donot have enough evidence to reject the null hypothesis-
#Now the errors are normally distributed, which is also evident from q-q plot

## Reset row index
rownames(data_reg_1) <- 1:nrow(data_reg_1)

data_reg_1$lev<-(((data_reg_1$X - mean(data_reg_1$X))/sd(data_reg_1$X))^2 +1)/34
data_reg_1$cook<-cooks.distance(mod_lm_1)

data_reg_1[which.max(data_reg_1$lev),] 
data_reg_1[which.max(data_reg_1$cook),]
data_reg_1[which.max(data_reg_1$resid),]
regr.eval(data_reg_1$Y,data_reg_1$pred)

##Removing another data point that has high leverage and cooks distance
data_reg_2 <- data_reg_1[-30,c(1,2)] #Removing the 30th data point
mod_lm_2 <- lm(Y~X,data=data_reg_2)
plot(mod_lm_2)
summary(mod_lm_2)

#Observe that the model significance, variable significance and R2 values improved over the previous
#model. Now X is able to explain 35.3% variance in Y. 
data_reg_2$pred <- predict(mod_lm_2,data_reg_2)
data_reg_2$resid <- mod_lm_2$residuals
shapiro.test(data_reg_2$resid)
# Shapiro-Wilk normality test
# 
# data:  data2$resid
# W = 0.97818, p-value = 0.7452 #Normalcy assumption is maintained 

regr.eval(data_reg_2$Y,data_reg_2$pred)

# Observe the error metrics for all the three data 
regr.eval(data_reg$Y,data_reg$pred) #Initial data
# mae          mse         rmse         mape 
# 7.054641e+01 1.155829e+04 1.075095e+02 5.379166e-02 
# 
regr.eval(data_reg_1$Y,data_reg_1$pred) #data with two points with high leverage and cooks distance removed
# mae          mse         rmse         mape 
# 5.450148e+01 4.827898e+03 6.948307e+01 4.379498e-02
# 
regr.eval(data_reg_2$Y,data_reg_2$pred) #Another point with cooks distance>0.5 removed
# mae          mse         rmse         mape 
# 5.335098e+01 4.484977e+03 6.696997e+01 4.286107e-02


#We removed 3 points which had high leverage and high cooks distance. 
#now observing the Q-Q plots and result from Shapiro Wilk test, 
#the errors appear to be normal.
#In some instance, the model is predicting high values. Also, observe that the region in which 
#we have high error is the region where we have too few values.

#We can check the following:
#1. Do these values/data points belong to same sample. 
#For example, we are experimenting for car and collected the data for buses !! 
#2. If these are genuine points, then can we get more number of data points in this region
#3. We analysed the data with points included and points removed. we present both these analyses 
# and let the client decide if these points are important.

#Since this is a univariate analysis, we are able to visualize, look at the data points and
#perform the analysis. In multilinear regression, when we have many independent variables, it is
#difficult to visualize the influences so we rely on computations to check influences.


##### Some notes on leverage,outliers and influential points######
#1. Points that have extreme "X" values are said to have high leverage 
#2. High leverage points have ability to move the line


#3. Points that have high values in y-direction are said to be an outlier


#If a point has both high leverage and is extreme in y, then it can be an 
#influential point. 

#How to identify an influential point:
#Check the points which has high leverage and high residuals.
#Run a linear regression on data with these points included and excluded and
#see if the coefficients, t statistics R-sq etc change drastically..
