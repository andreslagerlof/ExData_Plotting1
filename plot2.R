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
# Plot 2

# Write to png
png("plot2.png")

# Now I can make the plot
plot(pc_period$datetime, pc_period$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)") 


dev.off()