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

** Multiple regression

*Simulated wage data set of 500 employees (fixed country, labor sector, and year).
* Age: age in years (scale variable, 20-70)
* Educ: education level (catergorical variable, values 1, 2, 3, 4)
* Female: gender (dummy variable, 1 for females, 0 for males)
* Parttime: parttime job (dummy variable, 1 if job for at most 3 days per week, 0 if job for more than 3 days per week)
* Wageindex: yearly wage (scale variable, indexed such that median is equal to 100)
* Logwageindex: natural logarithm of Wageindex 

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/dataset2.csv", encoding(UTF-8) 

* What is the total gender difference in wage, that is, including differences caused by other factors like education? (To get the total effect including education Effects, the variable education should be excluded from the model.)
 
* What is the partial gender difference in wage, excluding differences caused by other factors like education? (To get the partial effect excluding education effects, the variable education should be included in the model.)


 histogram wage, frequency subtitle("Histogram for wages")
 histogram logwage, frequency subtitle("Histogram for log wages")
* The histograms show that wage is much more skewed than log wages

* The following boxplots show that females have on average lower wages than males. 
* over : at each level of categorical variable over(var)
* https://www.stata.com/manuals/g-2graphbox.pdf

graph hbox wage, over(female,  relabel(1 "Male" 2 "Female")) title("Wage by gender")
* graph hbox wage, by(female)

graph hbox logwage, over(female,  relabel(1 "Male" 2 "Female")) title("Log Wage by gender")
* graph hbox logwage, by(female)

* simple regression analysis and explain log wage from the gender dummy, female

regress logwage female


* These Simple regression show that as compared to males, females do not differ significantly in age, but they have on average lower education and more often a part time job.

regress age female
regress educ female
regress parttime female

* How can we count the male/females separated by their education level?
* https://www.stata.com/manuals13/dcount.pdf

*Total men
count if female==0
*Totel women
count if female==1
*Total men with educ 1
count if female==0 & educ == 1
*Total women with educ 4
count if female==1 & educ == 4

* Let's look a deeper analysis on gender effect on wage by calculating the residuals from our first model:

* To calculate least‐squares residuals, after the regress or newey command
regress logwage female
predict e, residuals 
* This creates a variable “e” of the in‐sample residuals  y‐x’beta.

* e on a constant and education
regress e educ
* an extra level of education has an effect of +22\% of the unexplained part of wage. As expected, unexplained wage is higher for higher education levels.

* e on a constant and the part-time job dummy
regress e parttime
* having a part time job has an effect of +10\% on the unexplained part of wage, this is unexpected as we expect lower wages for part-time jobs. This result may be due to correlation with other factors. 

* We estimate the complete model:

regress logwage female age educ parttime

* The coefficient on educ means that increasing education by one level always leads to the same relative wage increase. This effect may, however, depend on the education level, for example, if the effect is smaller for a shift from eduction level 1 to 2 as compared to a shift from 3 to 4.

* We start by defining a dummy for Educ level 2 and the same for level 3 and 4:
* https://www.stata.com/support/faqs/data-management/creating-dummy-variables/

generate dum_edu2 = 0 
replace dum_edu2 = 1 if educ==2
generate dum_edu3 = 0 
replace dum_edu3 = 1 if educ==3
generate dum_edu4 = 0 
replace dum_edu4 = 1 if educ==4

* General educ models
regress logwage female age dum_edu2 dum_edu3 dum_edu4 parttime

* Applications.

* We return to the research question on the size and causes of gender differences in wage. We use the wage date and wage equation discussed before, including as explanatory factors the variables gender, age, education level, and an indicator for having a part time job.

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/trainexer25.csv", encoding(UTF-8) 

* Compare the significance of Female in the following three models.

regress logwage female
regress logwage female age educ parttime
regress logwage female age de2 de3 de4 parttime

* Notice that After controlling for age, education, and part-time job effects, the (partial) gender effect of −4% for females is not significant anymore.

* Now we show two relevant scatter diagrams:

regress logwage female age educ parttime
predict lm1_pred
predict lm1_res, residuals 

twoway (scatter logwage lm1_pred), ytitle(Log wage) xtitle(Fitted Log wage)
*The model would provide a perfect fit if all points were located exactly on the 45 degrees line
twoway (scatter lm1_res lm1_pred), ytitle(Residuals) xtitle(Fitted Log wage)
* No signal of heteroscedasticity

* Until now, we considered a model for the logarithm of wage, where the coefficients have the interpretation of relative wage effects. As an alternative, we now consider a model where the dependent variable is wage itself, instead of its logarithm.

regress wage female age educ parttime
predict lm2_pred
predict lm2_res, residuals 

* Again, we find significant effects of age, education, and part time jobs, but not for gender.
* One way to choose between the two models is to check whether the regression assumptions seem reasonable or not.

 twoway (scatter lm1_res lm1_pred), ytitle(Residuals) xtitle(Fitted Log wage) title(Log wage model)
*  This diagram shows no clear patterns, as the residuals are scattered rather randomly. This diagram is therefore more in line with the assumptions of the linear regression model. For this reason, we prefer the model for log-wage above the model for wage.
 
 twoway (scatter lm2_res lm2_pred), ytitle(Residuals) xtitle(Fitted Log wage) title(Level wage model)
* This diagram shows some patterns. The variance is small on the left and large on the right, suggesting heteroskedastic error terms. The residuals also exhibit a nonlinear pattern, somewhat like a parabolic shape. We therefore have some doubts on the regression assumptions of heteroscedasticity and linearity.

* Differences in effects can be modelled by replacing the single education variable by a set of three education dummies, namely for levels two, three, and four. In this way, education level one is taken as the benchmark level.

regress logwage female age de2 de3 de4 parttime
predict lm3_pred
predict lm3_res, residuals 

* Let’s look deeper into the model:

* Let ei be the residuals of the model (full_lm1). If these residuals are regressed on a constant and the three education dummies we obtain:

regress lm1_res de2 de3 de4

* The economic interpretation is that the model with fixed education effects gives sistematicaly biased wage forecast per education level



*** MODEL SPECIFICATION


clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/dataset3.csv", encoding(UTF-8) 
* This is a stock market data set for the United States for 1927-2013 (yearly data).
* Suppose we have a data set of a stock price index with a large number of variables which of which we suspect they may explain movements in the stock index.

* Define year as our time variable
tsset year 

* Annual evolution of the S&P 500 stock price index over the years 1927 up to 2013
tsline index, title("S&P 500 stock price index")
* the .com bubble at the end of the 1990s and its burst in the early 2000s, and the financial crisis starting 2007, 2008.

* Let's take one of the explanatory variables, which is the **book-to-market ratio**. This is the book value of the firms relative to the market value. The picture on the left plots the index together with this variable, with the index in blue on the left axis and the book-to-market ratio in red on the right axis.

twoway line index year, yaxis(2) || line bookmarket year, yaxis(1) title(SP500 Index and Book/Mkt)

* The index grows exponentially, while the book-to-market ratio stays relatively stable over time. We can transform the series in order to get a more similar behavior. For example, to undo the exponential growth, we can take the log of the index.
gen log_sp500 = log(index)

twoway line log_sp500 year, yaxis(2) || line bookmarket year, yaxis(1) title(log SP500 Index and Book/Mkt)

* It turns out that in our current application, we still need another transformation. We do not considered the log of the series directly, but the change in the log of the index from one period to the next.

twoway line d.log_sp500 bookmarket year, title(d.log SP500 Index and Book/Mkt)

* We can regress the change of the log index on a constant and book-to-market to study this relation in more detail.

regress d.log_sp500 bookmarket

* It turns out book-to-market is significant in explaining the change in the log of the stock index. It's significant at a 1% level, and the r-squared of this regression is 8%.Since book-to-market is defined as book value divided by market value, a high book-to-market period typically coincides with a period when the market value is low and has decreased.

* What would happen if we regress regress the S&P500 index (without any kind of transformation) on a constant and the book-to-market ratio.  

regress index bookmarket

* We make a plot of the residuals e from both models:
regress d.log_sp500 bookmarket
predict lm1_res, residuals 
regress index bookmarket
predict lm2_res, residuals 

tsline lm1_res , title(Residuals: d.log SP500 Index ~ Book/Mkt)
tsline lm2_res , title(Residuals: SP500 Index ~ Book/Mkt)

* The residuals in both regressions are clearly not the same. The most obvios difference is that in the Not transformed SP500 model, the residuals have a pattern and strong persistence (violating the assumption A7)

* We now regress the change in the log of the S&P500 index on a constant, the book-to-market ratio, and the square of the book-to-market ratio. 

* More generally, the # sign may be used to create interaction effects (age squared is just an interaction of age with itself). "c." of course is for "continuous".
regress d.log_sp500 bookmarket c.bookmarket#c.bookmarket
* See factor variables http://wlm.userweb.mwn.de/Stata/wstatfv.htm

gen bookmarket2 = bookmarket^2
regress d.log_sp500 bookmarket bookmarket2

* We can see from the p-value of BookMarket^2 that the coefficient is insignificant, thus the relationship is not quadratic.

* Now we define a dummy that is 1 for 1980 and all following years
* https://www.stata.com/support/faqs/data-management/creating-dummy-variables/
gen D1980 = (year >= 1980)

* We now  regress the change in the log of the S&P500 index on a constant, the book-to-market ratio, and an interaction between the book-to-market ratio and the just-defined dummy.

regress d.log_sp500 bookmarket c.bookmarket#D1980

* We can se from the result beta_3=0.048 and is not statistically significant, therefore the relationship might be stable over the pre-post 1980 periods.


