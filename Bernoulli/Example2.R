# JAGS LOGIT  Model
############### Required packages
require(R2jags)
require(Rlab)
library(MCMCpack)
require(jagstools)
library(extrafont)
############### Simulation 
# define model parameters
set.seed(13979)
nobs <- 5000
x1 <- runif(nobs)
xb <- 2 - 5.5*x1 
exb <- 1/(1+exp(-xb)) # inverse-logit
by <- rbern(nobs, prob = exb)
logitmod <-data.frame(by, x1) 




myL <- MCMClogit(by ~ x1,
                 burnin = 5000,
                 mcmc= 100000,
                 data=logitmod)
summary(myL)
plot(myL)


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
                  M = M, 
                  LogN = log(nrow(logitmod)),
                  b0   = rep(0, K),
                  B0   = diag(1e-5, K)
)
############### JAGS code
LOGIT<-"model{

# Diffuse normal priors for predictors
beta  ~ dmnorm(b0[], B0[,]) 

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

#require(PropCIs)
#semean <-function(x) add4ci(sum(x),length(x),conf.level = 0.95)
#means.se <-tapply(by, t.breaks, semean)





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


quartz.save(type = 'pdf', file = 'LOGIT_synt.pdf',width = 10, height = 9)





