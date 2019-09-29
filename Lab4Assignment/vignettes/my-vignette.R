## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup---------------------------------------------------------------
library(Lab4Assignment)

## ----call initialize,eval=TRUE-------------------------------------------

data("iris")
linreg <- linreg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris)


## ----call implemented methods,eval=TRUE----------------------------------

linreg$print()
linreg$plot()
linreg$resid()
linreg$pred()
linreg$coef()
linreg$summary()


