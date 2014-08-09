# Plotting Assignment 1 for Exploratory Data Analysis (exdata-004)
#
# Our overall goal here is simply to examine how household energy usage varies 
# over a 2-day period in February, 2007. Your task is to reconstruct the 
# following plots below, all of which were constructed using the base plotting system.

## plot3 ------------------------------------------------------------------

fileName = "./exdata-data-household_power_consumption.txt"


# Check file availability -------------------------------------------------
# Check if txt file available, check for zip file.
# If no zip file to unzip, download the fileDownload the data if not already available in script folder
if(!file.exists(fileName))
{
  if(!file.exists("./exdata-data-household_power_consumption.zip"))
  {
    print("Downloading the data")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "./exdata-data-household_power_consumption.zip", method = "curl")
  }
  else
  {
    unzip("./exdata-data-household_power_consumption.zip")
  }
}

# Read the data and put it into a data.frame ------------------------------
print("Loading data")

# Below method shared on the Forum topics https://class.coursera.org/exdata-004/forum/thread?thread_id=19
df <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'), header = F, sep = ';', na.strings = "?", stringsAsFactors = FALSE, comment.char = "", colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric", "numeric"))

colnames(df) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))

df$dateValid <- as.Date(df$Date, "%d/%m/%Y")
datetime <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")


# Figure 3 ----------------------------------------------------------------
print("Plotting data & saving plot3.png (480x480px)")
png(filename = "./plot3.png",width = 480, height = 480, units = "px")
with(df, plot(datetime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(df, lines(datetime, Sub_metering_2, type = "l", col = "red"))
with(df, lines(datetime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = par("lwd"))

# Save the plot in 480x480pixels png
dev.off()

