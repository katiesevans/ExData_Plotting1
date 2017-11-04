library(data.table)
library(lubridate)
library(dplyr)
setwd("~/Documents/Work/ExData_Plotting1/")

#Download, unzip, and read data file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "power_consumption.zip")
powerdf <- read.table(unz("power_consumption.zip", "household_power_consumption.txt"), sep = ";", 
                      na.strings = "?", header = TRUE)

#Subset dataframe to keep only 2007-02-1 thru 2007-02-02
powerdf$Date <- as.Date(powerdf$Date, "%d/%m/%Y")

feb2007 <- powerdf %>%
  dplyr::filter(Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02"))) %>%
  dplyr::mutate(datetime = as.POSIXct(strptime(paste(Date, Time), "%Y-%m-%d %H:%M:%S")))

#plot global active power histogram
png("plot2.png")
with(feb2007, plot(datetime, Global_active_power, type = "n", 
                   ylab = "Global Active Power (kilowatts)", xlab = ""))
lines(x = feb2007$datetime, y = feb2007$Global_active_power)
dev.off()
