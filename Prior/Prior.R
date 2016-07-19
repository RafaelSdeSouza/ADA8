
#require(LearnBayes)
# Previous knowledge

# Sample size
nobs <- 100

# 75% are spiral

#Prior
alpha <- 1+0.75*100
beta  <- 1+(1-0.75)*100

#Plot prior
x<-seq(.005, .995, length=500)
y<-dbeta(x, alpha,beta)
plot(x,y, type="l",ylab="prior",xlab=expression(f[spirals]),col="blue",lwd=3)
abline(v=0.75,lty=3,lwd=2)

prior <- dbeta(x,alpha,beta)

# 20 obs 

spirals <- 0.5*2000
nospirals <- 0.5*2000

x = seq(0.005, 0.995, length = 500)
like <- dbeta(x,spirals+1,nospirals+1)
plot(x,like,type="l",col="blue")
abline(v=0.5,lty=3,lwd=2)



post=dbeta(x,alpha+spirals, beta+nospirals)
m=max(c(prior,like,post))
plot(x,post,type="l", ylab="Density", lty=2, lwd=3,
ylim=c(0,m),col="red")
lines(x,like,lty=1, lwd=3,col="blue")
lines(x,prior,lty=3, lwd=3,col="green")
legend("topleft",c("Prior","Likelihood","Posterior"),
lty=c(3,1,2), lwd=c(3,3,3), col=c("green","blue","red"))
  


prior = c(76,26)
# New observation
# 50% are spirals
# spirals  = 10
# others = 10

data <- c(10,10)

triplot(prior,data,where="topright")


# Larger data 5000

data <- c(2500,2500)

triplot(prior,data,where="topright")


