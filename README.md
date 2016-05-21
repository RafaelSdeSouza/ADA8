<img src="images/COIN.png" width="800" align="right">

# Tutorial on Bayesian Modeling #
## [ADA8 Summer School](http://ada8.cosmostat.org) - May 23rd, 2016 - Chania, Greece ##


Tutorial presented during the 8th Astronomical Data Analysis Summer School.

This repository holds  the scripts used to illustrate the theoretical concepts of Bayesian Modeling using synthetic and real data.

If you use any of the resources presented here, please include the appropriate citation. 
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
    pac <-c("R2jags","MASS","scales","mcmcplots","ggplot2","plot3D");
    install.packages(pac,dependencies=T)
    ```

This should be enough to get you ready for the exercises we will be working on. 

### Chapter 1  - Gaussian models ###

The Gaussian or normal probability distribution assumes a bell-shaped distribution centred in the mean . 


[Wikipedia](https://en.wikipedia.org/wiki/Normal_distribution)

[Tutorial Examples](https://github.com/RafaelSdeSouza/ADA8/tree/master/Normal)




### Chapter 2 - Count models ###

Count data can take only non-negative integer values {0, 1, 2, 3, ...}, which arise from counting rather than ranking. 

[Wikipedia](https://en.wikipedia.org/wiki/Count_data)

[Tutorial Examples](https://github.com/RafaelSdeSouza/ADA8/tree/master/Count_models)



### Chapter 3 - Bernoulli models ###

The Bernoulli distribution is the probability distribution of a random variable which takes the value 1 with success probability of p and the value 0 with failure probability of q=1-p. It can be used to represent a coin toss where 1 and 0 would represent "head" and "tail" (or vice versa), respectively.

The Bernoulli distribution is a special case of the two-point distribution, for which the two possible outcomes need not be 0 and 1. It is also a special case of the binomial distribution; the Bernoulli distribution is a binomial distribution where the number of trials is equal to 1.

[Wikipedia](https://en.wikipedia.org/wiki/Bernoulli_distribution)

[Tutorial Examples](https://github.com/RafaelSdeSouza/ADA8/tree/master/Bernoulli)

### References ###

de Souza _et al_, 2016, _Is the cluster environment quenching the Seyfert activity in elliptical and spiral galaxies?_, [arxiv:astro-ph/1603.06256](http://adsabs.harvard.edu/abs/2016arXiv160306256D), [BibTex](https://github.com/RafaelSdeSouza/ADA8/tree/master/bib/deSouza_2016.bib)  

de Souza _et al_, 2015, _The overlooked potential of generalized linear models in astronomy - III. Bayesian negative binomial regression and globular cluster populations_, [MNRAS, 453, p.1928-1940](http://adsabs.harvard.edu/abs/2015MNRAS.453.1928D), [BibTex](https://github.com/RafaelSdeSouza/ADA8/tree/master/bib/deSouza_2015_GLMIII.bib)  

Elliot _et al_, 2015, _The overlooked potential of Generalized Linear Models in astronomy-II: Gamma regression and photometric redshifts_, [Astronomy & Computing, 10, p. 61-72](http://adsabs.harvard.edu/abs/2015A%26C....10...61E), [BibTex](https://github.com/RafaelSdeSouza/ADA8/tree/master/bib/Elliot_2015_GLMII.bib)  

de Souza _et al_, 2015, _The overlooked potential of Generalized Linear Models in astronomy, I: Binomial regression_, [Astronomy & Computing, 12, p. 21-32](http://adsabs.harvard.edu/abs/2015A%26C....12...21D), [BibTex](https://github.com/RafaelSdeSouza/ADA8/tree/master/deSouza_2015_GLMI.bib)  

Hilbe, 2014, _Modeling Count Data_, [Cambridge University Press](http://www.cambridge.org/mq/academic/subjects/statistics-probability/statistical-theory-and-methods/modeling-count-data), [BibTex](https://github.com/RafaelSdeSouza/ADA8/tree/master/bib/Hilbe_2014.bib)  

Hilbe, 2011, _Negative Binomial Regression_, [Cambridge University Press](http://www.cambridge.org/mq/academic/subjects/statistics-probability/statistical-theory-and-methods/negative-binomial-regression-2nd-edition?format=HB&isbn=9780521198158), [BibTex](https://github.com/RafaelSdeSouza/ADA8/tree/master/bib/Hilbe_2011.bib)



### Author ###

**_Rafael da Silva de Souza, PhD_**

[Researcher - ELTE, Hungary](http://rafael2706.wix.com/rafaelsdesouza)  
[Head and founder - The COsmostatistics INitiative (COIN)](https://asaip.psu.edu/organizations/iaa/iaa-working-group-of-cosmostatistics)  
[Vice-president for development - The International Astrostatistics Association (IAA)](http://iaa.mi.oa-brera.inaf.it/adm_program/modules/announcements/announcements.php)  




