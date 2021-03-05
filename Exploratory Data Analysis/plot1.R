
##making plot1
png(filename = "plot1.png",width = 480,height = 480)
hist(power1$Global_active_power, width = 12, col="red", xlab = "Global active power(kw)",
     main = "Global active power")
dev.off()