# Clinical Trial Data Quality & Patient Analysis Using R
# Synthetic patient dataset
# Final cleaned portfolio script

# 1. Load packages
library(dplyr)
library(ggplot2)

# 2. Load data
# Update the path if your CSV is stored in another folder.
data <- read.csv("patients.csv", stringsAsFactors = FALSE)

# 3. Inspect the dataset
head(data)
dim(data)
str(data)
summary(data)

# 4. Data-quality checks

# Missing values
colSums(is.na(data))

# Duplicate records
sum(duplicated(data))

# Duplicate patient IDs
sum(duplicated(data$Patient_ID))

# Age range
range(data$Age, na.rm = TRUE)

# Invalid ages
data %>%
  filter(Age < 18 | Age > 100)

# Categorical-value checks
unique(data$Sex)
unique(data$Treatment)
unique(data$Country)

# Frequency checks
table(data$Sex)
table(data$Treatment)
table(data$Country)

# Enrollment-date range
range(data$Enrollment_Date, na.rm = TRUE)

# 5. Convert enrollment date
data <- data %>%
  mutate(
    Enrollment_Date = as.Date(
      Enrollment_Date,
      format = "%d-%m-%Y"
    )
  )

str(data$Enrollment_Date)

# 6. Create a clean dataset
clean_data <- data

# Verify cleaned data
clean_data

# 7. Treatment-wise descriptive summary
treatment_summary <- clean_data %>%
  group_by(Treatment) %>%
  summarise(
    Number_of_Patients = n(),
    Mean_Age = mean(Age, na.rm = TRUE),
    Minimum_Age = min(Age, na.rm = TRUE),
    Maximum_Age = max(Age, na.rm = TRUE),
    .groups = "drop"
  )

treatment_summary

# 8. Treatment and sex distribution
treatment_sex_summary <- clean_data %>%
  group_by(Treatment, Sex) %>%
  summarise(
    Number_of_Patients = n(),
    .groups = "drop"
  )

treatment_sex_summary

# Percentage of each sex within treatment groups
percentage_data <- treatment_sex_summary %>%
  group_by(Treatment) %>%
  mutate(
    Percentage = Number_of_Patients /
      sum(Number_of_Patients) * 100
  ) %>%
  ungroup()

percentage_data

# 9. Visualizations

# Age distribution by treatment
ggplot(clean_data, aes(x = Treatment, y = Age)) +
  geom_boxplot() +
  labs(
    title = "Age Distribution by Treatment Group",
    x = "Treatment Group",
    y = "Age (years)"
  )

# Number of patients by treatment
ggplot(clean_data, aes(x = Treatment)) +
  geom_bar() +
  labs(
    title = "Number of Patients by Treatment Group",
    x = "Treatment Group",
    y = "Number of Patients"
  )

# Sex distribution by treatment
ggplot(clean_data, aes(x = Treatment, fill = Sex)) +
  geom_bar() +
  labs(
    title = "Sex Distribution by Treatment Group",
    x = "Treatment Group",
    y = "Number of Patients",
    fill = "Sex"
  )

# Age distribution by sex
ggplot(clean_data, aes(x = Sex, y = Age)) +
  geom_boxplot() +
  labs(
    title = "Age Distribution by Sex",
    x = "Sex",
    y = "Age (years)"
  )

# Sex proportion within treatment groups
ggplot(percentage_data, aes(x = Treatment, y = Percentage, fill = Sex)) +
  geom_col() +
  labs(
    title = "Sex Proportion Within Treatment Groups",
    x = "Treatment Group",
    y = "Percentage (%)",
    fill = "Sex"
  )

# 10. Final treatment summary
final_summary <- clean_data %>%
  group_by(Treatment) %>%
  summarise(
    N = n(),
    Mean_Age = round(mean(Age, na.rm = TRUE), 1),
    Median_Age = round(median(Age, na.rm = TRUE), 1),
    SD_Age = round(sd(Age, na.rm = TRUE), 2),
    .groups = "drop"
  )

final_summary

# Sort final summary
final_summary <- final_summary %>%
  arrange(Treatment)

final_summary

# 11. Final mean-age visualization with SD error bars
ggplot(final_summary, aes(x = Treatment, y = Mean_Age)) +
  geom_col() +
  geom_errorbar(
    aes(
      ymin = Mean_Age - SD_Age,
      ymax = Mean_Age + SD_Age
    ),
    width = 0.2
  ) +
  labs(
    title = "Mean Age by Treatment Group",
    x = "Treatment Group",
    y = "Mean Age (years)"
  )

# 12. Export final project outputs
write.csv(
  clean_data,
  "clean_patient_data.csv",
  row.names = FALSE
)

write.csv(
  final_summary,
  "final_treatment_summary.csv",
  row.names = FALSE
)
