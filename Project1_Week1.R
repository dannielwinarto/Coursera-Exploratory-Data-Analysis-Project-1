setwd("C:/Users/dan_9/Desktop/COURSERA + SELF STUDY/Exploratory Data Analysis by John Hopkins University/Project 1")

library(dplyr)
library(lubridate)
library(ggplot2)
library(stringr)
library(scales) # for datebreaks() function
library(reshape2) # for melt() purpose
library(Rmisc) # for combining multiple ggplot multiplot()

data = read.csv("household_power_consumption.txt", sep = ";")
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

# Making Plot 1
Plot1 = ggplot(DataFiltered, aes(x = Global_active_power)) +
  geom_histogram(binwidth =.5,color = "black", fill  = "red") +
  scale_x_continuous( limits = c(0,6))+
  ggtitle("Global Active Power")+
  xlab("Global Active Power (kilowatts)") +
  ylab("Frequency") +
  theme(panel.background = element_rect(fill = "white"))

png("Plot1.png", width=480, height=480)
Plot1
dev.off()

# Making Plot 2 
# using library(scales) for date_breaks()
Plot2 = ggplot(DataFiltered, aes(x = TimeComplete, y = Global_active_power))+
  geom_line()+
  scale_x_datetime(date_labels = "%a", breaks = date_breaks("1 day")) +
  theme(panel.background = element_rect(fill = "white")) +
  ylab("Global Active Power (kilowatts)") +
  xlab("")

png("Plot2.png", width=480, height=480)
Plot2
dev.off()

# Making Plot 3  
# using library(reshape2) for melt function

DataPlot3 = select(DataFiltered,TimeComplete, Sub_metering_1, Sub_metering_2, Sub_metering_3 ) 
DataPlot3 = melt(data = DataPlot3, measure.vars = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
glimpse(DataPlot3)
table(DataPlot3$DataPlot3)

Plot3 = ggplot(DataPlot3, aes(x = TimeComplete , y = value,  group = variable, color=variable))+
  geom_line()+
  scale_x_datetime(date_labels = "%a", breaks = date_breaks("1 day")) +
  theme(panel.background = element_rect(fill = "white")) +
  ylab("Global Active Power (kilowatts)") +
  xlab("") +
  theme(legend.position = c(.85,.85), legend.title=element_blank())

png("Plot3.png", width=480, height=480)
Plot3
dev.off()  

# Making Plot 4  

PlotA = ggplot(DataFiltered, aes(x = TimeComplete, y = Voltage))+
  geom_line()+
  scale_x_datetime(date_labels = "%a", breaks = date_breaks("1 day")) +
  scale_y_continuous(breaks = seq(from = 234, to = 246, by = 4))+
  theme(panel.background = element_rect(fill = "white")) +
  ylab("Global Active Power (kilowatts)") +
  xlab("Datetime")

PlotB = ggplot(DataFiltered, aes(x = TimeComplete, y = Global_reactive_power))+
  geom_line()+
  scale_x_datetime(date_labels = "%a", breaks = date_breaks("1 day")) +
  theme(panel.background = element_rect(fill = "white")) +
  ylab("Global Active Power (kilowatts)") +
  xlab("Datetime")

png("Plot4.png", width=480, height=480)
Plot4 = multiplot(Plot2, Plot3, PlotA, PlotB, cols=2)
dev.off()  

Plot4 = multiplot(Plot2, Plot3, PlotA, PlotB, cols=2)





