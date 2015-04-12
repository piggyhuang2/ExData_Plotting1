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
png("plot2.png",width=480,height=480)
with(sub,plot(y=Global_active_power,x=datetime,type="n"))
with(sub,lines(y=Global_active_power,x=datetime,type="l",xlab="",ylab="Global Active Power(kilowatts"))
dev.off()


