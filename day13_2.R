# Problem 1:
# Do the following:
# 1. Use the following code to get stock data of Google from yahoo
# 2. Consider only the closing price, aggregate the data weekly
# 3. Implement model and forecast for the next week
# 4. Report the error

# Get the data from start and end date...
# install.packages("quantmod")
library(quantmod)
start <- as.Date("2017-01-01")
end <- as.Date("2019-03-30")
getSymbols("GOOGL", src = "yahoo", from = start, to = end)

# Describe data
class(GOOGL)
dim(GOOGL)
names(GOOGL)
sum(is.na(GOOGL))
str(GOOGL)

# create a dataframe for the dataset with column