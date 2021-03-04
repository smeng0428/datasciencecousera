library(tidyverse)
library(lubridate)
##readin data
unzip("exdata_data_household_power_consumption.zip")
power <- read.csv2("household_power_consumption.txt", header = TRUE)
power <- as.tibble(power)

##change data type from char to appropriate forms
power[,3:9] <- sapply(power[,3:9], as.numeric)
power[,1] <- lapply(power[,1], dmy)
power[,2] <- lapply(power[,2], hms)

## parsing year month and day from date
power <-power %>%
  mutate(Year = year(Date), Month = month(Date), Day = day(Date))

## calculate the daily average power consumption in Kw*h
daily_average <- power %>%
  select(Date, Global_active_power) %>%
  group_by  (Date) %>%
  summarize(Daily_enengy_consumption=sum(Global_active_power)/60) %>%
  arrange(Date)
## divided by 60 because 1h=60min and power was measured in 1 minute interval.

## plot the daily power consumption against time
ggplot(daily_average)+
  geom_line(aes(x=Date,y=Daily_enengy_consumption))+
  ggtitle("Daily Energy Consumption")
## from this plot we can see the energy consumption fluctuate periodically,
## next step is to see if there any dependency on seasons.
  monthly_average <- power %>%
  select(Date, Month, Global_active_power) %>%
  group_by  (Date, Month) %>%
  summarize(Daily_enengy_consumption=sum(Global_active_power)/60,Month) %>%
  arrange(Date)
  
    ggplot(monthly_average, aes(x=Date,y=Daily_enengy_consumption))+
    geom_point(aes(na.rm = TRUE, color = Month))
##now we can see the energy consumption is higher is winter and lower in summer.
##next we will exam each subsection individually
    kitchen <- power %>%
      select(Date, Month, Sub_metering_1) %>%
      filter(Sub_metering_1>0) %>%
      group_by(Date) %>%
      summarise(consumption=sum(Sub_metering_1)/1000, Month)##convert unit to kw*h
    
      ggplot(kitchen, aes(x=Date,y=consumption))+
      geom_line(aes(color = Month))+
      ggtitle("Kitchen consumption")
      
    laundry <- power %>%
        select(Date, Month, Sub_metering_2) %>%
        filter(Sub_metering_2>0) %>%
        group_by(Date) %>%
        summarise(consumption=sum(Sub_metering_2)/1000, Month)##convert unit to kw*h
      
    ggplot(laundry, aes(x=Date,y=consumption))+
        geom_line(aes(color = Month))+
      ggtitle("Laundry consumption")
    
    conditioning <- power %>%
      select(Date, Month, Sub_metering_3) %>%
      filter(Sub_metering_3>0) %>%
      group_by(Date) %>%
      summarise(consumption=sum(Sub_metering_3)/1000, Month)##convert unit to kw*h
    
    ggplot(conditioning, aes(x=Date,y=consumption))+
      geom_line(aes(color = Month))+
      ggtitle("water-heater/air-conditioner consumption")
  ## kitchen and laundry energy consumption does not have a strong correlation with season. But Water heater and air conditioner energy consumption
  ## varies.  
    