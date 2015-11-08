#
# plot3.R - david Sky - david.s.toronto@gmail.com
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

# In this graph we need to add a new column to the table to represent
# the date and time together - using the hint provided in the assignment:
#
# You may find it useful to convert the Date and Time variables to Date/Time classes in R using the 
# strptime() and as.Date() functions

# The data file represents the date as %d/%m/%Y and the time with seconds, as %H:%M:%S
powerData$DateAndTime <- strptime(paste(powerData$Date, powerData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")


# Step #2: Build our graph - a few steps required in this example:

# Set up the y-axis
with(powerData, plot(DateAndTime, SubMetering1, type = "n",
                xlab = NA, ylab = "Energy sub metering"))

# Plot the three lines
with(powerData, {
    lines(DateAndTime, SubMetering1, col = "black")
    lines(DateAndTime, SubMetering2, col = "red")
    lines(DateAndTime, SubMetering3, col = "blue")
})
# Add in the legend - I renamed the columns to the form SubMetertingX but I'll use the required strings 
# For some reason the legend was truncating the text by default, so as a work around I added spaces to
# one of strings. To-do: Investigate why this is happening.
legend("topright", 
       lty = c(1, 1, 1), # Line types - want them all solid
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3                             ")) # Even though I renamed these column names

# And finally, save it to disk as a PNG file
dev.copy(png, file = "plot3.png")
dev.off()
