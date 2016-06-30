setwd("C:/Users/dan_9/Desktop/COURSERA + SELF STUDY/Exploratory Data Analysis by John Hopkins University/Project 1/Analysis")

source("DataReady.R")

Data = DataFiltered()


# Making Plot 1
Plot1 = ggplot(Data, aes(x = Global_active_power)) +
  geom_histogram(binwidth =.5,color = "black", fill  = "red") +
  scale_x_continuous( limits = c(0,6))+
  ggtitle("Global Active Power")+
  xlab("Global Active Power (kilowatts)") +
  ylab("Frequency") +
  theme(panel.background = element_rect(fill = "white"))

png("Plot1.png", width=480, height=480)
Plot1
dev.off()



