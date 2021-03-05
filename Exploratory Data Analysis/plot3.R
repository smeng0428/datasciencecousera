##make plot3

png(filename = "plot3.png", width = 480, height = 480)
with(power1, plot(longtime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", 
                  type = "l"))
with(power1,lines(longtime, Sub_metering_2, col="red"))
with(power1,lines(longtime, Sub_metering_3, col="blue"))
legend("topright", col=c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=0.2, bty = "0")
dev.off()