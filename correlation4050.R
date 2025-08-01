csv_folder <- file.path("Documents/sem4/4050/project4050kaggle/Combined_Flights_2019.csv")
print(csv_folder)

#.csv files
install.packages(c("tidyverse", "dplyr", "ggplot2", "readr", "data.table", "pryr"))
library(readr)

library(pryr)
mem_used()

library(data.table)


chunks <- fread("Documents/sem4/4050/project4050kaggle/Combined_Flights_2019.csv", data.table = TRUE)




# Compute the correlation matrix
#correlation_matrix <- cor(numeric_data)


#Correlation matrix for each of your variables
library(ggplot2)