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
# Plot 3
# Write to png
png("plot3.png")

# Create plot
plot(pc_period$datetime, pc_period$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy Sub Metering")

# Add the other lines
lines(pc_period$datetime, pc_period$Sub_metering_2, type = "l", col = "red",)
lines(pc_period$datetime, pc_period$Sub_metering_3, type = "l", col = "blue")

# Add legend
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 7)


dev.off()