
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

# Produce 3rd Plot as a .png file
png("plot3.png", width=480, height=480)
with(dfp, plot(Time, Sub_metering_1, type="l", col="slategray", xlab="", ylab="Energy sub metering"))
with(dfp, lines(Time, Sub_metering_2, col="red"))
with(dfp, lines(Time, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1), col=c("slategray","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()

# Free up memory
rm(dfp)