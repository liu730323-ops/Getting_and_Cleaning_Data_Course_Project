# CodeBook for Human Activity Recognition Tidy Dataset

## 1. Source Data

Original data from the UCI HAR Dataset:
- Measurements from smartphone accelerometer and gyroscope
- Train and test sets with 561 features

The raw data are **not** included in this repo.  
They are automatically downloaded by `run_analysis.R` from:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

---

## 2. Data Cleaning Steps

The script `run_analysis.R` performs the following steps:

1. **Download and unzip** the original dataset if it does not exist.
2. **Load** the following files:
   - `features.txt` (feature names)
   - `activity_labels.txt` (activity id -> activity name)
   - `X_train.txt`, `y_train.txt`, `subject_train.txt`
   - `X_test.txt`, `y_test.txt`, `subject_test.txt`
3. **Merge** train and test sets into one data set:
   - row-bind train and test
   - add `subject` and `activity` columns
4. **Extract only measurements on the mean and standard deviation**:
   - keep variables whose names contain `mean()` or `std()`
5. **Use descriptive activity names**:
   - replace activity IDs with names from `activity_labels.txt`
6. **Label the data set with descriptive variable names**:
   - `t` -> `Time`
   - `f` -> `Frequency`
   - `Acc` -> `Accelerometer`
   - `Gyro` -> `Gyroscope`
   - `Mag` -> `Magnitude`
   - `mean()` -> `Mean`
   - `std()` -> `Std`
7. **Create a second, independent tidy data set**:
   - group by `subject` and `activity`
   - calculate the mean of each measurement
   - write the result to `tidy_dataset.txt`

---

## 3. Variables in the Final Tidy Dataset

The file `tidy_dataset.txt` contains 180 rows and 68 columns:

- `subject`: integer, ID of the subject (1–30)
- `activity`: factor, one of  
  `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`,  
  `SITTING`, `STANDING`, `LAYING`
- The remaining columns are the average (per subject & activity)
  of each selected mean/std feature, for example:
  - `TimeBodyAccMeanX`
  - `TimeBodyAccMeanY`
  - `TimeBodyAccStdZ`
  - `FrequencyBodyAccMeanX`
  - `FrequencyBodyGyroStdZ`
  - etc.
