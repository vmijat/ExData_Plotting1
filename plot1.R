library(dplyr)
library(lubridate)
library(tidyr)

#create file URL
data_URL = "./data/"
household_file <- paste0(data_URL, "household_power_consumption.txt")

#read file into data frame
households <- read.csv(household_file, sep = ";")

households_df <-  as.data.frame(households, stringsAsFactors = FALSE)


#filter out 1st and 2nd of February
first_and_second <- households_df %>%
        filter(Date =="1/2/2007" | Date == "2/2/2007")

first_and_second$Global_active_power <- as.numeric(first_and_second$Global_active_power, na.rm = TRUE)
first_and_second$Date <- as.POSIXct(first_and_second$Date, format = "%d/%m/%Y")


first_and_second <- first_and_second %>%
        mutate(DateTime = paste(Date, Time))

first_and_second$DateTime <- as.POSIXct(first_and_second$DateTime)



#create histogram
png("plot1.png", width=480, height=480)
hist(first_and_second$Global_active_power, 
     col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
