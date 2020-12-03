# Laura Jernström
# 02/12/2020

# Data Sources: 
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt
# https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt

rm(list=ls())


## 1.

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", 
                   sep ="" , header = TRUE)

rats <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt",
                   sep ="", header = TRUE)

names(BPRS)
summary(BPRS)
str(BPRS)

names(rats)
summary(rats)
str(rats)

# Looking at the structures of the data sets, we see that in the BPRS data set, 
# there are 40 observations of 11 variables. In the rats data, there are 16
# observations of 13 variables.

# Point of the wide form data is to have one row for each observation. In the wide form,
# it is typical to have a variable corresponding to each time point and if there are 
# lot of variables of interest/background, the number of variables gets quite large quite quick,
# for example could have earnings1990, earnings1991 as separate variables. In the long form,
# each observation and time point are on separate rows such that number of variables is smaller
# e.g. one earnings variable, but number of observations(rows) is larger.


## 2. Categorical variables as factors
BPRS$treatment <- as.factor(BPRS$treatment)
BPRS$subject <- as.factor(BPRS$subject)
rats$ID <- as.factor(rats$ID)
rats$Group <- as.factor(rats$Group)

## 3. Convert the data set to long form. Create variable week and WD/Time.

library(tidyr)
library(dplyr)


# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
rats <-  rats %>% gather(key = Time, value = rats, -ID, -Group)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))
ratsl <-  rats %>% mutate(Time = as.integer(substr(Time,3,4)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)
glimpse(ratsl)


## 4. Looking at the datasets

names(BPRSL)
summary(BPRSL)
str(BPRSL)

names(ratsl)
summary(ratsl)
str(ratsl)

# Everything seams to be in order. The data set BPRSL has 360 observation of 5 variables
# and the ratsl data set has 176 observations of 4 variables. 

# Now in each data set, instead of having one row for each observation, there
# one row for each observation and time point. In the BPRSL data set, there are new variables "weeks" and "bprs",
# with the number of the week extracted as the value of weeks-variable, and the value of bprs for the brps-
# variable. With the ratsl data set, there are similarly new variables Time and rats with the same logic.

getwd()
setwd("Z:/FDPE/Courses/Datamooc/IODS-project/data")

write.table(BPRSL, file = "BPRSL.txt", sep = " ")
write.table(ratsl, file = "ratsl.txt", sep = " ")


