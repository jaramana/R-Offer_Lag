# Offer Lag - R
# 01/16/2019

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