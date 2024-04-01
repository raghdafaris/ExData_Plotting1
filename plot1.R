
# Read the text file into R
data1 <- fread("C:/Users/F&R/Desktop/DS/DS4/household_power_consumption.txt")

# Convert the 'Date' column to Date format
data1$Date <- as.Date(data1$Date, format = "%d/%m/%Y")

# Subset to include only rows with dates "2007-02-01" and "2007-02-02"
subset_data <- data1[data1$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

# Convert character strings to POSIXct objects for time
subset_data$Time <- as.POSIXct(subset_data$Time, format = "%H:%M:%S")


# Convert subset_data to a data frame if it's a list
if (is.list(subset_data)) {
  subset_data <- as.data.frame(subset_data)
}
# Convert columns 3 and 6 to numeric
subset_data[, 3] <- as.numeric(subset_data[, 3])
subset_data[, 6] <- as.numeric(subset_data[, 6])

# Create histogram
hist(subset_data[, 3], 
     col = "red",
     xlab = "Global Active Power (Kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power")

# Save plot to PNG file with specified dimensions
png("plot1.png", width = 480, height = 480)
hist(subset_data[, 3], 
     col = "red",
     xlab = "Global Active Power (Kilowatts)",
     ylab = "Frequency",
     main = "Global Active Power")
dev.off()
