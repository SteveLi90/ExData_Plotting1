## Getting full dataset
Rdata <- read.csv("household_power_consumption.txt", header = T, sep = ';', 
                      na.strings = "?", nrows = 2075259, check.names = F, 
                      stringsAsFactors = F, comment.char = "", quote = '\"')
Rdata$Date <- as.Date(Rdata$Date, format = "%d/%m/%Y")

## Subsetting the data
data <- subset(Rdata, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(Rdata)

## Converting dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Generating Plot 2
plot(data$Global_active_power ~ data$Datetime, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab = "")