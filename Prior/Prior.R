
require(LearnBayes)
# Previous knowledge

# 70 ~80 %  of galaxies are Spirals 


# Sample size
nobs <- 100

#Prior
alpha <- 76
beta  <- 26

x<-seq(.005, .995, length=500)
y<-dbeta(x, alpha,beta)
plot(x,y, type="l",ylab="prior",xlab=expression(f[spirals]),col="blue",lwd=3)
abline(v=0.75,lty=3,lwd=2)


prior = c(76,26)
# New observation
New_obs <- 20
# 50% are spirals

# spirals  = 10
# others = 10

data <- c(10,10)

triplot(prior,data,where="topright")