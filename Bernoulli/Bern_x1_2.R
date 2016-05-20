############### Required packages
require(ggplot2)
############### Simulation 
# define model parameters
set.seed(13979)
nobs <- 2500
nmax <- 1.5
nmin <- - 0.2
x1 <- runif(nobs,nmin,nmax)

xb <- -3 + 13.5*x1-7*x1^2 
exb <- 1/(1+exp(-xb)) # inverse-logit
by <- rbinom(nobs,size=1, prob = exb)
logitmod <-data.frame(by, x1) 


binx<-0.05
t.breaks <-cut(x1, seq(nmin,nmax, by=binx))
means <-tapply(by, t.breaks, mean)
semean <-function(x) sd(x)/sqrt(length(x))
means.se <-tapply(by, t.breaks, semean)
gbin<-data.frame(x=seq(nmin+binx,nmax, by=binx),y=means)

glogit <- glm(by ~ x1+I(x1^2),data=logitmod,family = 'binomial')
preds <- predict(glogit, type = 'response',se = TRUE)
pred.full <- preds$fit
ymin <- pred.full - 2*preds$se.fit
ymax <- pred.full + 2*preds$se.fit 
gdata1 <- data.frame(x1,pred.full,ymin,ymax)


gnrom <- lm(by ~ x1+I(x1^2),data = logitmod)
preds2 <- predict(gnrom, type = 'response',se = TRUE)
pred.full2 <- preds2$fit
ymin2 <- pred.full2 - 2*preds2$se.fit
ymax2 <- pred.full2 + 2*preds2$se.fit 
gdata2 <- data.frame(x1,pred.full2,ymin2,ymax2)


ggplot(logitmod,aes(x=x1,y=by))+ 
  geom_point(colour="cyan3",size=1,alpha=0.35,position = position_jitter (height  = 0.045))+
  geom_point(aes(x=x,y=y),size=2.5,data=gbin,colour="gray70")+
  geom_errorbar(data=gbin,aes(x=x,y=y,ymin=y-2*means.se,ymax=y+2*means.se),alpha=0.85,
                colour="gray70",width=0.005)+
  geom_line(aes(y=pred.full2), col='orange', size=1,data=gdata2,linetype="dotted") +  
  geom_line(aes(y=pred.full),data=gdata1,size=1,col='green3')+
  theme_hc() +
  ylab("y")+
  xlab("x")+coord_cartesian(ylim=c(-0.2,1.05))


