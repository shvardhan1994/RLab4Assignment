## ---- include = FALSE----------------------------------------------------

knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, include=TRUE,cache=FALSE-------------------------------------
library(Lab4Assignment)

## ----call linreg,eval=FALSE----------------------------------------------
#  # Call the function linreg:
#  data("iris")
#  linreg <- linreg$new(formula = Petal.Length ~ Species, data = iris)
#  

## ----call initialize,eval=FALSE------------------------------------------
#  
#  data("iris")
#  linreg <- linreg$initialize(formula = Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#    #new(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#  

## ----call implemented methods,eval=FALSE---------------------------------
#  
#  linreg$print()
#  linreg$plot()
#  linreg$resid()
#  linreg$pred()
#  linreg$coef()
#  linreg$summary()
#  

