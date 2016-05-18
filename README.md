# Tutorial on Bayesian Modeling #
## [ADA8 Summer School](http://ada8.cosmostat.org) - May 23rd, Chania - Greece ##

Tutorial presented during the 8th Astronomical Data Analysis Summer School.

This repository holds  the scripts used to illustrate the theoretical concepts of Bayesian Modeling using synthetic and real data.

If you use any of resources presented here, please include the appropriate citation. 
Each folder holds scripts for a different probability distribution, references and the corresponding bibtex entry. 

Most of the material presented here will be presented with deeper discussions and further examples in our book to be released in late 2016:

_Bayesian Models for Astrophysical Data: using R/JAGS and Python/Stan_  
Hilbe, de Souza and Ishida, _in prep_, Cambridge University Press  



### Getting Started ###

The tutorial is composed of theoretical and practical modules. 

The examples will be demonstrated in R but _familiarity with the language is not a requirement_.

In order to optimize the time spent in the examples and practical applications, I advise the participants to get the following software up and running in advance.

* Jags		-	[http://mcmc-jags.sourceforge.net](http://mcmc-jags.sourceforge.net)
* R     	-	[https://www.r-project.org](https://www.r-project.org)
* Rstudio 	-	[https://www.rstudio.com](https://www.rstudio.com)

Once Rstudio is installed you will nedd few R packages. 

These can be done in 2 ways:

* Using Rstudio toolbar:

    -Tools -> Install packages

    A window will pop-up where you can select:

    Choose from:  

        Repository (CRAN)

    Packages (separate multiple with space or comma):

        R2jags, MASS, Scales, mcmcplots, ggplot2, plot3D 

* Alternatively, you can simply type in the Rstudio console window
    ```R
    -pac <-c("R2jags","MASS","scales","mcmcplots","ggplot2","plot3D");
    install.packages(pac,dependencies=T)
    ```

This should be enough to get you ready for the exercises we will be working on. 

### Author ###

**_Rafael da Silva de Souza_**

[Researcher, ELTE - Hungary](http://rafael2706.wix.com/rafaelsdesouza)
[Head and founder, the Cosmostatistics Initiative (COIN)](https://asaip.psu.edu/organizations/iaa/iaa-working-group-of-cosmostatistics)
[Vice-president for development, International Astrostatistics Association (IAA)](http://iaa.mi.oa-brera.inaf.it/adm_program/modules/announcements/announcements.php)


