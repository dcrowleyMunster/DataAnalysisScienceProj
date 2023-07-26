library("data.table")



#Reads in data from file then subsets data for specified dates
inputData <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)


inputData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
inputData[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
inputData <- inputData[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]
png("plot2.png", width=480, height=480)
plot(x = inputData[, dateTime]
     , y = inputData[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()