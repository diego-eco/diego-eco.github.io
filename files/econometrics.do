* Econometrics: Methods and Applications
* Diego López Tamayo. El Colegio de México diego.lopez@colmex.mx]
* Based on [MOOC](https://www.coursera.org/learn/erasmus-econom) by Erasmus University Rotterdam


* Parameter Estimation

*Dataset S1
*Contains 26 yearly returns based on the S&P500 index. Returns are constructed from end-of-year prices Pt as rt = (Pt – Pt-1)/Pt-1. Data has been taken from the public FRED database of the Federal Reserve Bank of St. Louis. 

import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/dataset_s1.csv", encoding(UTF-8) 

* A simple stat description of our dataset:

summarize return

* An histogram of the yearly returns on S&P500 index:


 histogram return, frequency subtitle("Histogram for yearly returns")

* We add a normal density over the histogram	
 
 histogram return, frequency normal subtitle("Histogram for yearly returns with normal distribution overlay")
 
 * Train Exercice S1 for Hyp Test https://www.ssc.wisc.edu/sscc/pubs/sfs/sfs-ttest.htm
clear 
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/trainexers1.csv", encoding(UTF-8) 
summarize return
* Hyp test for returns mean = 0 default 95%
ttest return=0
* The 95% confidence interval ranges from 4.951096 to 6.808421, which does not include 0
* Definitive larger that 0

* Hyp test for returns mean = 6 default 95%
ttest return=6

** Simple Regression
clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/week1_dataset1.csv", encoding(UTF-8) 




















