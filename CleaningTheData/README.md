run_analysis.r
===================
The script first reads all data and concatenate test and train datasets for X, Y, subject data. 
Then activity labels are replaced by the corresponding activity names. Next step is getting rid of all the columns except ones that contain "mean()" or "std()" in their names. To make the variable names descriptive I applied the CamelCase variable name convention to them (capitlized first letters in every word, without punctuation).
The next steps were to merge all cleaned data (subject, activities and cleaned dataset) together. The last step is to aggregate the values for each subject and each activity by averaging the correspodning values.