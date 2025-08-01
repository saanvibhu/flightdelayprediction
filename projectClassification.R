#analyzing relationship between Y and X variables (Part A)

csv_folder <- file.path("Documents/sem4/4050/project4050kaggle/Combined_Flights_2019.csv")
print(csv_folder)

#.csv files
install.packages(c("tidyverse", "dplyr", "ggplot2", "readr", "data.table", "pryr"))
library(readr)

#data_2019 <- read_csv("Documents/sem4/4050/project")

data_2019 <- read_csv("Documents/sem4/4050/project4050kaggle/Combined_Flights_2019.csv")


#data_2019 <- read_csv("Documents/sem4/4050/project4050kaggle/Combined_Flights_2019.csv", skip = 0, n_max = 1000)


# Select only the variables of interest
selected_data <- data_2019[, c("DepTime", "DepDelayMinutes", "DepDelay", "ArrTime", "ArrDelayMinutes", "AirTime")]

#variables: Month, DayofMonth, DayOfWeek, CRSDepTime, DepDelay, Distance, Operating_Airline, CRSArrTime, CRSElapsedTime

selected_data <- data_2019[, c("Month", "DayofMonth", "CRSDepTime", "DepDelay", "Distance", "CRSArrTime", "CRSElapsedTime")]

# Compute the correlation matrix
correlation_matrix <- cor(selected_data)

# Print or view the correlation matrix
print(correlation_matrix)

summary(data_2019)

library(car)

vif_values <- vif(lm(DepTime ~ ., data = selected_data))

# VIF values
print(vif_values)


#Correlation matrix for each of your variables
library(ggplot2)


#Classification
#set.seed(123)  # for reproducibility
#train_indices <- sample(1:nrow(data_2019), 0.3 * nrow(data_2019))  # 50% of data for training
#train_data <- data_2019[train_indices, ]
#test_data <- data_2019[-train_indices, ]





#TrainingSet forest

# Assuming you have already split your data into training and test sets

# Train the Random Forest model
library(randomForest)

library(caret)

# Impute missing values using median
preproc <- preProcess(train_data, method = c("medianImpute"))
train_data_imputed <- predict(preproc, train_data)

# Train the Random Forest model
rf_model <- randomForest(DepDelay ~ ., data = train_data_imputed)

# Make predictions on the test set
predictions <- predict(rf_model, test_data)

# Evaluate predictive performance
# For classification:
accuracy <- sum(predictions == test_data$target_variable) / length(test_data$target_variable)
precision <- sum(predictions == "positive" & test_data$target_variable == "positive") / sum(predictions == "positive")
recall <- sum(predictions == "positive" & test_data$target_variable == "positive") / sum(test_data$target_variable == "positive")
f1_score <- 2 * (precision * recall) / (precision + recall)

# For regression:
mse <- mean((predictions - test_data$target_variable)^2)
mae <- mean(abs(predictions - test_data$target_variable))
r_squared <- cor(predictions, test_data$target_variable)^2

