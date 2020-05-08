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
png(filename="plot2.png", width = 480, height = 480)
plot( subset$Datetime, subset$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

