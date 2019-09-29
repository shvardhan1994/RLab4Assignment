---
title: "Lab4Vignette"
author: "Harshavardhan Subramanian"
date: "28/09/2019"
output: rmarkdown::html_vignette
rmarkdown::pdf_vignette
vignette: >
  %\VignetteIndexEntry{Lab4Vignette}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---




```r
library(Lab4Assignment)
```

<p> Advanced R Programing Lab 4 assignment aims at creating a linear regression package in R. Basic linear algebra to create the functionality in the R package.
This package also aims at implementing an object oriented system to handle special functions such as print(), plot(), resid(), pred(), coef() and summary().</p>

<p> A linreg function is created which takes in two arguments, "formula" of formula data type and "data" of data.frame data type. The function should return an object of RC implemented class.The computations are done using least square methods</p>

<p> The format of formula data type is dependent_variable ~ independent_variables </p>

<p> The package should also implement following methods inside the RC class :

* print(): 
    Prints the coefficients and coefficient names, similar as done by the lm class.
* plot(): 
    Plots the fitted values vs the residuals and the fitted values vs root of standardized residuals.
* resid(): 
    Returns a vector of Residual values.
* pred(): 
    Returns the Predicted values.
* coef(): 
    Returns the Coefficients.
* summary(): 
    Returns a similar printout as printed for lm objects, coefficients with their standard error, t-value and p-value as well as the estimate of sigma and the degrees of freedom in the model. </p>
    
## Implementation of linreg function using RC class and least square method to calculate linear regression coefficients.

<p> Here we are using "iris" data set to calculate linear regression between two fields as an example. The formula argument will be equated to Petal.Length ~ Species and data of iris is passed to data argument.</p>


```r
# Call the function linreg:
data("iris")
linreg <- linreg$new(formula = Petal.Length~Sepal.Width+Sepal.Length, data = iris)
#> Error in envRefInferField(x, what, getClass(class(x)), selfEnv): 'new' is not a valid field or method name for reference class "linreg"
```

<p> This creates a RC class which takes in input parameters and initializes the variables defined within the initialize method and calculates the required calculation to find the regression coefficient, expected values, residuals, variance, standarized residuals, variance, t values and pvalues. </p>

<p> As per the objective of the assignment, the methods defined inside the RC class has to be implemented and called using class object. The class object calls the particular method and the expressions within the method is evaluated and returns the desired value as expected by the assignment procedure. 
Below is the syntax to call the methods using objects : </p>

## Initializing the constructor method :


```r
data("iris")
linreg <- linreg$initialize(formula = Petal.Length~Sepal.Width+Sepal.Length, data=iris)
```

## Calling other methods :


```r

linreg$print()
#> Call:
#> linreg(formula = Petal.Length ~ Sepal.Width + Sepal.Length, data = iris) 
#> Coefficients: 
#> 
#> (Intercept) Sepal.Width Sepal.Length 
#> -2.52 -1.34 1.78
linreg$resid()
#>   [1] -0.445578965 -0.759772100 -0.236928933  0.006767993 -0.134157381
#>   [6] -0.142807413  0.308354980 -0.301882039 -0.005838155 -0.525909771
#>  [11] -0.610532071  0.153236470 -0.582212845  0.005583428 -1.219182103
#>  [16] -0.206173533 -0.542807413 -0.445578965 -0.809347506  0.056008022
#>  [21] -0.812119057 -0.077854307  0.176079637 -0.413303622  0.453236470
#>  [26] -0.737331354 -0.201882039 -0.523138219 -0.757000548  0.063071067
#>  [31] -0.248350516 -1.012119057  0.280035754 -0.218779681 -0.525909771
#>  [36] -0.869606697 -1.255815983  0.043401874  0.028024174 -0.479441294
#>  [41] -0.368019710 -1.086571383  0.295748831 -0.068019710  0.456008022
#>  [46] -0.582212845  0.156008022  0.040630322 -0.432972816 -0.535744368
#>  [51] -0.920791790 -0.055436262 -0.677094864 -0.162163930 -0.668444832
#>  [56]  0.652029205  0.455985322  0.337053927 -0.712141758  0.805963150
#>  [61] -0.175954643  0.264635354 -1.183822532  0.275654516  0.063450789
#>  [66] -0.821976354  1.097313118 -0.059392378 -1.038941041 -0.171998527
#>  [71]  1.132360012 -0.558207813 -0.414913309  0.141792187 -0.657023248
#>  [76] -0.778279429 -1.001122596 -0.355838683  0.253213770 -0.615695452
#>  [81] -0.228301601 -0.328301601 -0.259392378  0.585489113  1.452431627
#>  [86]  0.922525415 -0.521976354 -1.182637967  0.697313118  0.105560728
#>  [91]  0.639423057  0.309516845 -0.293254707  0.025632344  0.395726131
#>  [96]  0.619753863  0.485891534 -0.301904739 -0.184202253  0.252029205
#> [101]  1.755985322  0.940607622 -0.166075702  0.820536006  0.799279826
#> [106] -0.353871975  1.670916256 -0.255056540 -0.225150328  0.659539017
#> [111]  0.367004484  0.075252094 -0.033397938  0.750442219  1.074469951
#> [116]  0.744563738  0.499279826  0.639467401 -0.766880545 -0.183822532
#> [121]  0.256767465  1.229588460 -0.699155888 -0.147188651  0.745748303
#> [126]  0.024089701  0.064232932  0.609516845  0.509114423 -0.443634957
#> [131] -0.766478124 -0.015651108  0.509114423  0.186673677  0.774067529
#> [136] -1.031431230  1.489847651  0.810701409  0.687076099 -0.177094864
#> [141]  0.378023646 -0.477094864  0.940607622  0.634326720  0.745748303
#> [146] -0.155838683 -0.314913309  0.199279826  1.467406905  1.164635354
linreg$pred()
#>   [1] 1.8455790 2.1597721 1.5369289 1.4932320 1.5341574 1.8428074 1.0916450
#>   [8] 1.8018820 1.4058382 2.0259098 2.1105321 1.4467635 1.9822128 1.0944166
#>  [15] 2.4191821 1.7061735 1.8428074 1.8455790 2.5093475 1.4439920 2.5121191
#>  [22] 1.5778543 0.8239204 2.1133036 1.4467635 2.3373314 1.8018820 2.0231382
#>  [29] 2.1570005 1.5369289 1.8483505 2.5121191 1.2199642 1.6187797 2.0259098
#>  [36] 2.0696067 2.5558160 1.3565981 1.2719758 1.9794413 1.6680197 2.3865714
#>  [43] 1.0042512 1.6680197 1.4439920 1.9822128 1.4439920 1.3593697 1.9329728
#>  [50] 1.9357444 5.6207918 4.5554363 5.5770949 4.1621639 5.2684448 3.8479708
#>  [57] 4.2440147 2.9629461 5.3121418 3.0940369 3.6759546 3.9353646 5.1838225
#>  [64] 4.4243455 3.5365492 5.2219764 3.4026869 4.1593924 5.5389410 4.0719985
#>  [71] 3.6676400 4.5582078 5.3149133 4.5582078 4.9570232 5.1782794 5.8011226
#>  [78] 5.3558387 4.2467862 4.1156955 4.0283016 4.0283016 4.1593924 4.5145109
#>  [85] 3.0475684 3.5774746 5.2219764 5.5826380 3.4026869 3.8944393 3.7605769
#>  [92] 4.2904832 4.2932547 3.2743677 3.8042739 3.5802461 3.7141085 4.6019047
#>  [99] 3.1842023 3.8479708 4.2440147 4.1593924 6.0660757 4.7794640 5.0007202
#> [106] 6.9538720 2.8290837 6.5550565 6.0251503 5.4404610 4.7329955 5.2247479
#> [113] 5.5333979 4.2495578 4.0255300 4.5554363 5.0007202 6.0605326 7.6668805
#> [120] 5.1838225 5.4432325 3.6704115 7.3991559 5.0471887 4.9542517 5.9759103
#> [127] 4.7357671 4.2904832 5.0908856 6.2436350 6.8664781 6.4156511 5.0908856
#> [134] 4.9133263 4.8259325 7.1314312 4.1101523 4.6892986 4.1129239 5.5770949
#> [141] 5.2219764 5.5770949 4.1593924 5.2656733 4.9542517 5.3558387 5.3149133
#> [148] 5.0007202 3.9325931 3.9353646
linreg$coef()
#> Coefficients:
#>  (Intercept)  Sepal.Width Sepal.Length 
#>    -2.524762    -1.338623     1.775593
linreg$summary()
#> Call:
#>  Petal.Length ~ Sepal.Width + Sepal.Length
#> 
#> Residuals:
#>        Min         1Q      Median          3Q      Max
#>  -1.255816 -0.4692159 -0.05741432 -0.05741432 1.755985
#> 
#> 
#> Coefficients:
#>              Estimate Std. Error    t value     Pr(>|t|)    
#> (Intercept)  -2.52476 0.56343966  -4.480979 1.484032e-05 ***
#> Sepal.Width  -1.33862 0.12235776 -10.940240 9.429194e-21 ***
#> Sepal.Length  1.77559 0.06440503  27.569160 5.847914e-60 ***
#> ---
#> Signif . codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
#> 
#> Residual standard error: 0.65 on 147 degrees of freedom
```

## Calling plot method :


```r
linreg$plot()
```

![plot of chunk plot_method](figure/plot_method_1.png)
