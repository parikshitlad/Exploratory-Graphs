# download, unzip and read file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data_file.zip", method="curl")
unzip("data_file.zip")
file1 <- readRDS("summarySCC_PM25.rds")

#Plot 2
# Subset by Baltimore and then aggregate data
        Baltimore_subset <- subset(file1, fips == "24510")
        plot2 <- with (Baltimore_subset, aggregate(Emissions, by = list(year), sum))

png(filename="plot2.png", width=480, height=480)

        plot(plot2, type = "l",
             main="PM2.5 Emissions from 1999 to 2008 - Baltimore",
             xlab = "Year", ylab = "Emissions PM 2.5",
             col="Red")

dev.off()