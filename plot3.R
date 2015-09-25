# download, unzip and read file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data_file.zip", method="curl")
unzip("data_file.zip")
file1 <- readRDS("summarySCC_PM25.rds")

#Plot 3
#Subset by Baltimore, aggregate, and then change column names
        Baltimore_subset <- subset(file1, fips == "24510")
        plot3 <- with (Baltimore_subset, aggregate(Emissions, by = list(type,year), sum))
        colnames(plot3) <- c("Type", "year", "emissions")

png(filename="plot3.png", width=480, height=480)
        
        qplot(year, emissions, data = plot3, 
              group = Type,
              geom = c("point", "line"),
              color = Type,
              ylab = "Emissions PM 2.5", xlab = "Year",
              main = "Total Emissions from 1999 to 2008 - Baltimore")
        
dev.off()