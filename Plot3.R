setwd("C:/Users/dan_9/Desktop/COURSERA + SELF STUDY/Exploratory Data Analysis by John Hopkins University/Project 1/Analysis")

source("DataReady.R")

Data = DataFiltered()


# Making Plot 3  
# using library(reshape2) for melt function

DataPlot3 = select(Data,TimeComplete, Sub_metering_1, Sub_metering_2, Sub_metering_3 ) 
DataPlot3 = melt(data = Data, measure.vars = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
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