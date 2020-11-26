rm(list=ls())

# Laura Jernström
# 26/11/2020
# The 'human' dataset originates from the United Nations Development Programme. 
# See their data page at
# http://hdr.undp.org/en/content/human-development-index-hdi 
# for more information. 
# Technical note on the human development indeces at:
# http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

# dplyr::select()





human <- read.table( "Z:/FDPE/Courses/Datamooc/IODS-project/data/human.txt", 
                     sep = "\t", header = TRUE)

str(human)
dim(human)  # 195 obs. of 19 variables
names(human)
summary(human)

# The data set contains information by country on human development measures
# on 195 observations of 19 variables.

# Variables include HDI, life expectancy, education, GNI, GII, maternal 
# mortality, adolescent birth, parliamentary and labour market attachment.

# 1.

library(stringr)
library(dplyr)
# look at the structure of the GNI column in 'human'
str(human$GNI)

# remove the commas from GNI and print out a numeric version of it
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()


# 2. 

keep <- c("Country", "edu2.FM", "labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))


# 3. 

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_ <- filter(human, complete.cases(human))



# 4. Remove regions

# look at the last 10 observations
tail(human, 10)

# last indice we want to keep
last <- nrow(human) - 7

# choose everything until the last 7 observations
human_ <- human[1:last, ]

# 5.

# add countries as rownames
rownames(human) <- human$Country

# remove the Country variable
human_ <- dplyr::select(human, -Country)



getwd()
setwd("Z:/FDPE/Courses/Datamooc/IODS-project/data")

write.table(human_, file = "human.txt", sep = "\t")



human <- read.table( "Z:/FDPE/Courses/Datamooc/IODS-project/data/human.txt", 
                     sep = "\t", header = TRUE)
