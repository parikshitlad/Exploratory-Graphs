# download, unzip and read file

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, "data_file.zip", method="curl")
unzip("data_file.zip")
file1 <- readRDS("summarySCC_PM25.rds")

#Plot 4
file2 <- readRDS("Source_Classification_Code.rds")

#Subset by words comb and coal, and then take union 
        comb_data <- grepl("comb", file2$Short.Name, ignore.case=TRUE)
        coal_data <- grepl("coal", file2$Short.Name, ignore.case=TRUE)
        coal_comb <- (comb_data & coal_data)

#Refine final data to comb and coal, and aggregate
        coal_comb_scc <- file2[coal_comb,]$SCC
        subset_coal_comb <- file1[file1$SCC %in% coal_comb_scc,]
        plot4 <- with(subset_coal_comb, aggregate(Emissions, by = list(year), sum))

png(filename="plot4.png", width=480, height=480)

        plot (plot4, type = "l", 
              main="PM2.5 Coal Combustion Emissions from 1999 to 2008",
              xlab = "Year", ylab = "Emissions PM 2.5",
              col="Red")

dev.off()