
# Read the file into memory from the current working directory 
df <- read.table("household_power_consumption.txt", header=TRUE,sep=";",na.strings = "?")
# Convert date column to date
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# Subset to get the dates required
dfp <- subset(df, (df$Date>=as.Date("2007/02/01", "%Y/%m/%d") & df$Date<=as.Date("2007/02/02", "%Y/%m/%d")))
# Free up memory
rm(df)

# Produce 1st Plot as a .png file
png("plot1.png", width=480, height=480)
with(dfp, hist(Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)"))
dev.off()

# Free up memory
rm(dfp)

