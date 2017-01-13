## check current working directory
getwd()

## set working directory
setwd("E:\\DataScience\\DEV\\ExData_Plotting1")

## set destination zip filename
zipFileName <- "household_power_consumption.zip"
## download file
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", zipFileName)
## unzip the zip file
unzip(zipfile = zipFileName)

## calculate memory requirement
## According to https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
## Number of Instances: 2075259
## Number of Attributes: 9
## Estimate 10 bytes/attribute
memReqInMB <- (2075259 * 9 * 10) / 2^20

## read data in
epc <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";",
                  colClasses=c(rep("character", 2), rep("numeric",7)), 
                  na="?")

## subsetting - We will only be using data from the dates 2007-02-01 and 2007-02-02
feb2 <- subset(epc, Date == "1/2/2007" | Date == "2/2/2007" )

## add a new variable call myTime to epc
feb2 <- transform(feb2, myTime = strptime(paste(Date, Time, sep = " "), "%d/%m/%Y %H:%M:%S"))

## take a quick look at feb2
head(feb2)

## Open png device;  create 'plot4.png' in the current working directory
png(filename = "plot4.png", width = 480, height = 480)

## Create plot
par(mfrow=c(2,2))
#graph 1
plot(feb2$myTime, feb2$Global_active_power, col = "black", type = "l"
     , xlab = ""
     , ylab = "Global Active Power (killowatts)")

#graph 2
plot(feb2$myTime, feb2$Voltage, col = "black", type = "l"
     , xlab = "datetime"
     , ylab = "Voltage")

#graph 3
plot(feb2$myTime, feb2$Sub_metering_1, col = "black", type = "l"
     , xlab = ""
     , ylab = "Energy sub metering")

lines(feb2$myTime, feb2$Sub_metering_2, col = "red", type = "l")
lines(feb2$myTime, feb2$Sub_metering_3, col = "blue", type = "l")

legend("topright", col = c("black", "red", "blue")
       , lty = c(1,1,1)
       , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#graph 4
plot(feb2$myTime, feb2$Global_reactive_power, col = "black", type = "l"
     , xlab = "datetime"
     , ylab = "Global_reactive_power")

## Close the png file device
dev.off()
