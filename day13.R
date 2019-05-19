# time series analysis
load("Day13/Data.RData")

# study the data...
dim(data)
head(data)
names(data)
str(data)
tail(data)

# get the data formated into Data frame using sql syntax
#install.packages("sqldf")
library(sqldf) 

dailyDataset = sqldf("select Date,min(Price) as MIN_PRICE from data group by Date")
class(dailyDataset)

str(dailyDataset)
# converting column date from factor to date
dailyDataset$Date=as.Date(dailyDataset$Date,format="%Y-%m-%d")
str(dailyDataset)

# handle missing values now...
sum(is.na(dailyDataset))

# with this seems like the data frame have all the required valid values.

# To find the minimum of the dates
minDate=min(as.Date(dailyDataset$Date,format="%Y-%m-%d"));minDate
# To find the maximum of the dates
maxDate =max(as.Date(dailyDataset$Date,format="%Y-%m-%d"));maxDate
# generating the series of dates
seq = data.frame("dateRange"=seq(minDate,maxDate,by="days"))

# now the seq have 1797 points i.e. there are these many days between min and max days.
# where as daily dataset have on 1660 values, we need to impute the other values...

# first let's join the records
# left joining to see the missing values for the dates. all.x will do the left join.”all.y” will do right join.
dailyDatasetAllDates = merge(seq,dailyDataset, by.x="dateRange",by.y="Date",all.x=T)
head(dailyDatasetAllDates)
sum(is.na(dailyDatasetAllDates)) # there are 137 missing values...

#imputing missing values with zoo
#install.packages("zoo")
library(zoo)

#Here is the example to understand how “na.locf()” function works library(zoo)
#x <- c(1,2,3,4,5,NA,7,8)
# na.locf function is used to replace the missing values. This will replace the missing value with the it’s immediate preceding value.
#na.locf(x)
# This function reverses the sequence
#rev(x)
# if you want to replace the missing value with its immediate neighbors, here is the R code. 
# This code is to show that missing value is replaced with it’s preceding and succeeding values na.locf(x)
#rev(na.locf(rev(x)))
#(na.locf(x) + rev(na.locf(rev(x))))/2

# Use the above code to replace the missing values in the Price variable
dailyDatasetAllDates$MIN_PRICE =(na.locf(dailyDatasetAllDates$MIN_PRICE) + rev(na.locf(rev(dailyDatasetAllDates$MIN_PRICE))))/2
plot(dailyDatasetAllDates)

dailyDatasetAllDates$WEEK <- as.numeric(format(dailyDatasetAllDates$dateRange, format="%Y.%W"))
head(dailyDatasetAllDates)
# Now aggregating to weekly data
dailyDatasetAllWeek = sqldf("select WEEK as WEEK, min(MIN_PRICE) as MIN_PRICE from dailyDatasetAllDates group by WEEK")
plot(dailyDatasetAllWeek)

#Dividing data as Train & validation 
trainDatset=dailyDatasetAllWeek[which(dailyDatasetAllWeek$WEEK<=2013.47),]
validationSataset=dailyDatasetAllWeek[which(dailyDatasetAllWeek>2013.47),]

#convert to time series to weekly dataset
trainPriceDatset = ts(trainDatset$MIN_PRICE, frequency =52)
plot(trainPriceDatset,type="l",lwd=3,col="blue",xlab="week",ylab="Price", main="Time series plot")

# decompose data to Trend, seasonality and noise
pricedecomp = decompose(trainPriceDatset)
plot(pricedecomp)

# draw the ACF and PACF graphs.
par(mfrow=c(1,2))
acf(trainPriceDatset,lag=30)
pacf(trainPriceDatset,lag=30)

# lets build average moving graph
#install.packages('TTR')
library(TTR)
fitsma <- SMA(trainPriceDatset,n=2)
fitwma<- WMA(trainPriceDatset,n=2,1:2)
fitEma <- EMA(trainPriceDatset, n = 2)

par(mfrow=c(1,1))
plot(trainDatset$MIN_PRICE, type="l", col="black")
lines(fitsma, type="l", col="red")
lines(fitwma, type="l", col="blue")
lines(fitEma, type="l", col="brown")


#Building the Holt winter’s model taking only Trend component.
holtpriceforecastTrendOnly <- HoltWinters(trainDatset$MIN_PRICE, beta=TRUE, gamma=FALSE)
# Look the fitted or forecasted values
head(trainDatset)
head(holtpriceforecastTrendOnly$fitted)

priceholtforecastTrendseasonal <- HoltWinters(trainPriceDatset, beta=TRUE, gamma=TRUE,seasonal="multiplicative")
# Look the fitted or forecasted values . Did you notice the 
head(priceholtforecastTrendseasonal$fitted)
head(trainDatset)

priceholtforecastAll <- HoltWinters(trainPriceDatset)
# Look the fitted or forecasted values . Did you notice the 
head(priceholtforecastAll$fitted)
head(trainDatset)


# Getting the predictions on Training data & Checking model 
#holtforecastTrain <- data.frame(holtpriceforecast$fitted) 
#holtforecastTrainpredictions <- holtforecastTrain$xhat
#head(holtforecastTrainpredictions)

#install.packages("forecast")
library(forecast)
priceforecast = forecast(holtpriceforecastTrendOnly, h=1);priceforecast
priceforecast = forecast(priceholtforecastTrendseasonal, h=1);priceforecast
priceforecast = forecast(priceholtforecastAll, h=1);priceforecast

# Forecasting on training data
hw_price <- HoltWinters(trainPriceDatset)
#hw_price_gamma <- HoltWinters(Price[1:260], beta=TRUE, gamma=TRUE, seasonal="additive")
hw_price$fitted
train_actuals <- trainPriceDatset[3:261]
train_pred <- data.frame(hw_price$fitted)[1]
DMwR::regr.eval(train_actuals,train_pred)

# forcasting on validation data

library("forecast")
hw_price_forecasts = forecast(priceholtforecastAll,h=1)
validation_preds <- data.frame(hw_price_forecasts)$Point.Forecast
validation_preds
#forecast.HoltWinters(hw_price,h=1)
validation_actuals <- validationSataset$MIN_PRICE
validation_actuals
DMwR::regr.eval(validation_actuals,validation_preds)
