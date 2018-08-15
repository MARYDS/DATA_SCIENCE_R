
# Read the file into memory from the current working directory 
df <- read.table("household_power_consumption.txt", header=TRUE,sep=";",na.strings = "?")
# Convert time column to time
df$Time <- strptime(paste(df$Date, df$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
# Convert date column to date
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# Subset to get the dates required
dfp <- subset(df, (df$Date>=as.Date("2007/02/01", "%Y/%m/%d") & df$Date<=as.Date("2007/02/02", "%Y/%m/%d")))
# Free up memory
rm(df)

# Produce 4th Plot as a .png file
png("plot4.png", width=480, height=480)
par(mfrow=c(2,2), mar=c(4,4,4,1), oma=c(0,0,0,0))

# Top left
with(dfp, plot(Time, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
# Top right
with(dfp, plot(Time, Voltage, type="l", xlab="datetime", ylab="Voltage"))

# Bottom left
with(dfp, plot(Time, Sub_metering_1, type="l", col="slategray", xlab="", ylab="Energy sub metering"))
with(dfp, lines(Time, Sub_metering_2, col="red"))
with(dfp, lines(Time, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1), cex=0.5, bty="n", col=c("slategray","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Bottom right
with(dfp, plot(Time, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

dev.off()

# Free up memory
rm(dfp)