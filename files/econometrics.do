* Econometrics: Methods and Applications
* Diego López Tamayo. El Colegio de México diego.lopez@colmex.mx]
* Based on [MOOC](https://www.coursera.org/learn/erasmus-econom) by Erasmus University Rotterdam


* Parameter Estimation

*Dataset S1
*Contains 26 yearly returns based on the S&P500 index. Returns are constructed from end-of-year prices Pt as rt = (Pt – Pt-1)/Pt-1. Data has been taken from the public FRED database of the Federal Reserve Bank of St. Louis. 

clear
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
*Let's look at our data frame
 histogram price, frequency normal subtitle("Histogram for price frequency")
 histogram sales, frequency normal subtitle("Histogram for sales frequency")
 
 * Scatter both variables https://www.ssc.wisc.edu/sscc/pubs/sfs/sfs-scatter.htm
graph twoway (lfit sales price) (scatter sales price) , ytitle(Price) xtitle(Sales) title(Scatterplot Price Sales) subtitle(With fitted line) caption(Made with simulated data) note(Simulated price and sales data set with 104 weekly observation) legend(on)


* New data exercises
* Simulated data set on holiday expenditures of 26 clients. 
* Age: age in years Expenditures: average daily expenditures during holidays
clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/trainexer1_1.csv", encoding(UTF-8) 


* Make two histograms, one of expenditures and the other of age. Make also a scatter diagram with expenditures on the vertical axis versus age on the horizontal axis.

 histogram expenditures, frequency normal subtitle("Histogram for expenditures frequency")
 histogram age, frequency normal subtitle("Histogram for age frequency")

 graph twoway (scatter expenditures age) , ytitle(Expenditures) xtitle(Age) title(Scatterplot Expenditures Age) caption(Made with simulated data) note(Simulated data set on holiday expenditures of 26 clients. ) legend(on)
 
* Compute the sample mean of expenditures of all 26 clients.

summarize expenditures
 
 * Compute two sample means of expenditures, one for clients of age forty or more and the other for clients of age below forty.

summarize expenditures if age >= 40
summarize expenditures if age < 40

* Estimation exercise

clear 
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/trainexer13.csv", encoding(UTF-8) 

* A simple regression model for the trend in winning times is 
* W_i=a+bG_i+e

regress winningtimemen game

* What prediction do you get for 2008, 2012, and 2016? 

* https://www.ssc.wisc.edu/~bhansen/390/stata.pdf
* To calculate predicted values, use the predict command after the regress or newey command
* predict p 
* This creates a variable “p” of the fitted values  x’beta.

* The predict command can be used for point forecasting, so long as the regressors are available. The dataset first needs to be expanded as previously described, and the regression coefficients estimated using either the regress or newey commands.  

* Expanding the Dataset Before Forecasting
set obs 16
replace game = 16 in 16
set obs 17
replace game = 17 in 17
set obs 18
replace game = 18 in 18

predict predicted 

* This will add to a new column all the predicted values including the new ones.

* Example: TrainExer15 Winning time 100 meter athletics for men and women at Olympic Games 1948-2004.

* Lets compute our linear and non-linear models:

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/trainexer15.csv", encoding(UTF-8) 

* Create our log variables
 generate ln_win_men = ln(winningtimemen)
 generate ln_win_women = ln(winningtimewomen)

* linear and non-linear models:

 regress winningtimemen game
 regress winningtimewomen game
 regress ln_win_men game 
 regress ln_win_women game

 * For example, we can also calculate some predictions with our non-linear models, remeber to exp() your results to remove the log()
 
* Remember that the command predict will work with the last runned model. 
 
set obs 16
replace game = 16 in 16
set obs 17
replace game = 20 in 17
set obs 18
replace game = 30 in 18
set obs 19
replace game = 40 in 19
set obs 20
replace game = 50 in 20

 regress winningtimemen game
 predict predic_line_men
 regress winningtimewomen game
 predict predic_line_women 
 regress ln_win_men game 
 predict predic_log_men 
 regress ln_win_women game
 predict predic_log_women 

 
