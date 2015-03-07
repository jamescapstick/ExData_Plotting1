##this script requires that the "Individual household electric power 
##consumption Data Set" is downloaded and unpacked in your working
##directory, and that the packages "data.table" and "dplyr" are installed
##
##download from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
##
##extract the zip file to your working directory
##
##run this script to generate your plot
##

library(data.table)
library(dplyr)

##read dates and times as characters, we'll convert them to dates in a moment
power_data <- read.table("household_power_consumption.txt", 
                         sep=";", 
                         header=TRUE, 
                         na.strings=c("?",""), 
                         colClasses=c("character", 
                                      "character", 
                                      "numeric", 
                                      "numeric", 
                                      "numeric", 
                                      "numeric", 
                                      "numeric", 
                                      "numeric", 
                                      "numeric"))

##select just the rows we want
power_data <- filter(power_data, Date=="1/2/2007" | Date=="2/2/2007")

##convert the dates and times into something useful
power_data$Date <- strptime(power_data$Date, "%d/%m/%Y")
power_data$Time <- strptime(power_data$Time, "%H:%M:%S")

##collate the date and time into one column
power_data$Time$year <- power_data$Date$year
power_data$Time$mon <- power_data$Date$mon
power_data$Time$mday <- power_data$Date$mday

##draw line graphs of the sub metering readings against time
png("plot3.png")
with(power_data, plot(Time, 
                      Sub_metering_1, 
                      type="l", 
                      xlab="", 
                      ylab="Energy sub metering"))
with(power_data, lines(Time, Sub_metering_2, col="Red"))
with(power_data, lines(Time, Sub_metering_3, col="Blue"))
legend("topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, 
       col=c("Black", "Red", "Blue"))
dev.off()
