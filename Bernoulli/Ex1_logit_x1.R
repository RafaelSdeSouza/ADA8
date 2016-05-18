# ADA – Astronomical Data Analysis 
# by Rafael S. de Souza
# Partial example from Bayesian Models for Astrophysical Data 
# by Hilbe, de Souza & Ishida, 2016, Cambridge Univ. Press


# Example of frequentist linear regression in R
# 1 response (y) and 1 explanatory variable (x1)
require(R2jags)



set.seed(1056)                   # set seed to replicate example
nobs= 1000                        # number of obs in model 
x1 <- runif(nobs,0,3)                # random uniform variable
eta <- -6 + 2.5*x1                # linear predictor, eta
p <- 1/(1+exp(-eta))            # inverse-logit
by <- rbinom(nobs,size=1, prob = p) # create y as adjusted random bernoulli variate
logitmod <-data.frame(by, x1)
  

# Prepare data for prediction 
M=500
xx = seq(from =  min(x1), 
         to =  max(x1), 
         length.out = M)


############### Construct data dictionary
X <- model.matrix(~ x1, 
                  data = logitmod)
K <- ncol(X)
logit_data <- list(Y  = logitmod$by, # Response variable
                   X  = X,           # Predictors
                   K  = K,           # Number of Predictors including the intercept 
                   N  = nobs,        # Sample size 
                   xx = xx, 
                   M = M
)
############### JAGS code
LOGIT<-"model{

# Diffuse normal priors for predictors
for(i in k){beta[i]~dnorm(0,1e-3)}


# Likelihood function 

for (i in 1:N){  
Y[i] ~ dbern(p[i])
logit(p[i]) <- eta[i]
eta[i]      <- inprod(beta[], X[i,])
}
# Prediction for new data
for (j in 1:M){
etax[j]<-beta[1]+beta[2]*xx[j]
logit(px[j]) <- etax[j]
Yx[j]~dbern(px[j])
}

}
"
#A function to generate initial values for mcmc
inits  <- function () {
  list(
    beta  = rnorm(ncol(X), 0, 0.1)  )  }

params <- c("beta","px")

# Run mcmc
jagsfit<- jags(data       = logit_data,
               inits      = inits,
               parameters = params,
               model      = textConnection(LOGIT),
               n.thin     = 1,
               n.chains   = 3,
               n.burnin   = 3000,
               n.iter     = 5000)

############### Output on screen
print(jagsfit,intervals=c(0.025, 0.975),justify = "left", digits=2)



# Plot
y <- jagsresults(x=jagsfit, params=c('px'))
x <- xx
gdata <- data.frame(x =xx, mean = y[,"mean"],lwr1=y[,"25%"],lwr2=y[,"2.5%"],upr1=y[,"75%"],upr2=y[,"97.5%"])
# Bin data for visualization
binx<-0.05
t.breaks <-cut(x1, seq(0,1, by=binx))
means <-tapply(by, t.breaks, mean)
semean <-function(x) sd(x)/sqrt(length(x))
means.se <-tapply(by, t.breaks, semean)







gbin<-data.frame(x=seq(binx,1, by=binx),y=means)

ggplot(logitmod,aes(x=x1,y=by))+ geom_point(colour="#de2d26",size=1,alpha=0.35,position = position_jitter (h = 0.075))+
  geom_point(aes(x=x,y=y),size=2.5,data=gbin,colour="gray70")+
  geom_errorbar(data=gbin,aes(x=x,y=y,ymin=y-2*means.se,ymax=y+2*means.se),alpha=0.85,
                colour="gray70",width=0.005)+
  geom_ribbon(data=gdata,aes(x=xx,ymin=lwr1, ymax=upr1,y=NULL), alpha=0.45, fill=c("#00526D"),show.legend=FALSE) +
  geom_ribbon(data=gdata,aes(x=xx,ymin=lwr2, ymax=upr2,y=NULL), alpha=0.35, fill = c("#00A3DB"),show.legend=FALSE) +
  geom_line(data=gdata,aes(x=xx,y=mean),colour="gray25",linetype="dashed",size=1,show.legend=FALSE)+
  scale_colour_tableau(name="")+
  theme_bw() +
  ylab("y")+
  xlab("x")+
  theme(legend.background = element_rect(fill="white"),
        legend.key = element_rect(fill = "white",color = "white"),
        plot.background = element_rect(fill = "white"),
        legend.position="top",
        axis.title.y = element_text(vjust = 0.1,margin=margin(0,10,0,0)),
        axis.title.x = element_text(vjust = -0.25),
        text = element_text(size = 25,family="serif"))