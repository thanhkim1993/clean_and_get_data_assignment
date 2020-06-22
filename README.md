# Cleaning and Getting data Assignment

A subset of Human Activity Recognition Using Smartphones Dataset, Version 1.0
==================================================================

- In this subsetted data set, I want to look at specific information on triaxial body acceleration in time domain. As such, I subseted only several corresponding collumns. 

For each record it is provided:
===============================

- Identifiers of participants.
- Groups in which the participants took part in, which include 'train group' or 'test group'.
- Activity names, which include walking, walking upstairs, walking downstairs, sitting, standing, and laying.
- Variables of body acceleration in time domains on different axis (i.e. X, Y and Z).

The dataset includes the following files:
=========================================

- A ReadMe          : 'README.md'.
  This file explains the data set and the analysis.

- A Codebook        : 'Codebook_Assignment.txt'.
  This file shows summary values and labels of variables.
  
- A tidy data set   : 'averageBodyAccelerometerTime.txt'.
  This file includes a tidy data set derived from the Coursera original data.
  
- A code script     : 'run_analysis.R'.
  This file contains codes for the reproducibility of the tidy data set.

Codes for reading the tidy data set: 
===================================
- library(readr)
averageBodyAccelerometerTime <- read_csv("Course 3 - Getting and Cleaning data/averageBodyAccelerometerTime.txt")

Last note!
==========
- Thank you very much indeed, for grading my work!.
- Have a good day.
- Thanh Kim from Vietnam.
