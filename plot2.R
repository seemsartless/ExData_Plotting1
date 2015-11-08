#
# plot2.R - david Sky - david.s.toronto@gmail.com
#
#    Exploratory Data Analysis course - Excercise 1
#
#    Read in the "Individual household electric power consumption Data Set" and create a
#    graph for the dates between 2007-02-01 and 2007-02-02
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

# Add back in the column names
names(powerData) <- c("Date", "Time",
                "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity",
                "SubMetering1", "SubMetering2", "SubMetering3")

# In the second graph we need to add a new column to the table to represent
# the date and time together - using the hint provided in the assignment:
#
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the 
# strptime() and as.Date() functions

# The data file represents the date as %d/%m/%Y and the time with seconds, as %H:%M:%S
powerData$DateAndTime <- strptime(paste(powerData$Date, powerData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")


# Step #2: Plot the graph
plot(powerData$DateAndTime, powerData$GlobalActivePower, type = "l",
     xlab = NA, ylab = "Global Active Power (kilowatts)")

# And finally, save it to disk as a PNG file
dev.copy(png, file = "plot2.png")
dev.off()
