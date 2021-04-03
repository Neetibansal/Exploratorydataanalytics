library("data.table")

setwd("C:/Users/HP/Desktop/Exploratorydataanalytics")

#Reads in data from file 
PDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents histogram from showing 
PDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date 
PDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates 

PDT <- PDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(PDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()