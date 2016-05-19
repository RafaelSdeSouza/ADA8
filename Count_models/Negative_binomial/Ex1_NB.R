library(R2jags)
set.seed(141)
library(MASS)
nobs <- 1500
x1 <- rbinom(nobs,size=1, prob = 0.6)
xb <- 1 + 2.5*x1
theta <- 0.5
exb <- exp(xb)
nby <- rnegbin(n = nobs, mu = exb, theta = theta)
negbml <-data.frame(nby, x1)


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
    } }
    ",fill = TRUE)
sink()
inits <- function () { list(
  beta = rnorm(K, 0, 0.1), # Regression parameters
  theta = runif(0.00, 5) )
}
params <- c("beta", "theta")
NB2 <- jags(data = NB.data, 
            inits = inits,
            parameters = params,
            model = "NBGLM.txt",
            n.thin = 1,
            n.chains = 3,
            n.burnin = 3000,
            n.iter = 5000)
            
print(NB2, intervals=c(0.025, 0.975), digits=3)

