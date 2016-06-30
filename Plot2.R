setwd("C:/Users/dan_9/Desktop/COURSERA + SELF STUDY/Exploratory Data Analysis by John Hopkins University/Project 1/Analysis")

source("DataReady.R")

Data = DataFiltered()

# Making Plot 2 
# using library(scales) for date_breaks()

Plot2 = ggplot(Data, aes(x = TimeComplete, y = Global_active_power))+
  geom_line()+
  scale_x_datetime(date_labels = "%a", breaks = date_breaks("1 day")) +
  theme(panel.background = element_rect(fill = "white")) +
  ylab("Global Active Power (kilowatts)") +
  xlab("")

png("Plot2.png", width=480, height=480)
Plot2
dev.off()