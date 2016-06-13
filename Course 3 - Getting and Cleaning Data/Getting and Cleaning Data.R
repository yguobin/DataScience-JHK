setwd("Course 3 - Getting and Cleaning Data")

set.seed(13435)
X = data.frame("var1"=sample(1:5), "var2"=sample(6:10), "var3"=sample(11:15))
X = X[sample(1:5),]
X$var2[c(1, 3)] = NA
X

X[X$var2 > 8,]
X[which(X$var2 > 8),]

X[order(X$var2),]
X[order(X$var2, na.last=NA),]


library(plyr)
arrange(X, var2)
arrange(X, var2, na.last=NA)  # error, how to solve it?

restData = read.csv("Restaurants.csv")
restData$councilDistrict
quantile(restData$councilDistrict, na.rm=TRUE)
table(restData$councilDistrict)

quantile(restData$councilDistrict, probs=c(0.5, 0.75, 0.9))

table(restData$zipCode, useNA = "ifany")  # useNA: choice of "no", "ifany", "always")

table(restData$councilDistrict, restData$zipCode)

sum(is.na(restData$councilDistrict))
any(is.na(restData$councilDistrict))
all(restData$zipCode > 0) 
restData$zipCode[restData$zipCode <= 0]

colSums(is.na(restData))
colMeans(is.na(restData))
all(colSums(is.na(restData)) == 0)

table(restData$zipCode %in% c("21212","21213"))
restData[restData$zipCode %in% c("21212","21213"), ]

data("UCBAdmissions")
DF = as.data.frame(UCBAdmissions)
xtabs(Freq ~ Gender + Admit, data=DF)
table(DF$Admit, DF$Gender)    # pay attention to the diff betweee xtabs and table

ftable(DF[, c("Gender", "Admit", "Dept")])

fakeData = rnorm(1e5)
object.size(fakeData)
print(object.size(fakeData), units="Mb")

s1 = seq(1, 10, by=2)    # Python np.arange
s2 = seq(1, 10, length = 3)  # Python np.linspace

restData$zipCodeWrong = ifelse(restData$zipCode < 0, TRUE, FALSE)
# same as
restData$zipCodeWrong = restData$zipCode < 0
table(restData$zipCodeWrong, restData$zipCode < 0)

restData$zipGroups = cut(restData$zipCode, breaks = quantile(restData$zipCode))
table(restData$zipGroups)

library(Hmisc)
restData$zipGroups = cut2(restData$zipCode, g=4)
table(restData$zipGroups)

restData2 = mutate(restData, zipGroups = cut2(zipCode, g=4))
table(restData$zipGroups)

library(reshape2)
mtcars$carname = rownames(mtcars)
carMelt = melt(mtcars, id=c("carname", "gear", "cyl"), measures.vars=c("mpg", "hp"))
head(carMelt, n = 3)
tail(carMelt, n = 3)

nrow(unique(mtcars[, c("carname", "gear", "cyl")]))

tapply(InsectSprays$count, InsectSprays$spray, sum)
# another way
spIns = split(InsectSprays$count, InsectSprays$spray)  # generates a list
sprCount = lapply(spIns, sum)   # still a list
unlist(sprCount) # now a vector
sapply(spIns, sum)  # output: a vector

library("dplyr")
# six key functions in dplyr: select, filter, arrange, rename, mutate, summarize
head(select(mtcars, -(mpg:disp)))
# in base R, we have to
head(mtcars[, -(match("city", names(mtcars)):match("disp", names(mtcars)))])

mtcars.f = filter(mtcars, mpg > 20)
head(select(mtcars.f, 2:4, mpg), n=10)



# Week 3 quiz
hid = read.csv("getdata_data_ss06hid.csv")
agricultureLogical = (hid$ACR == 3 & hid$AGS == 6)
which(agricultureLogical)

library(jpeg)
jeff = readJPEG("getdata_jeff.jpg", native = TRUE)
quantile(jeff, probs=c(0.3, 0.8))

gdp = read.csv("getdata_data_GDP.csv", skip=5, header = FALSE, stringsAsFactors = FALSE)[, 1:2]
colnames(gdp) = c("country", "rank")
gdp$rank = as.integer(gdp$rank)
gdp = gdp[!is.na(gdp$rank), ]
edu = read.csv("getdata_data_EDSTATS_Country.csv", stringsAsFactors = FALSE)
gdp_edu = merge(gdp, edu, by.x = "country", by.y = "CountryCode")
nrow(gdp_edu)
gdp_edu[order(gdp_edu$rank, decreasing = TRUE), ][13, ]

rankGroups = cut2(gdp_edu$rank, g=5)
table(rankGroups, gdp_edu$Income.Group)

# Week 4
cameraData = read.csv("Baltimore_Fixed_Speed_Cameras.csv")
splitNames = strsplit(names(cameraData), "\\.")   # returns a list
splitNames[5]
sapply(splitNames, function(x) { x[1]})  # take first elments and return a vector

# another way
sub(".1", "", names(cameraData))
gsub(".1", "", names(cameraData))  # global sub

grep("Alameda", cameraData$intersection)    # returns indices
table(grepl("Alameda", cameraData$intersection))   # grepl return logical vector
grep("Alameda", cameraData$intersection, value = TRUE)  # returns values
cameraData[grepl("Alameda", cameraData$intersection), ]

nchar("Richard Yin")
substr("Richard Yin", 1, 7)
paste("Richard", "Yin")
paste0("Richard", "Yin")
library(stringr)
str_trim("Richard Yin   ")
gsub(" ", "_", "Richard Yin")

d1 = date()
class(d1)
d2 = Sys.Date()
class(d2)
format(d2, "%m-%d-%Y")

z = as.Date(c("01-01-1960", "01-02-1960", "03-31-1960", "07-30-1960"), "%m-%d-%Y")
z[1] - z[2]
as.numeric(z[1] - z[2])

weekdays(z)
months(z)

# Week 4 Quiz
hid = read.csv("getdata_data_ss06hid.csv")
strsplit(names(hid), "wgtp")[123]
gdp = read.csv("getdata_data_GDP.csv", skip=5, header = FALSE, stringsAsFactors = FALSE)[, c(1, 2, 5)]
names(gdp) = c("country", "rank", "gdp")
gdp$rank = as.integer(gdp$rank)   # how to surpress warning?
gdp = gdp[!is.na(gdp$rank), ]
gdp$gdp = as.numeric(gsub(",", "", gdp$gdp))
mean(gdp$gdp)

cnames = read.csv("getdata_data_GDP.csv", skip=5, header = FALSE, stringsAsFactors = FALSE)[, 4]
length(grep("^United", cnames))

yearEnd = grep("Fiscal year end:", gdp_edu$Special.Notes, value=TRUE)
yearEndMonth = gsub("^Fiscal year end: ", "", yearEnd)
yearEndMonth = gsub(" .*$", "", yearEndMonth)
sum(yearEndMonth == "June")

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

years = as.numeric(format(sampleTimes, "%Y"))
sum(years == 2012)

sample_2012 = sampleTimes[years == 2012]
sum(weekdays(sample_2012) == "Monday")

