#
# plot4.R - david Sky - david.s.toronto@gmail.com
#
#    Exploratory Data Analysis course - Excercise 1
#
#    Read in the "Individual household electric power consumption Data Set" and create a
#    series of graphs for the dates between 2007-02-01 and 2007-02-02
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


# Step #2: Build our set of graphs

# Want a 2x2 grid of graphs 
par(mfrow = c(2,2))

# Now draw the four required graphs - will simplify this
# using the with(powerData, {}) function and draw the 4 graphs within that call

with(powerData, {
    
    # Graph 1 - top left
    plot(DateAndTime, GlobalActivePower, type = "l",
         xlab = NA, ylab = "Global Active Power (kilowatts)")
    
    # Graph 2- top right
    plot(DateAndTime, Voltage, type = "l", xlab = "datetime")
    
    # Graph 3 - bottom left, our graph from Plot3.R - with no box around the legend
    plot(DateAndTime, SubMetering1, type = "n", xlab = NA, ylab = "Energy sub metering")
    lines(DateAndTime, SubMetering1, col = "black")
    lines(DateAndTime, SubMetering2, col = "red")
    lines(DateAndTime, SubMetering3, col = "blue")
    legend("topright", lty = c(1, 1, 1), col = c("black", "red", "blue"), bty="n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3                    "))
    
    # Graph 4 - bottom right
    plot(DateAndTime, GlobalReactivePower, type = "l",
         ylab = "Global_reactive_power", xlab = "datetime")    
     
}) # End of the with     
     
# And finally, save it to disk as a PNG file
dev.copy(png, file = "plot4.png")
dev.off()
