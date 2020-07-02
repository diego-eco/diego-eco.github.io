** Internet Guide to Stata
* http://wlm.userweb.mwn.de/Stata/
** R to Stata
* https://dss.princeton.edu/training/RStata.pdf
** Commands everyone should know
* https://www.stata.com/manuals13/u27.pdf
** Data Types 
* https://www.stata.com/manuals13/ddatatypes.pdf
* https://www.stata.com/manuals13/u12.pdf



*** Clear everything
clear
*** Set Working Directory
cd /Users/Soporte/Desktop/Stata
*** Check Working Directory
pwd

*** Import Excel file (first row as var names)
*import excel "/Users/Soporte/Desktop/Stata/Macro_Tarea_2_Ej_3/datos.xls", sheet("Sheet1") firstrow
** Import from Github
* import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/df_jobs.csv"


*** To import Wooldridge datasets
*bcuse df_name
bcuse gpa2

*** Tools to data analysis
* describe
* list var1 var2
* list 1/10
* summarize
* sort var1 ascending order in var1
*list

*** Tools to manipulate variables

* drop var1
* rename new_name old_name
*generate new_var=var1+var2
gen new_var = sat-1
*replace var1=var1+var2
*Note: Note that a single equal sign corresponds to a variables name (as in the GENERATE command) while two equal signs are needed when dealing with a given value of a variable (as in VAR2==1).
* by varlist  makes Stata to repeat a command for each subset of the data for which the values of the variables in varlist are equal.



***** Regression in STATA

*** For linear model by MLS with two variables
* regress Y X_1 X_2
regress sat colgpa
* predict fitted stores the fitted values from the regression in a data column (variable) called FITTED, and keeps it in memory.
* predict residuals stores the residuals from the regression in a data column (variable) called FITTED, and keeps it in memory.

* To calculate predicted values, use the predict command after the regress or newey command
predict p 
* This creates a variable “p” of the fitted values  x’beta.
* To calculate least‐squares residuals, after the regress or newey command
predict e, residuals 
* This creates a variable “e” of the in‐sample residuals  y‐x’beta.




clear
bcuse hprice1


***** Graphs in Stata

** To save matrix (after graph is produced)
*graph export mygraph1.png, replace
* Use replace at the end to overwrite file

*** Simple Two Way Scatterplot
scatter price assess

clear
* 1978 Automobile Data
webuse auto
*** Multiple variables
scatter mpg headroom turn weight
* Note that the last variable is the one on the X axis.

clear
bcuse hprice1
*** Scatterplot matrix
graph matrix price assess sqrft
graph export mygraph2.jpg, replace

*** Histograms Note:assumes that the variable is continuous
histogram price
*Histograms scaled so that the bar heights sum 1
histogram price, fraction
*Histograms so that the bar height reflects the number of observations
histogram price, fraction
* Overlaying normal and kernel density estimates (replace normal)
	

*** Grpah Styling
clear
webuse auto
* https://www.stata.com/meeting/germany18/slides/germany18_Jann.pdf
* Stata provides a number of so-called schemes that define the overall look of graphs. 
* Set individually
scatter mpg headroom turn weight, scheme(s1color)
* Set to apply to all the graphs after the command.
set scheme s2color
*set scheme economist
*set scheme s1rcolor 
*set scheme plottig 
*set scheme plotplain 
*set scheme uncluttered 
*set scheme lean2 
scatter price mpg



** Titles, caption (legend), notes
 twoway (scatter price mpg), ytitle(Price of automobile) xtitle(Mileage) title(Scatterplot Price Mileage) subtitle(Automobile data) caption(This is a caption) note(Made by Diego López) legend(on)



*** Time Series
* http://econ.queensu.ca/faculty/gregory/econ452/manual.pdf
* https://www.ssc.wisc.edu/~bhansen/390/stata.pdf

* We often wish to create leads or lags of certain variables and Stata needs to know what variable in our set it should identify with the time (much more on this below). 

clear
import delimited "https://raw.githubusercontent.com/diego-eco/diego-eco.github.io/master/downloads/df_jobs.csv"

*format date %tw
*tsset date


*To calculate predicted values, use the predict command after the regress or newey command
 predict p
*This creates a variable “p” of the fitted values  x’beta.
*To calculate least‐squares residuals, after the regress or newey command
 predict e, residuals
*This creates a variable “e” of the in‐sample residuals  y‐x’beta.
*You can then plot the fit versus actual values, and a residual time‐series
 tsline y p
 tsline e 






*** Panel Data 
*https://www.princeton.edu/~otorres/Panel101.pdf
clear
import excel "/Users/Soporte/Desktop/Stata/Macro_Tarea_2_Ej_3/datos.xls", sheet("Sheet1") firstrow

*Inspect the dataframe
inspect NAICS
* by NAICS, sort: summarize Activos

** Look for duplicates 
*https://www.stata.com/support/faqs/data-management/duplicate-observations/
duplicates report
duplicates report NAICS Anio Trimestre
sort NAICS Anio Trimestre
by NAICS Anio Trimestre: gen dup = cond(_N==1,0,_n)
drop if dup>1

*Reduce dataframe for visual purpose
drop if NAICS<600000
inspect NAICS

** Define date variable
* https://www.stata.com/manuals13/tstsset.pdf
* gen date = yq(Anio, Trimestre) 
by NAICS, sort: gen date = yq(Anio, Trimestre) 

** Use xtset id year 
xtset NAICS date

** Plotting
xtline Ventas if NAICS==622110
twoway scatter Activos Efectivo, mlabel(NAICS) || lfit Activos Efectivo

** Fixed Effects using least squares dummy variable model (LSDV)
* By adding the dummy for each country we are estimating the pure effect of 
*x1 (by controlling for the unobserved heterogeneity).
regress Activos Efectivo i.NAICS

* Comparing with OLS
quietly  regress Activos Efectivo
estimates store ols
quietly  regress Activos Efectivo i.NAICS
estimates store ols_dum
estimates table ols ols_dum, star stats(N)

** Fixed effects: n entity-specific intercepts using xtreg
* Comparing the fixed effects using dummies with xtreg we get the same results.
xtreg Activos Efectivo, fe

* Graph Fixed Effects
quietly  regress Activos Efectivo i.NAICS
predict yhat
separate yhat, by(NAICS)
twoway connected yhat1-yhat7 Efectivo  || lfit Activos Efectivo, clwidth(thick) clcolor(black)




