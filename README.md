# coursera-getting-and-cleaning-data-project
Final Exam 

This repository contains the following files:

- README.md, this is a global information file. 
- run_analysis.R which contains the R script to run to generate the tidyData cleaned from de the raw data.
- CodeBook.md, the code book, which describe steps of the cleaning project with the raw data. 
- tidyData.txt,  the final dataset cleaned 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Raw data 

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

0. Download data 
1. Rename column names of the subject data and create one data frame from the train,test (activity) and subject files. 
2. Subset data by extracting only the measurements on the mean and standard deviation for each measurement.
3. Load activity_description and rename the levels of activity column of the dataset subseted. 
4. Rename the column labels of the data set using the variables description file and removing "()"
5. Creating tidy dataframe from the subseted data, grouping by subject and activity and calculating the mean by measurements
6. Writing to table the tidy data
