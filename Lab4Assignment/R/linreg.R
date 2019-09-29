#' A linear regression package in R.
#' @description This package contains the code for Multiple Regression Model. A linreg function is created which takes two arguments and returns the object with of  RC class linreg.
#' @param formula,data Takes in two parameters, formula takes an expression of formula data type and data takes an dataframe data type.
#' @return Returns the object of linreg class.
#' @import methods
#' @export linreg


linreg <- setRefClass("linreg",
                      fields = list(
                        formula = "formula",
                        data = "data.frame"
                        
                      ),
                      methods = list(
                        initialize = function(formula,data){
                          
                          y <<- data[,all.vars(formula)[1]] #Dependent Variable Matrix
                          X <<- model.matrix(formula, data) #Independent Variable Matrix
                          
                          #Regression Coefficient
                          beta_cap <<- solve(t(X) %*% X) %*% t(X) %*% y
                          
                          #Fitted values y_cap
                          y_cap <<- X %*% beta_cap
                          
                          #Residuals e_cap
                          e_cap <<- y - y_cap
                          
                          #Degrees of Freedom df
                          d_o_f <<- nrow(X) - ncol(X)
                          
                          #Residual Variance sigma_square_cap
                          sigma_square_cap <<- (t(e_cap) %*% e_cap) / d_o_f
                          
                          #Standardized Residual error
                          resid_std_err <<- round(sqrt(sigma_square_cap),2)
                          
                          #Standardized Residual
                          root_sigma <<- sqrt(abs((e_cap - mean(e_cap)) /  as.vector(sqrt(sigma_square_cap))))
                          
                          
                          #Variance of Regression Coefficients var_beta_cap
                          var_beta_cap <<- diag(as.numeric(sigma_square_cap) * solve(t(X) %*% X) )
                          
                          #tvalues t_beta
                          t_beta <<- beta_cap / sqrt(var_beta_cap)
                          
                          #pvalues p_beta
                          p_beta <<- 2 * pt(abs(t_beta),d_o_f, lower.tail = FALSE)
                          
                          #lm formula
                          form<<-Reduce(paste, deparse(formula))
                          
                          df_name <<- trimws(deparse(substitute(data)),which = c("right"))
                          
                          pri_df <<- as.name(df_name)
                          
                          #Standard Error
                          std_err <<- sqrt(diag(var_beta_cap))
                          
                          #Siginificant Codes for p values
                          signi_code <<- symnum(p_beta, corr = FALSE, na = FALSE,
                                          cutpoints = c(0,0.001, 0.01, 0.05, 0.1, 1),
                                          symbols = c("***", "**", "*", ".", " "))
                          
                          vec_signi_code <<- signi_code
                          
                          #Dataframe for Summary
                          summary_matrix <<- data.frame(estimate <- round(beta_cap,5),
                                                       std_err <- diag((sqrt(diag(var_beta_cap)))),
                                                       t_beta <- t_beta,p_beta <- p_beta,
                                                       vec_signi_code <- as.vector(signi_code))
                          colnames(summary_matrix) <<- c("Estimate", "Std. Error", "t value", "Pr(>|t|)"," ")
                          
                          #Residuls for Summary
                          mi <<- min(e_cap)
                          ma <<- max(e_cap)
                          Q <<- quantile(e_cap)
                          Q1 <<- Q[2]
                          names(Q1) <<- "1Q"
                          med <<- median(e_cap)
                          Q3 <<- Q[3]
                          names(Q3) <<- "3Q" 
                          
                          Residuals <<- c("Min" = mi,Q1,"Median" = med,Q3,"Max" = ma)
                          Residuals <<- t(Residuals)
                          row.names(Residuals) <<- ("")
                          Residuals <<- Residuals
                          
                         return(.self) 
                          
                        }, 
                        print = function(){
                          
                          cat("Call:\n")
                          form_str <- paste("linreg(formula = ",form,", data = ",pri_df,")",sep = "")
                          cat(form_str,"\n")
                          cat("Coefficients: \n\n")
                          dis <- c(round(beta_cap,digits = 2))
                          cat(row.names(beta_cap),"\n")
                          cat(dis)
                          #trans_beta_cap <<- round(t(beta_cap),3)
                          #row.names(trans_beta_cap) <<- ("")
                          #base::print(trans_beta_cap)
                          
                          
                          #vec_beta_cap <- set.names(c(beta_cap),c("(Intercept)","Speciesvercicolor","Speciesvirginia"))
                          #names(vec_beta_cap) <- row.names(beta_cap)
                          #vec_beta_cap
                          #cat("\n Coefficients:\n", vec_beta_cap)
                         
                        
                        },
                        plot = function(){
                          plot1 <<- ggplot2::ggplot(data=data.frame(y_cap,e_cap),
                                                    ggplot2::aes(x= y_cap, y = e_cap)) +
                            ggplot2::xlab(paste("Fitted Values", "\n\t","lm(", form[1],")")) +
                            ggplot2::ylab("Residuals") + ggplot2::geom_point(shape=1, size=5) + ggplot2::ggtitle("Residuals vs Fitted")+
                            ggplot2::stat_summary(fun.y = median, color = "red", geom = "line", size=1)
                          
                          
                          plot2 <<- ggplot2::ggplot(data = data.frame(y_cap,root_sigma),
                                                    ggplot2::aes(x=y_cap, y = root_sigma)) +
                            ggplot2::geom_point(shape =1, size=5) +
                            ggplot2::ggtitle("Scale-Location") +
                            ggplot2::ylab(expression(sqrt(abs("Standardized Residuals")))) +
                            ggplot2::xlab(paste("Fitted Values", "\n\t","lm(", form[1],")"))+
                            ggplot2::stat_summary(fun.y = mean, color = "red", geom = "line", size=1)
                            library(gridExtra)
                            plt_meth <<- gridExtra::grid.arrange(plot1,plot2,nrow=2)
                          return(plt_meth)
                        },
                        resid = function(){
                          vec_e_cap <- as.vector(e_cap)
                          
                          base::print(vec_e_cap)
                        },
                        pred = function(){
                          base::print(as.vector(y_cap))
                          
                        },
                        coef = function(){
                          cat("Coefficients:\n")
                          vec_beta_cap <- c(beta_cap)
                          names(vec_beta_cap) <- row.names(beta_cap)
                          base::print(vec_beta_cap)
                          
                        },
                        summary = function(){
                          
                        
                          cat("Call:\n",form)
                          cat(sep = "\n")
                          cat(sep = "\n")
                          cat("Residuals:\n")
                          base::print(Residuals)
                          cat(sep = "\n")
                          cat(sep = "\n")
                          cat("Coefficients:")
                          cat(sep = "\n")
                          base::print(summary_matrix)
                          cat("---")
                          cat(sep = "\n")
                          cat("Signif . codes: ", attributes(signi_code)$"legend")
                          cat(sep = "\n")
                          cat(sep = "\n")
                          cat("Residual standard error:", resid_std_err, "on", d_o_f, "degrees of freedom")
                          cat(sep = "\n")
                          
                          
                        }
                      ))

#data("iris")

#linreg <- linreg$new(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#linreg <- linreg$new(Petal.Length ~ Species, data = iris)
#linreg$print()
#linreg$plot()
#l <- lm(Petal.Length~Sepal.Width+Sepal.Length, data=iris)
#l

#linreg_fun = function(formula,data){
#  linreg = linreg$new(formula,data)
 # linreg$print()
#  linreg$plot()
#  linreg$resid()
#  linreg$pred()
#  linreg$coef()
#  linreg$summary()
#  return(linreg)

#}
#linreg_fun(formula = Petal.Length ~ Species, data = iris)


