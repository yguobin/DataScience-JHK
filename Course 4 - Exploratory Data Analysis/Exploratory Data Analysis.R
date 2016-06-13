# Week 1
# Principles of Analytic Graphics
# 1. Show comparisons
# 2. Show causality, mechanism, explanation, systematic structure
# 3. Show multivariate data
# 4. Integration of evidence
# 5. Describe the evidence with labels, scales, sources, etc.
# 6. Content is king

# U.S. National Ambient Air Quality Standards
# https://www.epa.gov/criteria-air-pollutants/naaqs-table

setwd("Course 4 - Exploratory Data Analysis")

pollution = read.csv("avgpm25.csv", colClasses = c("numeric", "character", "factor", "numeric", "numeric"))

boxplot(pollution$pm25, col="blue")
abline(h = 12)

hist(pollution$pm25, col="green")
rug(pollution$pm25)
abline(v = 12, lwd = 2)
abline(v = median(pollution$pm25), col = "magenta", lwd = 4)

hist(pollution$pm25, col="green", breaks=100)  # in PyPlot, it's bins = 100

barplot(table(pollution$region), col="wheat", main = "Numbers of Counties in Each Region")

boxplot(pm25 ~ region, data = pollution, col = "red")

par(mfrow = c(2,1), mar = c(4, 4, 2, 1))
hist(subset(pollution, region == "east")$pm25, col = "green")
hist(subset(pollution, region == "west")$pm25, col = "green")

