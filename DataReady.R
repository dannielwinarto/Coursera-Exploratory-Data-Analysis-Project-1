DataFiltered = function(){

setwd("C:/Users/dan_9/Desktop/COURSERA + SELF STUDY/Exploratory Data Analysis by John Hopkins University/Project 1")

library(dplyr)
library(lubridate)
library(ggplot2)
library(stringr)
library(scales) # for datebreaks() function
library(reshape2) # for melt() purpose
library(Rmisc) # for combining multiple ggplot multiplot()

data = read.csv("household_power_consumption.txt", sep = ";")

setwd("C:/Users/dan_9/Desktop/COURSERA + SELF STUDY/Exploratory Data Analysis by John Hopkins University/Project 1/Analysis")

datawork = data
glimpse(datawork)

# converting into character format
for(i in 1: ncol(datawork)){
  datawork[,i] = as.character(datawork[,i])
}

# changing ? into NA
for (i in 1: ncol(datawork)) {
  datawork[,i] = gsub("\\?", NA, datawork[,i])
}

# counting how many NAs
NAcol = NULL
for (i in 1: ncol(datawork)){
  NAcol[i] = sum(is.na(datawork[,i]))
} 

# converting col Date into time format
datawork$Date  = dmy(datawork$Date)
# converting col Global_active_power into Numeric
datawork$Global_active_power  = as.numeric(datawork$Global_active_power)

# We will only be using data frothe dates 2007-02-01 and 2007-02-02
DataFiltered = filter(datawork, Date >=  "2007-01-31" & Date <= "2007-02-02")
glimpse(DataFiltered)

# Adding TimeComplete column using lubridate
DataFiltered = DataFiltered %>% 
  mutate(Date, TimeComplete = paste(DataFiltered$Date ,DataFiltered$Time, sep = " " )) 
DataFiltered$TimeComplete  = ymd_hms(DataFiltered$TimeComplete)

# converting sub_metering 1,2,3 into numeric
for (i in 7:9) {
  DataFiltered[,i] = as.numeric(DataFiltered[,i])
}

# converting Global_reactive_power ,  Voltage into numeric
DataFiltered$Global_reactive_power = as.numeric(DataFiltered$Global_reactive_power)
DataFiltered$Voltage = as.numeric(DataFiltered$Voltage)

return(DataFiltered)
}

