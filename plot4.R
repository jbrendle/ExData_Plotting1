##########################################################################
# plot4.R This code is part 4 of 4 submitted to meet the requirements of #
# Course Project 1 of Exploratory Data Analysis, a Coursera Course.      #
# It demonstrates some of the Base Plotting System in R                  #
##########################################################################

# Check to see if household power consumption data set source file exists
#  in the working directory. If not, download it.

if(!file.exists("household_power_consumption.txt")){
  fileUrl <-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}

# Load dataset into R

filename <- "household_power_consumption.txt"
df <- read.table(filename,
                header=TRUE,
                sep=";",
                colClasses=c("character", "character", rep("numeric",7)),
                na="?")

# convert date and time variables to Date/Time class

df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# get data for dates 2007-02-01 and 2007-02-02 as stipulated in the assignment

dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
df <- subset(df, Date %in% dates)
  
# create a png with 4 line plots of 4 different variables to 
# match plot4 in the assignment

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# 1 Same as plot2, will appear in upper left

plot(df$Time, df$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")

# 2 Voltage over time, will appear in the top right

plot(df$Time, df$Voltage, type="l",
     xlab="datetime", ylab="Voltage")

# 3 Same as plot3, will appear in lower left

plot(df$Time, df$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(df$Time, df$Sub_metering_2, col="red")
lines(df$Time, df$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,
       bty="n")

# 4 Global_reactive_power over time, will appear in the lower right

plot(df$Time, df$Global_reactive_power, type="l",
     xlab="datetime", ylab="Global_reactive_power")

dev.off()
