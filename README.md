# getdata-014
R Script to tidy up data according to assignment

The function run_analysis in run_analysis.R in this repository will perform serveral cleanup and summarising steps on the dataset [Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
The goal is to generate a tidy dataset with the average per subject and activity of all variables containing the standard deviation and mean values.

The function run_analysis has an optional parameter in order to indicate the need to download the original dataset. If this parameter is not present, the original dataset is assumed to be in the corresponding folder in the working directory (according to the folder structure in the ZIP file obtained from the website hosting the original dataset).

The function makes use of the dplyr library in order to perform the grouping required to generate the resulting dataset.

After downloading the original dataset (if required), the function performs the following steps:

1. Read data files from the dataset ("X" files). Both for test and train subsets. All variables are numeric.
2. Read the inferred activity for each of the observations ("Y" files). These are read as numeric, later this numeric value will be used to set a descriptive text for each of the activities.
3. Add a column indicating the group of subjects (either "test" or "train"). This will be used when the test and train datasets are merged into one in order to identify the origin.
4. Merge test and train datasets into one by binding the rows.
5. Only variables with mean or standard deviation will be kept. In order to identify these variables, the column names in "features.txt" are searched for the substrings "mean" and "std". The resulting index list is stored (in std.and.mean).
6. The relevant columns (the first containing subject, second containing subject group, third containing activity and all the means and standard deviations) are stored in a resulting dataframe.
7. Activity names are obtained from the activity_labels.txt file. Each of the values in the column with the activities is replaced by the corresponding lable.
8. Column names are updated with descriptive names for the first three columns and descriptive names obtained from the features.txt file for the rest of the columns.
9. A new dataset is created using the summarise_each and group_by functions in dplyr. First group_by is used to create a tbl object with grouping on activity and subject. Then summarise_each is used to call the mean function in each of the columns, except for the first three(subject, subject_group and activity). As a result subject_group is removed from the tbl.
10. Column names in the new dataset are updated to reflect that they contain now the mean value for each subject and activity, and not individual observations.
