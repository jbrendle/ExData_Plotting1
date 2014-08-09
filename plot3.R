##########################################################################
# plot3.R This code is part 3 of 4 submitted to meet the requirements of #
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
  
# plot the data in an X-Y line plot of 3 variables to match plot3 in the assignment

png("plot3.png", width=480, height=480)
plot(df$Time, df$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(df$Time, df$Sub_metering_2, col="red")
lines(df$Time, df$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)
dev.off()
