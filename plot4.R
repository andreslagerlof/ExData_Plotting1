# Load libraries
library(tidyverse)
library(lubridate)

## ------------ Prepatations ------------- ##

# Read data
library(readr)
pc <- read_delim("data/household_power_consumption.txt", 
                 ";", escape_double = FALSE, col_types = cols(Date = col_date(format = "%d/%m/%Y")), 
                 na = "NA", trim_ws = TRUE)
View(pc)

summary(pc)

# Filter data to only include dates from the dates 2007-02-01 and 2007-02-02
pc_period <- pc %>% filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

pc_period <- pc_period %>% mutate(weekday = wday(Date, label = TRUE))

# For this plot I need a variable in datetime format that is ymd_hms format
# to do this I use the lubridate package and this code
pc_period <- pc_period %>% 
  mutate(datetime = ymd_hms(paste(Date, Time))) 

# Next I have to change the language from my default (Swedish) to Enlish
Sys.setlocale("LC_ALL","English")

## --------- Create plot ---------------- ##

# Plot 4
# two of the plots already exists (see Plot 2 and Plot 3) but the other two 
# has to be created
plot(pc_period$datetime, pc_period$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

plot(pc_period$datetime, pc_period$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

# Write to png
png("plot4.png")

# Create the plot grid
par(mfrow = c(2,2))

# The first plot (row 1, column 1)
plot(pc_period$datetime, pc_period$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

# The second plot (row 1, column 2)
plot(pc_period$datetime, pc_period$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

# The 3rd plot (row 2, column 1)
plot(pc_period$datetime, pc_period$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy Sub Metering")

# Add the other lines
lines(pc_period$datetime, pc_period$Sub_metering_2, type = "l", col = "red",)
lines(pc_period$datetime, pc_period$Sub_metering_3, type = "l", col = "blue")

# Add legend
legend("top", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       inset = 0, col = c("black", "red", "blue"), lty = 7, bty = "n") 

# The 4th plot (column 2, row 2)
plot(pc_period$datetime, pc_period$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

dev.off()