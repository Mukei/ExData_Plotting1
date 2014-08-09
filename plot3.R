# Plotting Assignment 1 for Exploratory Data Analysis (exdata-004)
#
# Our overall goal here is simply to examine how household energy usage varies 
# over a 2-day period in February, 2007. Your task is to reconstruct the 
# following plots below, all of which were constructed using the base plotting system.

## plot3 ------------------------------------------------------------------
# Load needed library -----------------------------------------------------

# Working with data.table is computationally more effecient than working with data.frame
library("data.table")

# Download the data if not already available in script folder -----------
if(!file.exists("./exdata-data-household_power_consumption.zip"))
{
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile = "./exdata-data-household_power_consumption.zip", method = "curl")
}

# Read the data and put it into a data.frame ------------------------------
dt <- data.table(read.csv(unzip("./exdata-data-household_power_consumption.zip"), header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE))

dt$dateValid <- as.Date(dt$Date, "%d/%m/%Y")
dt <- dt[(dt$dateValid ==  "2007-02-01" | dt$dateValid ==  "2007-02-02"),]
datetime <- strptime(paste(dt$Date, dt$Time), "%d/%m/%Y %H:%M:%S")


# Figure 3 ----------------------------------------------------------------
png(filename = "./plot3.png",width = 480, height = 480, units = "px")
with(dt, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(dt, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(dt, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = par("lwd"))

# Save the plot in 480x480pixels png
dev.off()

