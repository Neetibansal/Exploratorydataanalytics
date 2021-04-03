library("data.table")

setwd("C:/Users/HP/Desktop/Exploratorydataanalytics")

#Reads in data from file 
PDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents Notation
PDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered 
PDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter Date
PDT <- PDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot 3
plot(PDT[, dateTime], PDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(PDT[, dateTime], PDT[, Sub_metering_2],col="red")
lines(PDT[, dateTime], PDT[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
