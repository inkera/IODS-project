# 1

# Laura Jernström
# 11/05/2020
# Exercise 2


rm(list=ls())
#install.packages("dplyr")
library(dplyr)
getwd()


# 2

lrn14 <- read.table("Z:/FDPE/Courses/Datamooc/IODS-project/data/lrn2014.txt", sep = "\t", header = TRUE)

dim(lrn14)
str(lrn14)
summary(lrn14)

# Comments: The dtata consist of 60 variables on 182 observations (dimensions). All of the variables are integers
# and they are not named (structure).

colnames(lrn14) = c("Aa", "Ab", "Ac", "Ad", "Ae", "Af", "ST01", "SU02", "D03", "ST04", "SU05", "D06", "D07", "SU08", "ST09", "SU10", "D11", "ST12", "SU13", "D14", "D15", "SU16", "ST17", "SU18", "D19", "ST20", "SU21", "D22", "D23", "SU24", "ST25", "SU26", "D27", "ST28", "SU29", "D30", "D31", "SU32", "Ca", "Cb", "Cc", "Cd", "Ce", "Cf", "Cg", "Ch", "Da", "Db", "Dc", "Dd", "De", "Df", "Dg", "Dh", "Di", "Dj", "Age", "Attitude",	"Points", "gender")

#attach(data)
#summary(data)


# 3

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)


# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)


# choose a handful of columns to keep
keep_columns <- c("gender","Age", "Attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# see the stucture of the new dataset
str(learning2014)

# print out the column names of the data
colnames(learning2014)

# change the name of the second column
colnames(learning2014)[2] <- "age"

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points"

# change the name of the second column
colnames(learning2014)[3] <- "attitude"

# print out the new column names of the data
colnames(learning2014)


# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)



## 4 Set working directory as the IODS-project

getwd()
setwd("Z:/FDPE/Courses/Datamooc/IODS-project/data")

write.table(learning2014, file = "learning2014.txt", sep = "\t")

df <- read.table( "Z:/FDPE/Courses/Datamooc/IODS-project/data/learning2014.txt", sep = "\t", header = TRUE)

str(df)
head(df)




