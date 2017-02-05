# Sheridan Grant
# Electoral votes by race
# 12/24/2016

require(zoo)
require(xlsx)

data2k <- read.csv("2000.csv", na.strings="")
alloc <- read.csv("allocation.csv")
data2k <- na.locf(data2k)
data2k$state <- tolower(data2k$state)
alloc$State <- tolower(alloc$State)
data2k <- data2k[!data2k$voteTotal == "(B)",]
data2k <- data2k[data2k$state != "united states",]
data2k$voteTotal <- as.numeric(data2k$voteTotal)

data2k4 <- read.csv("2004.csv")
data2k4 <- data2k4[-seq(1, dim(data2k4)[1], dim(data2k4)[1]/52),]
st <- c("Total", state.name)
st <- c(st[1:9], "district of columbia", st[10:51])
data2k4$state <- rep(st, each = 12)
data2k4 <- data2k4[data2k4$state != "Total",]
data2k4 <- data2k4[, c(5, 1, 2, 3, 4)]
colnames(data2k4)[2] <- "demo"
data2k4 <- data2k4[!data2k4$voteTotal == "-",]
data2k4$state <- tolower(data2k4$state)
data2k4$voteTotal <- as.numeric(as.character(data2k4$voteTotal))

data2k$elec <- 0
data2k$votePerc <- 0
for (i in 1:dim(data2k)[1]) {
  data2k$votePerc[i] <- data2k$voteTotal[i] / data2k[data2k$state == data2k$state[i] & data2k$demo == 'Total', 3]
  data2k$elec[i] <- data2k$votePerc[i] * alloc$X1991[match(data2k$state[i], alloc$State)]
}
data2k$elecRate <- data2k$elec / data2k$voteTotal

for (demo in unique(data2k$demo)) {
  cat(demo, 'electoral votes per thousand people:', 
      sum(data2k[data2k$demo == demo,]$elec) / sum(data2k[data2k$demo == demo,]$voteTotal), "\n")
}

data2k4$elec <- 0
data2k4$votePerc <- 0
for (i in 1:dim(data2k4)[1]) {
  data2k4$votePerc[i] <- data2k4$voteTotal[i] / data2k4[data2k4$state == data2k4$state[i] & data2k4$demo == '.Total', 3]
  data2k4$elec[i] <- data2k4$votePerc[i] * alloc$X1991[match(data2k4$state[i], alloc$State)]
}
data2k4$elecRate <- data2k4$elec / data2k4$voteTotal

for (demo in unique(data2k4$demo)) {
  cat(demo, 'electoral votes per thousand people:', 
      sum(data2k4[data2k4$demo == demo,]$elec) / sum(data2k4[data2k4$demo == demo,]$voteTotal), "\n")
}