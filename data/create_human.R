# Laura Jernström

# Creating the data set "human" by combining data sets on human development and gender inequality.

library(dplyr)

# 1. and 2.

# read the human data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
# read gender inequality
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# 3.

# look at the (column) names
names(hd)
names(gii)

# look at the structures
str(hd)
str(gii)

# dimensions
dim(hd)
dim(gii)

# print out summaries of the variables
summary(hd)
summary(gii)


# 4. rename variables in hd

colnames(hd) = c("HDI.Rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", "GNI", "GNI.Minus.Rank")    
names(hd)

names(gii)
colnames(gii) = c("GII.Rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F", "Edu2.F", "Edu2.M", "LabF", "LabM")
names(gii)


# 5. Mutate and create two new variables:

# ratio of Female and Male populations with secondary education
#in each country. (i.e. edu2F / edu2M)
gii <- mutate(gii, edu2.FM = (Edu2.F / Edu2.M))

# ratio of labour force participation of females and males in 
# each country (i.e. labF / labM)
gii <- mutate(gii, labo.FM = (LabF / LabM))

names(gii)


# 6. Join human and gii as "human" by the variable Country

human <- inner_join(hd, gii, by = "Country") 

names(human)

dim(human)  # 195 obs. of 19 variables

getwd()
setwd("Z:/FDPE/Courses/Datamooc/IODS-project/data")

write.table(human, file = "human.txt", sep = "\t")



