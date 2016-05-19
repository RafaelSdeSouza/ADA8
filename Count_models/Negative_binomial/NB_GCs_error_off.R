# JAGS NB Model-Population of Globular Clusters
############### Required packages
require(R2jags)
require(ggplot2)
require(ggthemes)
require(scales)
require(jagstools)


# Read data
dat = read.csv(file="https://raw.githubusercontent.com/emilleishida/BMAD/master/data/NB_GCs/NB_GCs.csv",header=TRUE,dec=".")

dat1<- dat[,c("N_GC","MV_T","Type")]
dat2 <- dat1[complete.cases(dat1),]


N = nrow(dat2)
N_GC = dat2$N_GC
MV_T = dat2$MV_T
K = 2

# Prepare data for prediction 
M=500
xx = seq(from = 1.05 * min(MV_T), 
         to = 0.875 * max(MV_T), 
         length.out = M)


#BAYESIAN NB
jags_data <- list(
  Y = N_GC,
  X = MV_T,
  N = N,
  xx = xx,
  M = M, 
  K = K
)


model.NB <- "model{

# Priors for regression coefficients
# Diffuse normal priors betas
    for (i in 1:K) { beta[i] ~ dnorm(0, 1e-5)}

#Prior for size
theta ~ dgamma(1e-3,1e-3)

#2. Likelihood

for (i in 1:N){

eta[i]<-beta[1]+beta[2]*X[i]
mu[i] <- exp(eta[i])
p[i]<-theta/(theta+mu[i])
Y[i]~dnegbin(p[i],theta)

# Discrepancy
expY[i] <- mu[i]
varY[i] <- mu[i] + pow(mu[i],2)/theta
PRes[i] <-(Y[i] - expY[i])/sqrt(varY[i])
}




# Prediction for new data
for (j in 1:M){
etax[j]<-beta[1]+beta[2]*xx[j]
mux[j] <- exp(etax[j])
px[j]<-theta/(theta+mux[j])
Yx[j]~dnegbin(px[j],theta)
}
}"

inits  <- function () {
  list(
    beta  = rnorm(K, 0, 0.1),
    theta=runif(1,0.1,5) 
     )  }

params <- c("beta","theta","Yx","PRes")


#4. Start JAGS
jagsfit <- jags(data       = jags_data ,
            inits      = inits,
            parameters = params,
            model      = textConnection(model.NB),
            n.thin     = 1,
            n.chains   = 3,
            n.burnin   = 3500,
            n.iter     = 7000)

print(jagsfit,intervals=c(0.025, 0.975),justify = "left", digits=2)

# Dispersion parameter
Pres<-jagsresults(x=jagsfit, params=c('PRes'))
Dispersion = sum(Pres[,"mean"]^2)/(N-3)# beta.0, beta.1 and k, 3 parameters



require(scales)





N_GCx <- jagsresults(x=jagsfit, params=c('N_GCx'))
gdata <- data.frame(MV_Tx=xx, mean = N_GCx[,"50%"],lwr1=N_GCx[,"25%"],lwr2=N_GCx[,"2.5%"],upr1=N_GCx[,"75%"],upr2=N_GCx[,"97.5%"])

asinh_trans <- function(){
  trans_new(name = 'asinh', transform = function(x) asinh(x), 
            inverse = function(x) sinh(x))
}






ggplot(dat2,aes(x=MV_T,y=N_GC))+
  geom_ribbon(data=gdata,aes(x=MV_Tx,ymin=lwr1, ymax=upr1,y=NULL), alpha=0.45, fill=c("#67a9cf"),show.legend=FALSE) +
  geom_ribbon(data=gdata,aes(x=MV_Tx,ymin=lwr2, ymax=upr2,y=NULL), alpha=0.35, fill = c("#d1e5f0"),show.legend=FALSE) +
  geom_point(aes(colour=Type,shape=Type),size=2.25,alpha=0.85)+
  geom_line(data=gdata,aes(x=MV_Tx,y=mean),colour="gray25",linetype="dashed",size=1,show.legend=FALSE)+
  scale_y_continuous(trans = 'asinh',breaks=c(0,10,100,1000,10000,100000),
  labels=c("0",expression(10^1),expression(10^2),expression(10^3),expression(10^4),expression(10^5)))+
  scale_colour_gdocs(name="")+
  scale_shape_manual(name="",values=c(19,2,8,10))+
  scale_x_reverse()+
  theme_bw() +
  ylab(expression(N[GC]))+
  xlab(expression(M[V]))+
  theme(legend.title = element_text(size=15),legend.background = element_rect(fill="white"),
                               legend.key = element_rect(fill = "white",color = "white"),
                               plot.background = element_rect(fill = "white"),
                               legend.position="top",plot.title = element_text(hjust=0.5),
                               axis.title.y = element_text(vjust = 0.75),
                               axis.title.x = element_text(vjust = -0.25),
                               text = element_text(size = 25))

quartz.save(type = 'pdf', file = 'NB_GCs.pdf',width = 10, height = 9)
