# Set working directory to location of file
setwd(dirname(rstudioapi::getSourceEditorContext()$path))

zipFolderName <- "exdata_data_household_power_consumption.zip"
if(!file.exists(zipFolderName)){
  zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(zipUrl, zipFolderName)
  unzip(zipFolderName)
}


# load data
colclasses = c("character", "character", "numeric", "numeric","numeric","numeric","numeric","numeric","numeric")
data <- read.table(file = "household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?",colClasses = colclasses);head(data)

# convert date and time values
subset <- subset(data, Date %in% c("1/2/2007", "2/2/2007"))
subset$Date <- as.Date(subset$Date, format="%d/%m/%Y")
datetime <- as.POSIXct(paste(subset$Date,subset$Time))
subset$Datetime <- datetime

# plot and save in png
png(filename="plot3.png", width = 480, height = 480)
plot( subset$Datetime, subset$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines( subset$Datetime, subset$Sub_metering_2, type="l", col ="Red")
lines( subset$Datetime, subset$Sub_metering_3, type="l", col ="Blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1  )
dev.off()

