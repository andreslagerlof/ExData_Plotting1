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


## --------- Create plot ---------------- ##

# Write to png
png("plot1.png")

# Plot 1
plot1 <- hist(pc_period$Global_active_power, col = "red", main = "Global Active Power", 
              xlab = "Global Active Power (kilowatts)",
              ylab = "Frequency")

dev.off()