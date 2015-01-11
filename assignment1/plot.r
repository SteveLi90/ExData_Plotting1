readFile <- file("household_power_consumption.txt")

myData <- read.table(text = grep("^[1,2]/2/2007", readLines(readFile), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

### Generating Plot 1

hist(myData$Global_active_power, col = "red", main = paste("Global Active Power"), xlab = "Global Active Power (kilowatts)")

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
	
	 ## Generating Plot 3
	 with(data, {
	     plot(Sub_metering_1 ~ Datetime, type = "l", 
	     ylab = "Global Active Power (kilowatts)", xlab = "")
	     lines(Sub_metering_2 ~ Datetime, col = 'Red')
	     lines(Sub_metering_3 ~ Datetime, col = 'Blue')
	 })
	 legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
	        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

			## Generating Plot 4
			par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
			with(data, {
			     plot(Global_active_power ~ Datetime, type = "l", 
			     ylab = "Global Active Power", xlab = "")
			     plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
			     plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
			          xlab = "")
			     lines(Sub_metering_2 ~ Datetime, col = 'Red')
			     lines(Sub_metering_3 ~ Datetime, col = 'Blue')
			     legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
			             bty = "n",
			             legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
			     plot(Global_reactive_power ~ Datetime, type = "l", 
			          ylab = "Global_rective_power", xlab = "datetime")
			})