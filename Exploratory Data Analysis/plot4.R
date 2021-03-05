##make plot4

png(filename = "plot4.png", width =480, height = 480)
par(mfrow=c(2,2))
plot(power1$longtime,power1$Global_active_power, xlab = "", ylab = "Global Active Power(Kw)",type = 'l')
plot(power1$longtime,power1$Voltage, xlab = "datetime", ylab = "Voltage",type = 'l')
with(power1, plot(longtime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", 
                  type = "l"))
with(power1,lines(longtime, Sub_metering_2, col="red"))
with(power1,lines(longtime, Sub_metering_3, col="blue"))
legend("topright", col=c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=0.2, bty = "0")
plot(power1$longtime, power1$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.off()