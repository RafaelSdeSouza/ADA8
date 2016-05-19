# ADA8 – Astronomical Data Analysis Summer School
# Bayesian tutorial by Rafael S. de Souza - ELTE, Hungary & COIN
#
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press
#
# Example of Bayesian negative binomial regression in R using JAGS
# synthetic data
# 1 response (y) and 1 explanatory variable (x1) 


library(R2jags)
library(MASS)

set.seed(141)                                           # set seed to replicate example
nobs <- 1500                                            # number of observations
x1 <- rbinom(nobs,size=1, prob = 0.6)                   # random binomial variable
xb <- 1 + 2.5*x1                                        # linear predictor
theta <- 0.5                                            # INCLUDE NAME OF PARAMETER
exb <- exp(xb)                                          
nby <- rnegbin(n = nobs, mu = exb, theta = theta)       # create y as adjusted random normal variate
negbml <-data.frame(nby, x1)

# prepare data for input
X <- model.matrix(~ x1, data=negbml)
K <- ncol(X)

NB.data <- list(
  Y = negbml$nby,
  X = X,
  K = K,
  N = nrow(negbml))


sink("NBGLM.txt")
cat(" model{
    # Priors for coefficients
    for (i in 1:K) { beta[i] ~ dnorm(0, 0.0001)}

    # Prior for dispersion
    theta ~ dunif(0.001, 5)

    # Likelihood function
    for (i in 1:N){
        Y[i] ~ dnegbin(p[i], theta)
        p[i] <- theta/(theta + mu[i])
        log(mu[i]) <- eta[i]
        eta[i] <- inprod(beta[], X[i,])
        } 
    }",fill = TRUE)
sink()


# set initial values
inits <- function () { list(
  beta = rnorm(K, 0, 0.1), 
  theta = runif(0.00, 5) )
}

# define parameters
params <- c("beta", "theta")
NB2 <- jags(data = NB.data, 
            inits = inits,
            parameters = params,
            model = "NBGLM.txt",
            n.thin = 1,
            n.chains = 3,
            n.burnin = 3000,
            n.iter = 5000)
            
# check results
print(NB2, intervals=c(0.025, 0.975), digits=3)

