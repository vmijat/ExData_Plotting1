library(dplyr)
library(lubridate)
library(tidyr)

#create file URL
data_URL = "./data/"
household_file <- paste0(data_URL, "household_power_consumption.txt")

#read file into data frame
households <- read.csv(household_file, sep = ";")

households_df <-  as.data.frame(households, stringsAsFactors = FALSE)


#filter out 1st and 1nd of February
first_and_second <- households_df %>%
        filter(Date =="1/2/2007" | Date == "2/2/2007")

first_and_second$Global_active_power <- as.numeric(first_and_second$Global_active_power, na.rm = TRUE)
first_and_second$Date <- as.POSIXct(first_and_second$Date, format = "%d/%m/%Y")


first_and_second <- first_and_second %>%
        mutate(DateTime = paste(Date, Time))

first_and_second$DateTime <- as.POSIXct(first_and_second$DateTime)



     
#Print three different categories
png("plot3.png", height = 480, width = 480)

plot(first_and_second$DateTime, first_and_second$Sub_metering_1, lwd = 1, col = "black",
     xlab = "", ylab = "Energy sub metering")
lines(first_and_second$DateTime, first_and_second$Sub_metering_2, lwd = 1, col = "red")
lines(first_and_second$DateTime, first_and_second$Sub_metering_3, lwd = 1, col = "blue")

legend("topright", col = c("black", "red", "blue"), border = "black",
       lty = 1, lwd = 2,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()


