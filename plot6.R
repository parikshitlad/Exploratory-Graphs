# download, unzip and read file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data_file.zip", method="curl")
unzip("data_file.zip")
file1 <- readRDS("summarySCC_PM25.rds")


#Plot 6
file2 <- readRDS("Source_Classification_Code.rds")

#Subset LA and Baltimore data, look for vehicle sources
        LA_Baltimore_subset <- subset(file1, fips == "24510" | fips == "06037")
        motor_data <- grepl("vehicle", file2$SCC.Level.Two, ignore.case=TRUE)
        motor_data_scc <- file2[motor_data,]$SCC

#Refine primary data and aggregate by county and year
        subset_motor_data <- LA_Baltimore_subset[LA_Baltimore_subset$SCC %in% motor_data_scc,]
        plot6_BM_LA <- with(subset_motor_data, aggregate(Emissions, by = list(fips, year), sum))
        colnames(plot6_BM_LA) <- c("fips", "year", "emissions")

#Use log to find changes in emissions
library(plyr)
        plot6 <- ddply(plot6_BM_LA,"fips", transform,
                       Change=c(0,exp(diff(log(emissions)))-1))

#Add column to substitute fips by County Name to look nicely in plot
        plot6 <- transform(plot6, County = ifelse(fips == "24510", "Baltimore", "LA"))

png(filename="plot6.png", width=480, height=480)
        
        qplot(year, Change, data = plot6, 
              group = County,
              geom = c("point", "line"),
              color = County,
              ylab = "Emissions PM 2.5", 
              xlab = "Year",
              main = "Total Emissions Baltimore vs LA")

dev.off()
