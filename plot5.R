# download, unzip and read file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data_file.zip", method="curl")
unzip("data_file.zip")
file1 <- readRDS("summarySCC_PM25.rds")

#Plot 5
file2 <- readRDS("Source_Classification_Code.rds")

#Subset by Baltimore, then look for vehicle sources, refine primary data
        Baltimore_subset <- subset(file1, fips == "24510")
        motor_data <- grepl("vehicle", file2$SCC.Level.Two, ignore.case=TRUE)
        motor_data_scc <- file2[motor_data,]$SCC
        subset_motor_data <- Baltimore_subset[Baltimore_subset$SCC %in% motor_data_scc,]
        plot5 <- with(subset_motor_data, aggregate(Emissions, by = list(year), sum))

png(filename="plot5.png", width=480, height=480)
        
        plot (plot5, type = "l", 
              main="PM2.5 Motor Source Emissions 1999 to 2008 - Baltimore",
              xlab = "Year", ylab = "Emissions PM 2.5",
              col="Red")

dev.off()