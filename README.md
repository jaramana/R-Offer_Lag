## R Pivot Table
This script calculates the lag in time that occurs when a trip is offered until it is accepted and booked.

## Motivation
We had to identify the lag that occurs when a trip is offered until it is accepted and booked to see how a lack of acceptance may affect the wait time of a trip.

## Code
```
# Load Packages
library(reshape2)
library(dplyr)
library(data.table)
library(lubridate)

# Set working directory
setwd("PATH/TO/DIRECTORY")

# Read .csv
data <- read.csv("Offer_Report.csv")

# DateTime in Date format
data$DateTime <- as.POSIXct(data$DateTime, format="%m/%d/%Y %H:%M")

# Summartize (Pivot)
data_summary <- data %>%
  group_by(Request) %>%
  summarise(Time_Min=min(DateTime),
            Time_Max=max(DateTime))

# Time difference in minutes
data_summary$Lag_Minutes <- difftime(data_summary$Time_Max,data_summary$Time_Min,units='mins')

# Write CSV
write.csv(data_summary, "Offer_Lags.csv", row.names = FALSE)
```