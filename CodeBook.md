Code Book
=========
This codebook summarizes the data stored in MeanSensorData.txt. Data was initially obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  Training and test data sets were merged and all measurements that were not a mean or standard deviation were removed.  The mean was calculated for each measurment across activity and subject groups.  Activity and subject groups are defined below.  This resulted in a data frame consisted of mean measures of averages and standard deviations per subject and per activity.  

Factors
-------
* Subject - an intiger that identifies the annonymous subject number.
* Activity - an intiger identifying the type of activity. 
	1: walking
	2: walking upstairs
	3: walking downstairs
	4: sitting
	5: standing
	6: laying
* 79 measurements described by their column names.  These measures are either means or standard deviations.  

Description of data
--------------------
The data are means of the measure across subjects and activities.  