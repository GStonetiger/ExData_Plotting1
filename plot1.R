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
## memory requirement is about 178 MB

## read first 5 lines to find out the field separator character
x <- read.table(file = "household_power_consumption.txt", nrows = 5)
## print x
x
## sep is ; 

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

## Open png device;  create 'plot1.png' in the current working directory
png(filename = "plot1.png", width = 480, height = 480)

## Create plot
hist(feb2$Global_active_power, col = "red", main = "Global Active Power"
     , xlab = "Global Active Power (killowatts)")

## Close the png file device
dev.off()
