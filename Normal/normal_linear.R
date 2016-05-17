# ADA – Astronomical Data Analysis 
# by Rafael S. de Souza
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press


# Example of frequentist linear regression in R
# 1 response (y) and 1 explanatory variable (x1)


set.seed(1056)                    # set seed to replicate example
nobs= 100                        # number of obs in model 
x1 <- runif(nobs)                 # random uniform variable
mu <- 1 + 3*x1                    # linear predictor, xb
y <- rnorm(nobs, mu, sd=0.25)     # create y as adjusted random normal variate 

# Visualize data

plot(mu,y)


mod <- lm(y ~ x1)               # Normla Fit of the synthetic data. 
summary(mod) 



ypred <- predict(mod,type="response") # Prediction from the model 

# Plot regression line 
plot(x1,y,pch=16,col="red")
lines(x1,ypred,col='cyan',lwd=3)
# add the residuals
segments(x1,fitted(mod),x1,y,lwd=2,col="gray")