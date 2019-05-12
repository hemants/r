flightDelay = read.csv(file = "day11/FlightDelays.csv", header = T,sep = ",")
str(flightDelay)
summary(flightDelay)
unique(flightDelay$Weather)
