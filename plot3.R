library(data.table)
# Read the text file into R
data <- read.table("C:/Users/F&R/Desktop/DS/DS4/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
sdata <- subset(data,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
sdata <- sdata[complete.cases(sdata),]

## Combine Date and Time column
dateTime <- paste(sdata$Date, sdata$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
sdata <- sdata[ ,!(names(sdata) %in% c("Date","Time"))]

## Add DateTime column
df <- cbind(dateTime, sdata)

## Format dateTime Column
df$dateTime <- as.POSIXct(dateTime)


# Start PNG device
png("plot3.png", width = 480, height = 480)

# Plot 3: Voltage
plot(df$dateTime, df$Voltage, type = "l", xlab = "daytime", ylab = "Voltage (volts)",xaxt = "n")

# Set x-axis labels to day names
axis(1, at = c(as.numeric(min(df$dateTime)), 
               as.numeric(min(df$dateTime)) + 86400, 
               as.numeric(min(df$dateTime)) + 2 * 86400),
     labels = c("Thu", "Fri", "Sat"))

# End PNG device
dev.off()