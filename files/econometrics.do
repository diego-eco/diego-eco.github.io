* Econometrics: Methods and Applications
* Diego López Tamayo. El Colegio de México diego.lopez@colmex.mx]
* Based on [MOOC](https://www.coursera.org/learn/erasmus-econom) by Erasmus University Rotterdam

*** SINGLE REGRESSION ***

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

*** MULTIPLE REGRESSION ***

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



*** MODEL SPECIFICATION ***


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


**** Application on SP500 ****

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/dataset3.csv", encoding(UTF-8) 
tsset year 

* Variable transformation

* Here is the S&P 500 index again, annual data of the period 1927 through 2013.

tsline index, title("S&P 500 stock price index")

* Rather than modeling the stock index directly, or some appropriate transformed version, we consider how much the stock market index earns in total, on top of simply putting money in a risk-free asset. This difference tells us how high the total reward is for taking on the risk of the stock market.

* Index + Dividends


tsline index index_div, title("S&P 500 stock price index and Index + Dividends")

* We take the log to undo the exponential growth, and consider the difference of the log index to take out the trend in the log index. It turns out that the combination of these transformations gives a series that is approximately equal to a growth rate.

gen log_return = log(index_div/index[_n-1])

tsline log_return, title("Log return")


* For the economic setting, we also subtract the risk-free rate, for which we take the treasury bill rate, the return on short-term government bonds


gen log_eq_pr = log_return - log(1 + riskfree)

tsline log_return log_eq_pr, title("Log return and Log Equity Premium")

*** Testing Specification

* Just to get going, and as we only have five explanatory variables, we run five separate simple regressions. In each of these regressions, we regress the log equity premium on one of the variables

regress log_eq_pr bookmarket
regress log_eq_pr ntis
regress log_eq_pr divprice
regress log_eq_pr earnprice
regress log_eq_pr inflation

* From this table, you can see that both the book-to-market and the dividend/price ratio are significant at the 5% level for the log equity premium. Also the R-squareds are highest for these two regressions.

*** General-to-specific

* To develop a model for the log equity premium, we apply the general-to-specific approach. In column one, the output is given for the regression of the log equity premium on all variables. For all variables, we inspect whether they are significant, and if there are insignificant variables, we eliminate the variable with the highest p-value.

regress log_eq_pr bookmarket ntis divprice earnprice inflation
regress log_eq_pr bookmarket divprice earnprice inflation 
regress log_eq_pr bookmarket divprice earnprice
regress log_eq_pr bookmarket earnprice
regress log_eq_pr bookmarket


*** Stability

* As an example, we consider the stability during two important periods, the Second World War during 1939 up to 1945, and the oil crisis during 1973 up to 1975.

gen war_dummy = (year >= 1939  & year <= 1945)
gen oil_dummy = (year >= 1973  & year <= 1975)

* Selected model, including two extra coefficients for the interaction of the book-to-market value with the war-dummy, and the interaction with the oil-dummy.

regress log_eq_pr bookmarket c.bookmarket#war_dummy c.bookmarket#oil_dummy

*** Testing Information criteria

* We can compare the model we obtained (lm5) to the full model (lm1)
* estat ic displays Akaike’s and Schwarz’s Bayesian information criteria.

regress log_eq_pr bookmarket ntis divprice earnprice inflation
estat ic

regress log_eq_pr bookmarket
estat ic

* The Akaike and Bayesian information criteria confirm this. The lowest AIC and BIC values are indeed obtained for the book-to-market model, confirming this is the preferred approach.

* Notice glm and binreg, ml report a slightly different version of AIC and BIC
* https://www.stata.com/manuals13/restatic.pdf

*** RESET test

* After any regression. It is the Ramsey test (RESET) of specification that there is no independent power that improves significantly fit. It is the first thing to do, to solve omitted variable problems. if p-value = 0.000 is that there are variables (powers or roots of independent or dependent) omitted
* (omitted variable test) 

regress log_eq_pr bookmarket
ovtest

*** Chow Test

* New commands estat sbknown and estat sbsingle test for a structural break after estimation with regress or ivregress. Both are robust to unknown forms of heteroskedasticity, something that cannot be said of traditional Chow tests.

regress log_eq_pr bookmarket, vce(robust)

estat sbsingle

* The test DO NOT reject the null hypothesis of no structural break.

* We can also perform a test for more than one structural break if we have ex-ante information about when the breaks might be.

estat sbknown, break(y(1980))

* The test DO NOT reject the null hypothesis of no structural break in 1980

* To follow the Chow break test see:
* https://www.stata.com/support/faqs/statistics/computing-chow-statistic/ 
* https://kb.iu.edu/d/chow

*** Jarque Bera Normality Test

regress log_eq_pr bookmarket
predict model_residuals, residuals

* That "sum x,d" is Stata shorthand for "summarize x, detail", which returns a detailed statistical summary of the variable x
* Here we can see the Skewness and Kurtosis
sum model_residuals,d

* The following test is used
sktest model_residuals

* The model does fairly well. Reset with p=1 does not reject the null of correct specification, and both Chow tests do not reject the null of no breaks. Only Jarque-Bera seem somewhat doubtful, as at 5%, we reject normality of the residuals. This may hint to some remaining specification problems.


*** ENDOGENEITY ***


*** Consequences of endogeneity 

*Let’s reconsider the measurement error example where salary, denoted by y, depends on intelligence, denoted by x-star. 

*However, in practice we cannot observe intelligence and can only get a noisy measurement, say an IQ score. 

*The noisy measurement is denoted by x. As an illustration, we will use hypothetical data. where we randomly generate intelligence, x^*, and generate y=1+2x. The IQ score x is generated as x=x+noise.

* We create the random variables for our example:

* Prior to using runiform(), we set the seed so that the results are reproducible.

set obs 20
set seed 123
* https://www.stata.com/manuals/fnrandom-numberfunctions.pdf
generate x_1 = rnormal(2,3)
generate y_1 = 1+2*x_1
generate y_2 = 1+2*x_1+rnormal(0,2)


 graph twoway (scatter y_1 y_2 x_1) , ytitle(Salary (y)) xtitle(True inteligence x IQ Score x^*) title(Simulated example y=1+2x+u) caption(Made with simulated data)

 *  The OLS regression, through this cloud of points, is given by this blue line. However, this is not the line we want to have. The true effect of intelligence on salary is stronger (steeper)! This can clearly be seen by the regression line through the green dots. This red line shows the true effect we would like to estimate!
 
  graph twoway (lfit y_1 x_1) (lfit y_2 x_1) (scatter y_1 y_2 x_1) , ytitle(Salary (y)) xtitle(True inteligence x IQ Score x^*) title(Simulated example y=1+2x+u with lm lines) caption(Made with simulated data)

*** Example on endogeneity

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/trainexer42.csv", encoding(UTF-8) 

* Simulated data on 250 observations of sales and prices of ice cream under various scenarios of the Data Generating Process [DGP]. The DGP equals:
* Sales=100−1⋅Price+α⋅Event+ϵ1
* Price=5⋅βEvent+ϵ2
* The dataset contains sales and price data for different values of α and β. For each scenario the same simulated values for ϵ1 and ϵ2 were used. Specifically, the data contains 4 price series and 16 sales series.

* First consider the case where the event only directly affects price (α=0).

regress sales 0_0 price0
regress sales 0_1 price1
regress sales 0_5 price5
regress sales 0_10 price10

* As you can see, the coefficients are all close enough to the true value of −1 so there’s no problem here, price is NOT endogenous, as the event does not influence Sales directly. 
*The R2 increases for higher values of β this is due to the fact that for higher β, more of the variations in sales can be explained.

* Repeat the exercise above, but now consider the case where the event only directly affects sales, that is, set (β=0) and check the results for the four different values of α.

regress sales 0_0 price0
regress sales 1_0 price0
regress sales 5_0 price0
regress sales 10_0 price0

* We can see that all the coefficients again are relatively close to the true value −1, again, Price is not endogenous, as the Event only affects Sales, not Price. So the omission of Event does not lead to a correlation between the Error and Price.

* Finally consider the parameter estimates for the cases where the event affects price and sales, that is, look at α=β=0,1,5,10. Can you see the impact of endogeneity in this case?

regress sales 0_0 price0
regress sales 1_1 price1
regress sales 5_5 price5
regress sales 10_10 price10


* We now can see consequences of endogeneity, if α=β≠0, the omition of the Event dummy will lead to correltaion between the Error term Corr(Price,ϵ)≠0. As a consequence of the correlation, the estimate can be completely off, as α=β=10 shows an estimate close to 0.

*** Example: endogeneity and instruments *** 

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/trainexer44.csv", encoding(UTF-8) 

* Consumption of motor gasoline in the US from 1970 to 1999, including price index, disposable income, and price indices of used cars, new cars, and public transport.

* In this exercise we study the gasoline market and look at the relation between consumption and price in the USA. We will use yearly data on these variables from 1977 to 1999. Additionally we have data on disposable income, and some price indices.

*We consider the following model:
*GC=β1+β2PG+β3RI+ϵ

regress GC PG RI

* Give an argument why the gasoline price may be endogenous in this equation.
* The USA is a major player in the gasoline market, so it is likely that high demand for gasoline by the USA leads to an increase in the market price, in other words, consumption (GC) and price (PG) are determined simultaneously. Therefore we suspect that gasoline price (PG) may be endogenous.


** Use 2SLS to estimate the price elasticity (β2). Use a constant, RI, RPT, RPN, and RPU as instruments.

* 1. Regress X on Z to get explained part : X=Zγ+η

regress pg rpt rpn rpu ri

* The p -value for the instruments RPT,RPN is very low, indicating a strong correlation between this instrument and the endogenous variable PG aven after controling for other variables.

* We add the fitted values to dataset
predict pg_fitted

* 2. Regress y on X̂ 

regress gc ri pg_fitted

* We use PG_fitted which are the predicted values of step 1. The estimated price elasticity is −0.54 that means that a 1% price increase leads to about −0.5% decrease in consumption.

* 3.Perform a Sargan test to test whether the five instruments are correlated with ϵ. What do you conclude?

* First We calculate the residuals: Note that you need to use PG here, NOT PG_fitted

generate res_2sls = gc -(5.01+0.56*ri-0.54*pg)

* Second we regress the Res.2SLS on all the instruments:

regress res_2sls rpt rpn rpu ri

* The Sargent test statistic is equal to: nR2=30(0.104)=3.12 and should be compared with χ2(m−k)=χ2(5−3).

*** IV regression in STATA

* https://www.stata.com/manuals13/rivregress.pdf
* Because we are treating pg as an endogenous regressor, we must have one or more additional variables available that are correlated with pg but uncorrelated with error term.

* To fit the equation in Stata, we specify the dependent variable and the list of included exogenous variables. In parentheses, we specify the endogenous regressors, an equal sign, and the excluded exogenous variables. 
*Only the additional exogenous variables must be specified to the right of the equal sign; the exogenous variables that appear in the regression equation are automatically included as instruments.

ivregress 2sls gc ri (pg = rpt rpn rpu)

* 2SLS model and the IV model yield the same coefficients (the PG in the IV model is equivalent to the PG_fitted in 2SLS), but the standard errors are different. The correct ones are those provided by the IV model which are the ones we use for the Sargan Test.

* ivreg2 is written by Baum, Schaffer and Stillman, and produces a lot more statistics and tests including Sagan tests

* You need to instal ivreg2 before using via typing "ssc describe ivreg2"
ssc install ivreg2 
ssc install ranktest 
* http://mayoral.iae-csic.org/econometrics_insead20/StataIV_baum.pdf

ivreg2 gc ri (pg = rpt rpn rpu)

* Sargan statistic (overidentification test of all instruments): 3.125
*   Chi-sq(2) P-val =    0.2096

* The 5% critical value is χ2(2)=5.99 therefore as 3.12<5.99 we can NOT reject H0: Epsilon and Z are unrelated, we have valid instruments.
 
**** Case Application ****

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/dataset4.csv", encoding(UTF-8) 

* Simulated data on performance of 1000 participants of an Engineering MOOC. Performance is measured by Grade Point Average. Background variables are gender, whether participant followed a preparatory mathematics MOOC, and whether the participant received an email invitation for this preparatory MOOC.

* To get some first insight in the impact of the prep course, we take a look at the correlation between GPA and participation.

 graph twoway (lfit gpa participation) (scatter gpa participation), title(Participation vs GPA) 

* Participation on the horizontal access only takes two possible values. Zero for no, or one for yes. From this graph it seems that GPA is indeed a bit higher for learners who have taken the prep course. The regression line confirms this idea.


* A natural starting point is to formulate a linear model in which we regress GPA on a constant, a gender dummy variable that equals one if the learner is male and a dummy for participation.
*GPA=β1+β2GENDER+β3PARTICIPATION


regress gpa gender participation
predict lm1_res,residuals

* Participation seems to have a large positive impact on the GPA of about 0.8 grade point. The t-statistic suggests that this impact is also significant. The table further shows that males tend to perform slightly worse compared to females by about .2 grade point.

* We now need to ask ourselves whether we should trust these OLS estimates? If you think about all you have learned from our previous sections, you might suspect that the answer is no. It is very likely that participation is endogenous.

* 2SLS

*Stage 1
regress participation gender email
* We add the fitted values to dataset
predict part_fitted
predict sage1_res,residuals

*Stage 2
regress gpa gender part_fitted

*Stage 2 Alt with correct Std. Err.
ivreg2 gpa gender (participation = email)

* We now find a smaller but still significant impact of participation. Participation increases GPA by 0.24 points, which is considerably less then the OLS estimate of 0.84 obtained before. 

*** Hausman test

*We have argued in previous lectures that 2SLS will increase the estimation uncertainty. So we should only use 2SLS when participation is indeed endogenous.
* The null hypothesis is that the variable participation is exogenous.
*H0:PARTICIPATION exogenous

* lm1.resid=β1+β2GENDER+β3PARTICIPATIN+β4stage_1.resid

regress lm1_res gender participation sage1_res

* The test-statistic is the number of observations times the R-squared, and equals 36.8. This number should be compared to the chi-squared distribution with one degree of freedom as we test for the endogeneity of a single variable.

* As the critical value is χ2(1)=3.8, 36.8>3.8 we should reject the null hypothesis. Participation is endogenous and 2SLS should be used.

* Stata does 2SLS the estimation for you to get the correct (robust) standard errors
* http://www.eco.uc3m.es/~ricmora/mei/materials/Session_10_Testing.pdf

* Notice we use ivregress, not ivreg2

ivregress 2sls gpa gender (participation = email)
estat endogenous
* estat overid only with more instruments than endogenous variables

* If the test statistic is signignicant, the variables must be treated as endogenous


*** BINARY CHOICE ***

* We will learn about econometric challenges when the dependent variable can take only two values.
* When a dependent variable can only take two values, we often translate the outcomes into numerical values for notational convenience. In most applications, the values zero and one are used, but the researcher is free to use any two numbers.

* We consider data from a survey distributed among a thousand households. They were asked whether they would want to buy a new electronic gadget. Each individual was faced with a different price in dollars and could answer yes or no.

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/data5_1.csv", encoding(UTF-8) 

* The following graph shows a histogram of the answers. You can see that about 20% of the individuals answered, yes, and about 80% said no.

histogram response, frequency subtitle("Histogram of Response frequency")

* It is to be expected that the choice of individuals depends on the price of the new gadget. Next, we can see a scatter diagram of the data. 

 graph twoway (scatter response price), title(Price vs Response with lm fitted line) 

* The observations are indicated by circles. As you can see, there are roughly two clusters of observations. There is small cluster of observations at the top left corner. 

* Although there are also observations outside the two clusters, in general, the graph suggests that the relation between choice and price is negative. Suppose that you use a linear regression model to describe a binary dependent variable response. That is:
* response=β1+β2⋅price+ϵ

regress response price

* Although the dependent variable can only take two values, we can still apply least squares to estimate the model parameters. Although we can directly interpret the size of the β2 parameter, the interpretation of the size of this parameter is more difficult. Let us return to the scatter diagram shown before. 

 graph twoway (lfit response price) (scatter response price), title(Price vs Response with lm fitted line) 
 
* First of all, the regression line does not cross the cluster of data points in the top left corner. As the majority of the response observation is zero, the regression line turns out to be flat to make the residuals belonging to the many 0 observations small. 

 graph twoway (lfit response price) (scatter response price), title(Price vs Response with lm fitted line) 
 
* More importantly, the fitted line does not lead to zero or one predictions, but takes values between zero and 0.7, and in fact even values smaller than zero. The fit of the regression line is not in line with the binary character of the dependent variable.


* The model will explicitly deal with the binary character of the dependent variable by describing the probability that the dependent variable takes the value zero or one. The fit of such a model will look like the following curve:
* https://stats.idre.ucla.edu/stata/webbooks/logistic/chapter1/logistic-regression-with-statachapter-1-introduction-to-logistic-regression-with-stata/

logit response price
predict yhat1
twoway scatter yhat1 response price, connect(l i) msymbol(i O) sort ylabel(0 1)


*** Logistic function ***
clear 

* We generate a sequence of 100 numbers from -5 to 5
*https://www.stata.com/manuals13/drange.pdf
range x -5 5 100

* We generate some logistic functions to compared
gen y_1 = (exp(0+x))/(1+exp(0+x))
gen y_2 = (exp(0+3*x))/(1+exp(0+3*x))
gen y_3 = (exp(0-x))/(1+exp(0-x))
gen y_4 = (exp(2+x))/(1+exp(2+x))
gen y_5 = (exp(-2+x))/(1+exp(-2+x))


* You can clearly see that the probability is bounded between 0 and 1. The probability that Pr[y=1]=1/2 when xi=0. In general, the probability increases when x increases. The increase in probability is, however, not linear like in a linear regression model. For small values of x, the probability is really close to zero, and for large x the probability is nearly one.
graph twoway (line y_1 x ), title(Logistic function)

*To illustrate the role of the beta_2 parameter, we now change the size of this parameter. The new line shows the probability that y=1 in case β2 is three times as large. You can clearly see that the logistic function now is steeper:

graph twoway (line y_1 x )(line y_2 x ), title(Logistic function)

*Now we’ve made the β2 parameter negative. The new line shows a logit probability in case β2=−1. You can see that the logit probability is now a decreasing function of x. In fact, the probability plot is the mirror image of the original plot if you place a mirror vertically at x equal to 0.

graph twoway (line y_1 x )(line y_3 x ), title(Logistic function)

* Let us now change the value of the intercept parameter β1. The new line shows the logit probability where β1=2 instead of 0. You can see that the shape of the logit function stays the same, but that the location has changed. The graph has moved two units of x to the left. The logit probability is now 1/2 at x=−2, while in the original case, this happens at x equals 0. If we set β1=−2the graph moves two units to the right and the shape of the curve stays the same.

graph twoway (line y_1 x )(line y_4 x )(line y_5 x ), title(Logistic function)

*** Logit application ***

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/datalecture55.csv", encoding(UTF-8) 

* This dataset contains the responses of 925 clients of a commercial bank to a direct marketing campaign for a new financial product.

* Before constructing an econometric model, let us first look at the characteristics of the data.

describe
summarize
mean activity
mean male
mean male if response == 1
mean male if response == 0
mean activity if response == 1
mean activity if response == 0

* Create a table in Stata
* https://www.reed.edu/psychology/stata/gs/tutorials/tables.html

table activity male, c(mean response) row col


*** Specifying the model
* Because of the binary character of our independent variable, we use the logit model to describe response. As explanatory variables will include the gender dummy, the activity status, age and age squared.

* https://stats.idre.ucla.edu/stata/dae/logistic-regression/
* https://stats.idre.ucla.edu/stata/webbooks/logistic/chapter1/logistic-regression-with-statachapter-1-introduction-to-logistic-regression-with-stata/

logit response male activity age c.age#c.age

* The p-values in the final column indicate that all parameters are significant at the five percent level, including the parameter belonging to the square of age.

* A likelihood ratio test for the significance of the four parameters, excluding the intercept, gives the value of 78.35, which is significant at the 5 percent level based on the Chi-square distribution with 4 degrees of freedom. (You can see this test in the LR chi2(4) in the output.)

* You can also exponentiate the coefficients and interpret them as odds-ratios. Stata will do this computation for yo

logit , or

* We may also wish to see measures of how well our model fits. This can be particularly useful when comparing competing models.  fitstat
fitstat

* In sample forecast analysis
predict yfitted
gen type=0
replace type = 1 if response == 0 & yfitted < 0.5
replace type = 2 if response == 0 & yfitted >= 0.5
replace type = 3 if response == 1 & yfitted < 0.5
replace type = 4 if response == 1 & yfitted >= 0.5
count if type==1
count if type==2
count if type==3
count if type==4

*** Likelihood ratio test
* https://www.stata.com/manuals13/rlrtest.pdf

* We fit the following model:
logit response male activity age c.age#c.age
* We now wish to test the constraint that the coefficients on age, lwt, ptl, and ht are all zero or, equivalently here, that the odds ratios are all 1
test male activity age
* We save the current model:
estimates store full
* We then fit the constrained model, which here is the model omitting male and constant
logit response activity age c.age#c.age, nocons
* That done, lrtest compares this model with the model we previously stored
lrtest full
* We reject the null H0:β1=β2=0 at 5% level.

* Anothe method https://stats.idre.ucla.edu/stata/faq/how-can-i-perform-the-likelihood-ratio-wald-and-lagrange-multiplier-score-test-in-stata/

logit response male activity age c.age#c.age
estimates store m1
logit response activity age c.age#c.age, nocons
estimates store m2
lrtest m1 m2

* https://stats.idre.ucla.edu/other/mult-pkg/faq/general/faqhow-are-the-likelihood-ratio-wald-and-lagrange-multiplier-score-tests-different-andor-similar/

***** TIME SERIES *****


* Time series data are a specific type of data that need a somewhat special treatment when using econometric methods. The specific aspect of time series variables is that they are sequentially observed. That is, one observation follows after another. The sequential nature of time series observations has important implications for modeling and especially for forecasting and this is different from the cross-sectional data that we have mostly looked at so far.

*** Example Airline revenue
* Simulated data set on yearly revenue passenger kilometers, 1975-2015 (estimation period 1976-2015, with pre-sample value for 1975).

* First we import the dataset and define the date variable
* https://www.ssc.wisc.edu/sscc/pubs/stata_dates.htm

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/dataset61.csv", encoding(UTF-8) 

*https://www.stata.com/manuals13/tstsset.pdf
tsset year

* The first graph gives the actual total number of kilometers traveled. The second graph is obtained when taking natural logs and the  third graph shows the yearly growth rates.
gen x1a=log(rpk1)
gen dx1a=x1a[_n]-x1a[_n-1]

* https://www.stata.com/manuals/g-2graphtwowaytsline.pdf

twoway tsline rpk2, title(rpk2 in level)
twoway tsline x1, title(rpk2 in logarithm)
twoway tsline dx1, title(rpk2 in growth rate)

* he raw data on the left seems somewhat exponentially increasing, whereas the trend for the log of the time series seems more linear. The yearly growth rates fluctuate between minus 2% and plus 4%. 

* A constant mean is one aspect of what we call stationarity. For a stationary time series like in the D.log(RPK1) graph here, we have a straightforward modeling strategy. But for non-stationary time series, we will first need to get rid of this non-stationarity.

* This issue of trends is even more important when two time series show similar trending behavior. Look at this graph that depicts the revenue passenger kilometers of two airlines.

twoway tsline rpk1 rpk2, title(rpk1 and rpk2 in level)
twoway tsline x1 x2, title(rpk1 and rpk2 in logarithm)

* Clearly, they seem to have the same trend, especially when you take logs. This feature can be useful for forecasting in the following way. You may use both time series to estimate the common trend, then you can forecast the trend. And finally, derive the individual forecast for each of the airlines.

*** Example spurious regression

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/trainexer61.csv", encoding(UTF-8) 

* The datafile contains values of four series of length 250. Two of these series are uncorrelated white noise series denoted by ϵx,t and ϵy,t where both variables are NID(0,1) and E(ϵy,t,ϵx,s)=0 ∀t,s. The other two series are so-called random walks constructed from these two white noise series by xt=xt−1+ϵxt and yt=yt−1+ϵyt.

* As ϵxt and ϵyt are independent for all values of t and s, the same holds true for all values of xt and yt The purpose of this exercise is to experience that, nonetheless, the regression of y on x indicates a highly significant relation between y and x if evaluated by standard regression tools. This kind of result is called spurious regression and is caused by the trending nature of the variables x and y.


* Graph the time series plot of xt against time t, the time series plot of yt against time t, and the scatter plot of yt against xt
* We create an index for each observation (date)
generate date = _n
tsset(date)

graph twoway (line x date) , ytitle(x) xtitle(date) title(x in time) caption(Made with simulated data)

graph twoway (line y date) , ytitle(x) xtitle(date) title(x in time) caption(Made with simulated data)

graph twoway (scatter x y) , ytitle(y) xtitle(x) title(x vs y) caption(Made with simulated data)

* The two variables X,Y have completly random movements up and down. And the scatter plot seems to have a negative relation, so we could use X to forecast Y, but we know that this is not the case, the scatterplot is misleading in this sense.

* To check that the series ϵxt and ϵyt are uncorrelated, regress ϵyt on a constant and ϵxt. Report the t-value and p-value of the slope coefficient.

regress epsy epsx

* The t-value of the coefficient is around -1.32 and the p-value around 0.19, this shows that ϵxt and ϵyt have no significant relation.

* Extend the analysis of part (b) by regressing ϵyt on a constant, ϵxt, and three lagged values of ϵyt and of ϵxt

regress epsy L.epsy L2.epsy L3.epsy epsx L.epsx L2.epsx L3.epsx

* We can see the F-statistic at the top of the output. F=0.55  and as is smaller of the critical value of 2. We do NOT reject the H0. This is correct as the value of ϵyt is independent of all other observations.

* Regress y on a constant and x. Report the t-value and p-value of the slope coefficient. What conclusion would you be tempted to draw if you did not know how the data were generated?

regress y x

* t seems by looking at the large t-value of X that X has a relevant explanatory power over Y. We know that this is not the case, so the regression is misleading, due to the trending nature of both variables.

* Let et be the residuals of the regression of part (d). Regress et on a constant and the one-period lagged residual et−1. What standard assumption of regression is clearly violated for the regression in part (d)?

predict resid, residuals
regress resid L.resid

* This coefficient is significant at 99%, this shows that the residuals are very strongly correlated. Therefore violates the standar regression assumption A7 that the error terms should be uncorrelated.

*** REPRESENTING TIME SERIES 

* Back to airlines example

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/dataset61.csv", encoding(UTF-8) 
tsset year

* Let us return now to the airline revenue passenger kilometers data. The data show a trend. And the growth rates do not.

tsline x1, title("log(RPK2)")
tsline dx1, title("D.log(RPK2)")

* We plot the Autocorrelation Function (ACF) function and the Partial Autocorrelation Function (PACF)

ac x1, title("Autocorrelation log(RPK2)")
pac x1, title("Partial Autocorrelation log(RPK2)")

ac dx1, title("Autocorrelation D.log(RPK2)")
pac dx1, title("Partial Autocorrelation D.log(RPK2)")

* The autocorrelations of the log series show a very slowly decaying pattern. And the partial autocorrelations are only large at lag 1. The values for the growth rates are not significant, as the number of observations is 39 and 2 divided by the square root of 39 is about 0.3.


*** EVALUATION OF TIME SERIES ***
* Example of Revenue Airline

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/dataset61.csv", encoding(UTF-8) 
tsset year

* Consider again the two series on revenue passenger kilometers for two airlines. Clearly the two times series show a trending pattern. Note that we have transformed the original series here by taking natural logs, which makes their trends approximately linear.

tsline x1 x2, title("log(RPK1) and log(RPK2)")

* On the other hand, the first differences, which here can be interpreted as annual growth rates, seem stationary because they fluctuate around a constant mean.

tsline dx1 dx2, title("D.log(RPK1) and D.log(RPK2)")


*To save notation, we use yt for the logs of each of the series.

*** 1. Check for stationarity

* Dickey Fuller Test https://www.stata.com/manuals13/tsdfuller.pdf

*In the ADF test equation, we include a constant (α), a deterministic trend term βt, and a single lag of ΔX1t
dfuller x1, lags(1) trend regress

*In the ADF test equation, we include a constant (α), a deterministic trend term βt, and a single lag of ΔX2t
dfuller x2, lags(1) trend regress

*** As both ADF t values are larger than the critical value -3.5 X1 and X2 are not stationary.

* Now let’s test the first difference DX1 and DX2

*In the ADF test equation, we include a constant (α), a deterministic trend term βt, and a single lag of ΔX1t and ΔX2t
dfuller x1, lags(1) trend regress
dfuller x2, lags(1) trend regress


* When we analyze the growth rates, there is no reason to add any deterministic trend in the test regression.
dfuller dx1, lags(1) regress
dfuller dx2, lags(1) regress

*** As both t values are smaller than the critical value -2.9, DX1 and DX2 are both stationary.


**** 2. Check for causality

* Next, we investigate if the two series are mutually linked. For that purpose we estimate two autoregressive distributed lag models, one for the growth rates of X1 (DX1) and the other for those of X2 (DX2)
*We include two lags of each, and in the table you see the estimated coefficients, their t-statistics and the associated p-values.

*We estimate the two following regressions:

* Model for dx1
regress dx1 L.dx1 L2.dx1 L1.dx2 L2.dx2

* We can see from the results for the first regression that the p-values for the coefficients for lags of ΔX2,t tγ1=1.74 and tγ2=−1.27.
* For a joint test (F-test)  _b[L1.dx2]=_b[L2.dx2]=0
test _b[L1.dx2]=_b[L2.dx2]=0
* "We do not reject H_0 at 0.95%" 
* There’s no indication that DX2 is granger causal for DX1

* Model for dx2
regress dx2 L.dx2 L2.dx2 L1.dx1 L2.dx1
test _b[L1.dx1]=_b[L2.dx1]=0

*  "We reject H_0 at 0.95% in favor of H_1"
* There’s evidence that DX1 is granger causal for DX2


* Clearly, growth rates of X1 (DX1) can be predicted by their own past, and some of that past is also informative for DX2. So airline one is Granger causal for airline two, but not the other way around. And note that you need formal tests to establish this result, as the graphs are in no way informative in this respect.


*** 2. Check for cointegration

* Next, let us investigate whether the two series are cointegrated. The linear regression of X2 on X1 gives the candidate long-run equilibrium relation with a slope coefficient of 0.92
regress x2 x1

* Step 1 OLS : X2,t=0.01+0.92X1,t+et

*  We add the residuals into the dataset
predict res_eq, residuals
* Perform ADF on residuals without constant
dfuller res_eq, lags(1) noconstant regress

* The ADF test is based on the estimate of −0.50 for the coefficient of e in period t−1 in the relevant auxiliary regression. And it equals t=−3.558. And as this is smaller than the 5% critical value −3.4, we can conclude that the residuals from the regression in step one are stationary. .

* Step 2 ADF : Δet=0.00−0.50et−1+0.30Δet−1+rest


** And thus, that X1 and X2 are co-integrated

* When we now include the error correction term in the model for the growth rates of X1
generate correc = L.x2-0.92*L.x1
* ECM1 (after removing insignificant coefficients) and susbtituing
regress dx1 L.dx1 correc

* ECM2 (after removing insignificant coefficients) and susbtituing
regress dx2 correc

* When we now include the error correction term in the model for the growth rates of X1, we get an adjustment parameter of 0.46. And when we include it in the model for the growth rates of X2, we get −0.45.


* The signs of these parameters imply that X1 and X2 cannot deviate too much from their equilibrium. For example, suppose that there is a positive deviation in period t−1. This will have an increasing effect on X1t in period t and a decreasing effect on X2t. And as a result, the deviation from equilibrium is expected to decline in period t. Note also that deviations from the equilibrium are corrected by changes in both X1t and X2t


*** 3. ECM: Check for serial correlation and normality

*Serial Correlation Test Breusch-Godfrey test for higher-order serial correlation.

regress dx1 L.dx1 correc
estat bgodfrey, lags(1)
* Null: No autocorrelation not rejected

regress dx2 correc
estat bgodfrey, lags(1)
* Null: No autocorrelation not rejected

* Breusch-Godfrey test (1 lag) : BG1=0.29<3.9,BG2=1.23<3.9 No autocorrelation


* Normality test Jarque Bera
regress dx1 L.dx1 correc
predict ecm1_res, residuals
* Null: Normality not rejected 
sktest ecm1_res

regress dx2 correc
predict ecm2_res, residuals
* Null: Normality not rejected 
sktest ecm2_res

* Jarque-Bera test : JB1=0.38<6,JB2=1.82<6. Normality not rejected

* The absence of such correlation is also visible from the sample autocorrelations of the residuals shown in this graph. Only 1 out of the 20 autocorrelations is outside the 95% confidence bound, and this is not unusual for a test with significance level 5%

ac ecm1_res, title("Autocorrelation of residuals ecm1")
ac ecm2_res, title("Autocorrelation of residuals ecm2")








