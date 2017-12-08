Human Activity Recognition Using Smartphones Tidy Data

Yongseong Suh
hweori98@yahoo.com
https://github.com/hweori98/datasciencecoursera

The analysis was prepared as per instruction provided by Getting and Cleaning Data course. Total of 3 files were produced: "README.md", "CodeBook.md", "run_analysis.r" They are uploaded on the above github repository. 

The codebook lists the variables analyzed, explains how the variables were filtered and analyzed, and provides brief information about the source dataset. The r script is a code that takes the original dataset and outputs a tidy dataset, which has averages of mean and standard deviation variables grouped by id's and activities, in a text file form. 

The code takes the original dataset, which were stored in several different text files before merged, filters for data we are interested in, and tidies it up for better readability and reproducibility. There are total of seven text files used to produce the merged dataset. From original data, Train group of 21 subjects with 7352 observations and Test group of 9 subjects with 2947 observations are bound together. Appropriate labels of variable names and activity are applied and are cleaned up to be more descriptive. Then, filters are applied to extract 81 relevant columns, which, subsequently, are used to estimate their averages grouped by subject id's and activities. The resulting data set is written out in a text file to the working directory.   

The resulting in 180 groups by id's and activities; subgrouped from total of 30 subject id's and 6 lables of activities. Each record is provided:
- subject id number
- activity label
- 79 averages of mean and standard deviation feature vectors


