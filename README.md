# Network-based-prediction

## Introduction

This work is dedicated to investigate the predictive relationship 
and we employed 17 meta-analytically defined task-specific networks covering a broad range of domains including executive, socal, affective, and motor functions. 
Intrinsic connectivity within each of the networks 
through a strigent three-step validation procedure, including 10-fold and . 
Machine-learning approaches with a stringent validation sequence of 10-fold cross-validation, leave-one-site-out analyses, and generalization to an independent sample was implemented to identify robust association patterns between the probed networks and the four dimensions of psychopathology (6). Subsequently, whole-brain density maps of nine receptors/transporters from prior in vivo molecular imaging studies were employed to investigate the molecular architecture spatially coupled to the identified predictive networks.
The identified networks are moreover linked to neurotransmitter receptor/transport distrubution patterns via spatial correlation analysis. 
Overall, we provided a integreted link from symptomatology to molecular architecture. 

## Meta-analytic networks 
The coordinates used for generating the nodes have been reported in the source meta-analytic publications. Here we moreover provide text files containing the peak-activation coordinates for each of the 17 networks investigated in the present work as well as the NIFTI images denoting the node-locations.

Examples:
![Image text](https://github.com/JiAllen/Network-based-prediction/raw/master/Image/NetworkExamples.tif)

## Predictive modeling 
Our predictive modeling is based on a relevance vector machine (RVM) (Tipping, 2001) as implemented in the SparseBayes package (http://www.miketipping.com/index.htm). The RVM refers to a specialization of the general Bayesian framework which has an identical functional form to the support vector machine (SVM). To implement our predictive modeling with different validation schemes (i.e., 10-fold cross-validation, leave-one-site-out cross-validation, as well as training models within-sample and then validate in independent samples), please add the downloaded SparseBayes package to your Matlab working directory. 
 

## Neurotransmitter receptor/transporter maps
The density maps of receptors/transporters from prior molecular imaging studies are already publicly available in the “JuSpace” toolbox which can be freely downloaded from the website at https://github.com/juryxy/JuSpace. JuSpace is a comprehensive Matlab-based toolbox for the integration of PET- and SPECT- derived modalities with other brain imaging data (Dukart et al., 2020). 

Examples:
![Image text](https://github.com/JiAllen/Network-based-prediction/raw/master/Image/ReceptorMapExamples.tif)

## References

Chen J, Mueller VI, Dukart J, Hoffstaedter F, Baker JT, Holmes AJ, et al. (2020): Connectivity patterns of task-specific brain networks allow individual prediction of cognitive symptom dimension of schizophrenia and link to molecular architecture. bioRxiv doi: https://doi.org/10.1101/2020.07.02.185124.

Chen J, Patil K R, Weis S, Sim K, Nickl-Jockschat T, Zhou J, et al. (2020): Neurobiological Divergence of the Positive and Negative Schizophrenia Subtypes Identified on a New Factor Structure of Psychopathology Using Non-negative Factorization: An International Machine Learning Study. Biol Psychiatry 87(3): 282-293 

Tipping ME (2001): Sparse Bayesian learning and the relevance vector machine. J Mach Learn Res 1: 211-244. 

Dukart J, Holiga S, Rullmann M, Lanzenberger R, Hawkins PCT, Mehta MA, et al. (2020): JuSpace: A tool for spatial correlation analyses of magnetic resonance imaging data with nuclear imaging derived neurotransmitter maps. bioRxiv doi: https://doi.org/10.1101/2020.04.17.046300. 

