# Laura Jernström
# 12/11/2020
# Data used is Student Performance Data received from 
# UCI Machine Learning Repository on 12/11/2020
# (at https://archive.ics.uci.edu/ml/datasets/Student+Performance).

library(dplyr)
library(ggplot2)



stu_mat <- read.csv("Z:/FDPE/Courses/Datamooc/IODS-project/data/student-mat.csv", sep = ";", header = TRUE)
stu_por <- read.csv("Z:/FDPE/Courses/Datamooc/IODS-project/data/student-por.csv", sep = ";", header = TRUE)

colnames(stu_mat)
colnames(stu_por)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

math_por <- inner_join(stu_mat, stu_por, by = join_by, suffix = c(".math", ".por")) 

colnames(math_por)
glimpse(math_por)

#alcvar <- c( "school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason")

alc <- select(math_por, one_of(join_by))

notjoined_columns <- colnames(stu_mat)[!colnames(stu_mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data
glimpse(alc)




# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use, fill = sex))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(alc, aes(high_use))

# draw a bar plot of high_use by sex
g2 + facet_wrap("sex") + geom_bar()

colnames(alc)

summary(alc$high_use)


getwd()
setwd("Z:/FDPE/Courses/Datamooc/IODS-project/data")

write.table(alc, file = "alc.txt", sep = "\t")


df <- read.table( "Z:/FDPE/Courses/Datamooc/IODS-project/data/alc.txt", sep = "\t", header = TRUE)

str(df)
head(df)



