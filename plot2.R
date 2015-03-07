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

##draw a line graph of global active power against time
png("plot2.png")
with(power_data, plot(Time, 
                      Global_active_power, 
                      type="l", 
                      xlab="", 
                      ylab="Global Active Power (kilowatts)"))
dev.off()
