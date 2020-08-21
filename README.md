# Network-based-prediction

## Introduction

This work is dedicated to investigate the predictive relationship 
and we employed 17 meta-analytically defined task-specific networks covering a broad range of domains including executive, socal, affective, and motor functions. 
Intrinsic connectivity within each of the networks 
through a strigent three-step validation procedure, including 10-fold and . 
The identified networks are moreover linked to neurotransmitter receptor/transport distrubution patterns via spatial correlation analysis. 
Overall, we provided a integreted link from symptomatology to molecular architecture. 

## Meta-analytic networks 
The coordinates used for generating the nodes have been reported in the source meta-analytic publications. Here we moreover provide text files containing the peak-activation coordinates for each of the 17 networks investigated in the present work as well as the NIFTI images denoting the node-locations.

![Image text](https://github.com/JiAllen/Network-based-prediction/raw/master/Image/NetworkExamples.tif)

## Predictive modeling 
Our predictive modeling is based on a relevance vector machine (RVM) (Tipping, 2001) as implemented in the SparseBayes package (http://www.miketipping.com/index.htm). The RVM refers to a specialization of the general Bayesian framework which has an identical functional form to the support vector machine (SVM). To use  and add to your working directory. 
10-fold cross-validation (stratified for site), leave-one-site-out cross-validation, as well as training models within-sample and then validate in independent samples 


## Neurotransmitter receptor/transporter maps
The density maps of receptors/transporters from prior molecular imaging studies are already publicly available in the “JuSpace” toolbox which can be freely downloaded from the website at https://github.com/juryxy/JuSpace. JuSpace is a comprehensive Matlab-based toolbox for the integration of PET- and SPECT- derived modalities with other brain imaging data (Dukart et al., 2020). 


## References

Chen J, Mueller VI, Dukart J, Hoffstaedter F, Baker JT, Holmes AJ, et al. Connectivity patterns of task-specific brain networks allow individual prediction of cognitive symptom dimension of schizophrenia and link to molecular architecture. bioRxiv. 2020 .

