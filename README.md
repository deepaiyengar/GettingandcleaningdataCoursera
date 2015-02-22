# GettingandcleaningdataCoursera
Getting and cleaning data course project on Coursera
This file describes the script for forming a tidy data
from the UCI data given for the wearable computing project.
The original data represent data collected from the accelerometers 
from the Samsung Galaxy S smartphone


# The file run_analysis.R contains the script for the course project 
# for the "Getting and Cleaning Data" course on coursera

1. First the file indicated by the url is downloaded to the current working directory
2. Unzip the file
3. Install the required packages and libraries
4. Read in all the tables:
	Features (variables) 561*2
	Training and test sets: 7352*561 and 2947*561
	Subject sets for training and test: 7352*1 and 2947*1
	Activity sets for training and test: 7352*1 and 2947*1
	Activity labels: 6*2
5. Step 1 (as specified in the project details): create merged between the training and test sets
						 For data set : 10299*561			
						 For subject sets
						 For activity sets
						 Name the columns of the merged set using the features_set labels
6. Step 2: Extract columns with only mean and std values (first, extract mean values (ending in mean()), then, std values (ending in std()) and then concatenate)
7. Step 3: Replace activity numbers with names in the activity set
8. Step 4: Have descriptive headings for each data columng: here I only remove "()" and -
9. Step 5: Tidy the data: make column headings for the subject and activity data,
			  bind the subject and activity data to the main data,


