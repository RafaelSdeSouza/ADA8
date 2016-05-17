# From Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press

# Chapter 4 - Normal linear model in R using JAGS
# 1 response (y) and 1 explanatory variable (x1)

require(R2jags)
require(mcmcplots)#install.packages("plot3D",dependencies = T)

set.seed(1056)                 # set seed to replicate example
nobs= 500                      # number of obs in model 
x1 <- runif(nobs)               # random uniform variable
xb <- 2 + 3*x1                  # linear predictor, xb
y <- rnorm(nobs, xb, sd=1)      # create y as adjusted random normal variate

# Frequentist
lm(y~x1)


X <- model.matrix(~ 1 + x1)
K <- ncol(X)
jags_data <- list(Y = y,
                 X  = X,
                 K  = K,
                 N  = nobs)
    

NORM <-" model{
    # Diffuse normal priors for predictors
    for (i in 1:K) { beta[i] ~ dnorm(0, 0.0001) }
    
   # Uniform prior for standard deviation
     tau <- pow(sigma, -2)       # precision
     sigma ~ dunif(0, 100)       # standard deviation
   
    # Likelihood function 
    for (i in 1:N){
    Y[i]~dnorm(mu[i],tau)
    mu[i]  <- eta[i]
    eta[i] <- inprod(beta[], X[i,])
    }
    }"


inits <- function () {
  list(
    beta = rnorm(K, 0, 0.01))

}

params <- c("beta", "sigma")

jagsfit <- jags(
           data       = jags_data,
           inits      = inits,
           parameters = params,
           model      = textConnection(NORM),
           n.chains   = 3,
           n.iter     = 5000,
           n.thin     = 1,
           n.burnin   = 2500)


print(jagsfit,justify = "left", digits=2)


traplot(jagsfit,c("beta", "sigma"))


denplot(jagsfit,c("beta", "sigma"))

caterplot(jagsfit,c("beta", "sigma"))


mcmcplot(jagsfit,c("beta", "sigma"))