The script in this repository produces a summarised dataset based on [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

The resulting dataset is returned by the function run_analysis, included in the run_analysis.R script in this repository. This function will download the original dataset from the web or expect it to be found in the current working directory.

###Abstract

- Dataset characteristics: Multivariate, time-series
- Number of Instances: 180
- Number of Attributes: 81 

###Source
The observations in the resulting dataset are obtained from all the observations of the original dataset (test and train subsets). The observations correspond to 30 different individuals (those found in the original dataset). Each of the observations is labeled with an activity type.

###Dataset Information

The dataset provides the mean values of 79 different variables (those indicating standard deviation and mean values in the original dataset) for each subject and activity type. Since there are 30 different subjects in the original dataset and 6 possible activity types, there are 180 rows in the dataset. The first column contains an identifier of the subject, the second column contains an activity type, and the rest of the columns contain the mean values of each of the 79 variables extracted from the original dataset for this subject and activity type.

Citation of the original work: "Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013."
