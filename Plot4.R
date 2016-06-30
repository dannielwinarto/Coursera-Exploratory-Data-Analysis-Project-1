setwd("C:/Users/dan_9/Desktop/COURSERA + SELF STUDY/Exploratory Data Analysis by John Hopkins University/Project 1")

source("DataReady.R")

Data = DataFiltered()

# Making Plot 4  

Plot2 = ggplot(Data, aes(x = TimeComplete, y = Global_active_power))+
  geom_line()+
  scale_x_datetime(date_labels = "%a", breaks = date_breaks("1 day")) +
  theme(panel.background = element_rect(fill = "white")) +
  ylab("Global Active Power (kilowatts)") +
  xlab("")

DataPlot3 = select(Data,TimeComplete, Sub_metering_1, Sub_metering_2, Sub_metering_3 ) 
DataPlot3 = melt(data = Data, measure.vars = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

Plot3 = ggplot(DataPlot3, aes(x = TimeComplete , y = value,  group = variable, color=variable))+
  geom_line()+
  scale_x_datetime(date_labels = "%a", breaks = date_breaks("1 day")) +
  theme(panel.background = element_rect(fill = "white")) +
  ylab("Global Active Power (kilowatts)") +
  xlab("") +
  theme(legend.position = c(.85,.85), legend.title=element_blank())

PlotA = ggplot(Data, aes(x = TimeComplete, y = Voltage))+
  geom_line()+
  scale_x_datetime(date_labels = "%a", breaks = date_breaks("1 day")) +
  scale_y_continuous(breaks = seq(from = 234, to = 246, by = 4))+
  theme(panel.background = element_rect(fill = "white")) +
  ylab("Global Active Power (kilowatts)") +
  xlab("Datetime")

PlotB = ggplot(Data, aes(x = TimeComplete, y = Global_reactive_power))+
  geom_line()+
  scale_x_datetime(date_labels = "%a", breaks = date_breaks("1 day")) +
  theme(panel.background = element_rect(fill = "white")) +
  ylab("Global Active Power (kilowatts)") +
  xlab("Datetime")

png("Plot4.png", width=480, height=480)
Plot4 = multiplot(Plot2, Plot3, PlotA, PlotB, cols=2)
dev.off()  

Plot4 = multiplot(Plot2, Plot3, PlotA, PlotB, cols=2)
