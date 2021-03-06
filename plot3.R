URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

### Download data
if (file.exists("./household_power_consumption.zip") || file.exists("./household_power_consumption.txt")) {
  message("Data file (zip or txt format) already exists\r")
  
} else {
  
  message("Downloading data file\r")
  download.file(url=URL,destfile="./household_power_consumption.zip")
  
}

### Extract data
if (file.exists("./household_power_consumption.txt")) {
  message("Data file (txt format) exists\r")
} else {
  message("Extracting data ... \r")
  unzip(zipfile="./household_power_consumption.zip",exdir=".",)  
}
### Read data
epc <- read.table("household_power_consumption.txt",header=TRUE,sep=";",stringsAsFactors=FALSE)
sub <- epc[epc$Date == "1/2/2007" | epc$Date == "2/2/2007",]
sub$Global_active_power <- as.numeric(sub$Global_active_power)
sub$datetime <- paste(sub$Date,sub$Time)
sub$datetime <- strptime(sub$datetime,"%d/%m/%Y %H:%M:%S")
sub$Sub_metering_1 <- as.numeric(sub$Sub_metering_1)
sub$Sub_metering_2 <- as.numeric(sub$Sub_metering_2)
sub$Sub_metering_3 <- as.numeric(sub$Sub_metering_3)
png("plot3.png",width=480,height=480)
with(sub,plot(y=Sub_metering_1,x=datetime,type="n",ylab="Energy sub metering",xlab=""))
with(sub,lines(y=Sub_metering_1,x=datetime,type="l",col="black"))
with(sub,lines(y=Sub_metering_2,x=datetime,type="l",col="red"))
with(sub,lines(y=Sub_metering_3,x=datetime,type="l",col="blue"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),text.col="black",lty="solid",col=c("black","red","blue"))
dev.off()


