#----------------------------------------------------------
##  Plot 3
#----------------------------------------------------------

# Read the data
filePath <- "./data/household_power_consumption.txt"
datasetAll <- read.table(filePath, skip = 1, sep=";")
colNames <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
              "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
              "Sub_metering_3")
names(datasetAll) <- colNames

# Select only rows with Date == "2007-02-01" | "2007-02-02"
subDataset <- subset(datasetAll, datasetAll$Date == "1/2/2007" | datasetAll$Date == "2/2/2007")

# Cleaning format of columns we will be needing
# Converting to integer columns that have to be
subDataset$Global_active_power <- as.numeric(as.character(subDataset$Global_active_power))
subDataset$Global_reactive_power <- as.numeric(as.character(subDataset$Global_reactive_power))
subDataset$Voltage <- as.numeric(as.character(subDataset$Voltage))
subDataset$Sub_metering_1 <- as.numeric(as.character(subDataset$Sub_metering_1))
subDataset$Sub_metering_2 <- as.numeric(as.character(subDataset$Sub_metering_2))
subDataset$Sub_metering_3 <- as.numeric(as.character(subDataset$Sub_metering_3))
# Converting to date and time formats
subDataset$Date <- as.Date(subDataset$Date, format = "%d/%m/%Y")
subDataset$Time <- strptime(subDataset$Time, format = "%H:%M:%S")
subDataset[1:1440, "Time"] <- format(subDataset[1:1440, "Time"], "2007-02-01 %H:%M:%S")
subDataset[1441:2880, "Time"] <- format(subDataset[1441:2880, "Time"], "2007-02-02 %H:%M:%S")

# Making plot 3
with(subDataset, plot(Time, Sub_metering_1, type = "n", xlab = "", 
                      ylab = "Energy sub metering", main = "Energy sub-metering"))
with(subDataset, lines(Time, Sub_metering_1))
with(subDataset, lines(Time, Sub_metering_2, col = "red"))
with(subDataset, lines(Time, Sub_metering_3, col = "blue"))
# Adding legend
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


# Copying the graph to a png file in the working directory
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()




