# ADA – Astronomical Data Analysis 
# by Rafael S. de Souza
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press


# Example of frequentist linear regression in R
# 1 response (y) and 1 explanatory variable (x1) with a quadratic term


set.seed(1056)                    # set seed to replicate example
nobs= 150                         # number of obs in model 
x1 <- runif(nobs,0,5)             # random uniform variable
mu <- 1 + 5*x1-0.75*x1^2          # linear predictor, xb
y <- rnorm(nobs, mu, sd=0.5)     # create y as adjusted random normal variate 

# Visualize data

plot(x1,y)


fit <- lm(y ~ x1+I(x1^2))               # Normla Fit of the synthetic data. 
summary(fit) 

xx <- seq(0,5,length=200)
ypred <- predict(fit,newdata=list(x1=xx),type="response") # Prediction from the model 

# Plot regression line 
plot(x1,y,pch=19,col="red")
lines(xx,ypred,col='cyan',lwd=4,lty=2)
# add the residuals
segments(x1,fitted(fit),x1,y,lwd=2,col="gray")