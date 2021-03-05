##make plot 2
library(tidyverse)
library(lubridate)
power1 <- mutate(power1, longtime= dmy_hms(paste(power1[[1]],power1[[2]])))
png(filename = "plot2.png", width = 480, height = 480)
plot(power1$longtime,power1$Global_active_power, xlab = "", ylab = "Global Active Power(Kw)",type = 'l')
dev.off()
