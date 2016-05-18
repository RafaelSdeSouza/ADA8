# Tutorial on Bayesian Modeling #
## [ADA8 Summer School](http://ada8.cosmostat.org) - May 23rd, Chania - Greece ##


The tutorial is composed of theoretical and practical modules. 

The examples will be demonstrated in R but familiarity with the language is not a requirement.

People not familiar to R can follow all examples and discussions.

In order to optimize the time spent in the examples and practical applications, I advise the participants to get the following software up and running in advance.

* Jags		-	[http://mcmc-jags.sourceforge.net](http://mcmc-jags.sourceforge.net)
* R     	-	[https://www.r-project.org](https://www.r-project.org)
* Rstudio 	-	[https://www.rstudio.com](https://www.rstudio.com)

Once Rstudio is installed you will nedd few R packages. 

These can be done in 2 ways:

* Using Rstudio toolbar:

    -Tools -> Install packages

    A window will pop-up where you can select:

    Choose from: 	 Repository (CRAN)

        Packages (separate multiple with space or comma):
        R2jags, MASS, Scales, mcmcplots, ggplot2, plot3D 

* Alternatively, you can simply type in the Rstudio console window
```R
    -pac <-c("R2jags","MASS","scales","mcmcplots","ggplot2","plot3D");
    install.packages(pac,dependencies=T)
```

This should be enough to get you ready for the exercises we will be working on. 

