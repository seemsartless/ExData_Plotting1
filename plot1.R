#
# plot1.R - david Sky - david.s.toronto@gmail.com
#
#    Exploratory Data Analysis course - Excercise 1
#
#    Read in the "Individual household electric power consumption Data Set" and create a
#    bar chart (histogram) for the dates between 2007-02-01 and 2007-02-02
#

# Step 1: Read in the subset of data
#   We only want the dates (dd/mm/yyyy in the file) 1/2/2007 - 2/2/2007 (looking at the data file
#   in an editor we can see these are lines 66638 through 69517, for a count of 2879 lines
powerData <- read.table(file = "./exdata-data-household_power_consumption/household_power_consumption.txt", 
                sep = ";",
                colClasses = c(rep("character", 2), rep("numeric", 7)),
                na.strings = "?", 
                skip = 66637, 
                nrows = 2879)

# Add back in column names
names(powerData) <- c("Date", "Time",
                "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity",
                "SubMetering1", "SubMetering2", "SubMetering3")

# Step #2: Plot the graph
hist(powerData$GlobalActivePower, 
     col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# And finally, save it to disk as a PNG file
dev.copy(png, file = "plot1.png")
dev.off()