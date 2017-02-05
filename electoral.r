# Sheridan Grant
# Electoral votes by race
# 12/24/2016

require(zoo)
require(xlsx)

setwd("C:/Users/Sheridan/Desktop/Code/Electoral")
data <- read.csv("2000.csv", na.strings="")
alloc <- read.csv("allocation.csv")
data <- na.locf(data)
data$state <- tolower(data$state)
alloc$State <- tolower(alloc$State)
data <- data[!data$voteTotal == "(B)",]
data <- data[data$state != "united states",]
data$voteTotal <- as.numeric(data$voteTotal)

data$elec <- 0
data$votePerc <- 0
for (i in 1:dim(data)[1]) {
  data$votePerc[i] <- data$voteTotal[i] / data[data$state == data$state[i] & data$demo == 'Total', 3]
  data$elec[i] <- data$votePerc[i] * alloc$X1991[match(data$state[i], alloc$State)]
}
data$elecRate <- data$elec / data$voteTotal

for (demo in unique(data$demo)) {
  cat(demo, 'electoral votes per thousand people:', 
      sum(data[data$demo == demo,]$elec) / sum(data[data$demo == demo,]$voteTotal), "\n")
}

2k4 <- read.xlsx("2004.xls", 2)