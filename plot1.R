# download, unzip and read file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data_file.zip", method="curl")
unzip("data_file.zip")
file1 <- readRDS("summarySCC_PM25.rds")


#Plot 1
#Aggretate total emissions by year
        plot1 <- with (file1, aggregate(Emissions, by = list(year), sum))

png(filename="plot1.png", width=480, height=480)
        
        plot(plot1, type = "l", 
             main="PM2.5 Emissions from 1999 to 2008",
             xlab = "Year", ylab = "Emissions PM 2.5",
             col="Red")

dev.off()