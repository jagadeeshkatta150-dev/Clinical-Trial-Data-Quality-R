# Clinical Trial Data Quality & Patient Analysis Using R

## Project Overview

This project demonstrates the use of R programming for cleaning, validating, summarizing, and analyzing clinical trial patient data.

The project uses a synthetic patient dataset to demonstrate a basic clinical data analysis workflow.

## Objectives

- Inspect patient-level data
- Identify missing values
- Check for duplicate patient IDs
- Perform data cleaning and validation
- Calculate treatment-wise patient summaries
- Calculate mean age and standard deviation
- Create data visualizations using ggplot2
- Export cleaned and summarized datasets

## Tools & Technologies

- R
- RStudio
- dplyr
- ggplot2
- CSV

## Analysis Performed

The project includes:

1. Data inspection
2. Missing-value assessment
3. Duplicate patient ID checking
4. Data cleaning
5. Patient-level validation
6. Treatment-wise summary analysis
7. Mean and standard deviation calculations
8. Data visualization using bar charts and error bars
9. Export of final datasets

## Project Outputs

- `clean_patient_data.csv` — cleaned patient-level dataset
- `final_treatment_summary.csv` — treatment-wise summary results

## Dataset

The dataset used in this project is synthetic and contains 15 patient records.

Variables include:

- Patient ID
- Age
- Sex
- Treatment
- Enrollment Date
- Country

## Key R Functions Used

```r
filter()
count()
group_by()
summarise()
mutate()
arrange()
is.na()
mean()
sd()
write.csv()
## Conclusion

This project demonstrates a basic workflow for working with synthetic patient-level clinical data in R, including data cleaning, validation, summary analysis, and visualization.
