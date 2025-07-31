# Load required packages
library(readr)
library(dplyr)


# Load the CSV file (replace with your actual path if needed)
df <- read_csv("dummy-product-review-survey.csv", col_names = FALSE)

# Define columns to drop by position
cols_to_remove <- c(2:6, 8, 10:18)

# Remove them
df_cleaned <- df[, -cols_to_remove]

# Set first row as column names
colnames(df_cleaned) <- df_cleaned[1, ]
df_cleaned <- df_cleaned[-c(1, 2),]


# Step 1: Define the starting question IDs for each condition (in the order of conditions 1 to 8)
condition_starts <- c("Q5", "Q238", "Q254", "Q267", "Q280", "Q293", "Q306", "Q319")

# Step 2: Get the 8-question blocks per condition
condition_blocks <- lapply(condition_starts, function(start_q) {
  start_idx <- which(colnames(df_cleaned) == start_q)
  colnames(df_cleaned)[start_idx:(start_idx + 7)]
})

# Step 3: Identify condition per respondent
condition_flags <- apply(df_cleaned[, sapply(condition_blocks, `[[`, 1)], 1, function(row) {
  which(!is.na(row) & row != "")[1]  # First non-empty condition match
})

# Step 4: Store in dataframe
df_cleaned$Condition <- condition_flags

# Step 5: Merge the 8 questions based on identified condition
merged_questions <- lapply(1:8, function(i) {
  mapply(function(row, cond) {
    col_name <- condition_blocks[[cond]][i]
    df_cleaned[row, col_name]
  }, row = 1:nrow(df_cleaned), cond = df_cleaned$Condition, USE.NAMES = FALSE)
})

# Transpose result: rows = respondents, columns = Q1–Q8
df_questions_merged <- as.data.frame(do.call(cbind, merged_questions))
colnames(df_questions_merged) <- paste0("Q", 1:ncol(df_questions_merged))


# Step 6: Add metadata and merged question responses
df_metadata <- df_cleaned[, 1:3]
df_condition <- df_cleaned["Condition"]
df_final <- bind_cols(df_metadata, df_questions_merged, df_condition)

# Step 7: Create dummy variable lookup
dummy_map <- data.frame(
  Condition = 1:8,
  Hvariance = c(1, 1, 0, 0, 1, 1, 0, 0),
  Emotional = c(1, 0, 1, 0, 1, 0, 1, 0),
  Product = c(1, 1, 1, 1, 0, 0, 0, 0)
)

# Step 8: Merge dummy variables
df_final <- left_join(df_final, dummy_map, by = "Condition")

# Step 9: Filter to include finished responses
df_final$Finished <- as.numeric(df_final$Finished)
df_final <- df_final %>%
  filter(Finished == 1)

# Step 10: Rename Q1 to Q8
new_columns <-  c("Atti1", "Atti2", "Purch1", "Purch2", "Starinf", "Writtinf", "Age", "Gender")
colnames(df_final)[4:11] <- new_columns

df_final[new_columns] <- sapply(df_final[new_columns],as.numeric)

# Step 11: Create Attitude and Purchase Intent averages
df_final <- df_final %>%
  mutate(
    Atti = rowMeans(select(., Atti1, Atti2), na.rm = TRUE),
    Purch = rowMeans(select(., Purch1, Purch2), na.rm = TRUE)
  )





