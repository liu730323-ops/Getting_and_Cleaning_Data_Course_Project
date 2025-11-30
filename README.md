# Getting and Cleaning Data Course Project

This repo contains my submission for the Coursera  
**"Getting and Cleaning Data"** course project.

## Files

- `run_analysis.R`  
  R script that:
  1. Downloads and unzips the UCI HAR Dataset
  2. Merges training and test sets
  3. Extracts only mean and standard deviation measurements
  4. Uses descriptive activity names
  5. Cleans variable names
  6. Creates a tidy data set with the average of each variable
     for each activity and each subject

- `tidy_dataset.txt`  
  The final tidy data set created by `run_analysis.R`.

- `CodeBook.md`  
  Explains the variables and transformations used to clean the data.

## How to run the script

1. Open `run_analysis.R` in R / RStudio.
2. Set the working directory to this repo folder.
3. Run the whole script (e.g., click **Source** in RStudio).
4. The script will:
   - Download the raw data if it is not present
   - Create `tidy_dataset.txt` in the working directory
