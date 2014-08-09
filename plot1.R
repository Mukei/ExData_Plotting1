# Plotting Assignment 1 for Exploratory Data Analysis (exdata-004)
#
# Our overall goal here is simply to examine how household energy usage varies 
# over a 2-day period in February, 2007. Your task is to reconstruct the 
# following plots below, all of which were constructed using the base plotting system.

## plot1 ------------------------------------------------------------------
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
print("Loading data")
dt <- data.table(read.csv(unzip("./exdata-data-household_power_consumption.zip"), header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE))

dt$dateValid <- as.Date(dt$Date, "%d/%m/%Y")
dt <- dt[(dt$dateValid ==  "2007-02-01" | dt$dateValid ==  "2007-02-02"),]
datetime <- strptime(paste(dt$Date, dt$Time), "%d/%m/%Y %H:%M:%S")


# Figure 1 ----------------------------------------------------------------
print("Plotting data & saving plot1.png (480x480px)")
png(filename = "./plot1.png",width = 480, height = 480, units = "px")
with(dt, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power", col = "red"))
dev.off()
