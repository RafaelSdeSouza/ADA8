=============================
Tutorial on Bayesian Modeling
=============================
[ADA8 Summer School](http://ada8.cosmostat.org) - May 23rd, Chania - Greece

These are general instructions for those enrolled in the Bayesian Tutorial. 

The tutorial will be made of theoretical and practical modules. 
The examples will be demonstrated in R but familiarity with the language is not a requirement.
People not familiar to R will be able to follow all examples and discussions.
In fact, if you wish to start getting used to R this might be a good opportunity.

In order to optimize the time spent in examples and practical applications I advise the participants to get the following software up and running in advance.

Jags		-	 http://mcmc-jags.sourceforge.net
R     		-	https://www.r-project.org  
Rstudio 	-	https://www.rstudio.com   (visual interface for R)

Once Rstudio is installed you need to install a few R packages. 
These can be done:
 Using Rstudio tools bar

Tools -> Install packages

A window will pop-up where you can select:

Choose from: 	 Repository (CRAN)

Packages (separate multiple with space or comma):  
R2jags, MASS, Scales, mcmcplots, ggplot2, plot3D 

      2. Alternatively, you can simply type in the Rstudio console window

 	pac <-c("R2jags","MASS","scales","mcmcplots","ggplot2","plot3D");
install.packages(pac,dependencies=T)

This should be enough to get you ready for the exercises we will be working on. 

