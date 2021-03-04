library(tidyverse)
library(lubridate)
##readin data
unzip("exdata_data_household_power_consumption.zip")
power <- read.csv2("household_power_consumption.txt", header = TRUE)
power <- as.tibble(power)

#filter for data from 2007-02-01 and 2007-02-02
power1 <- filter(power, Date=="1/2/2007"|Date=="2/2/2007")
##change data type from char to appropriate forms
power1[,3:9] <- sapply(power1[,3:9], as.numeric)
power1[,1] <- lapply(power1[,1], dmy)


