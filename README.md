# Network-based-prediction

## Introduction

This work is dedicated to investigate whether individual dimensions of psychopathology are associated with the inter-individual variability in brain functional connections within different networks in schizophrenia (Chen et al., 2020a). Specifically, 17 meta-analytically defined task-specific networks which cover a broad range of domains reflecting executive, social, affective, memory, language, and sensory-motor functions are employed. Hence, the predicted dimensions of psychopathology can be readily linked to specific functional systems and mental processes when analyzing the intrinsic connectivity patterns at resting-state. Four data-driven dimensions of schizophrenia symptomatology (i.e., positive, negative, affective and cognitive) introduced and extensively validated in our recent PANSS-based factorization study (Chen et al., 2020b) were used to depict individual psychopathology. Individual explression along thse four symptom dimensions were predicted using relevance vector machine with the intrisic functional connectivity of each meta-analytic network as the features to assess the predictive relationship between the probed networks and symptoms. Our predictive modeling involves a stringent three-step validation procedure, including 10-fold and leave-one-site-out cross-validations within a multi-site, heterogeneous schizophrenia patient sample and the generalization to an independent sample. To enrich our network-symptom findings, whole-brain density maps of nine receptors/transporters from prior in vivo molecular imaging studies were further employed to investigate the molecular architecture spatially coupled to the identified predictive networks. Overall, we provided an integrative link from symptomatology to molecular basis. 

Information on the node-locations of our employed meta-analytic networks (in nifti format), density maps of neurotransmitter receptors/transporters from prior molecular imaging in healthy populations, as well as the code for our predictive modeling can be found below:  

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

Chen J, Mueller VI, Dukart J, Hoffstaedter F, Baker JT, Holmes AJ, et al. (2020a): Connectivity patterns of task-specific brain networks allow individual prediction of cognitive symptom dimension of schizophrenia and link to molecular architecture. bioRxiv doi: https://doi.org/10.1101/2020.07.02.185124.

Chen J, Patil K R, Weis S, Sim K, Nickl-Jockschat T, Zhou J, et al. (2020b): Neurobiological Divergence of the Positive and Negative Schizophrenia Subtypes Identified on a New Factor Structure of Psychopathology Using Non-negative Factorization: An International Machine Learning Study. Biol Psychiatry 87(3): 282-293 

Tipping ME (2001): Sparse Bayesian learning and the relevance vector machine. J Mach Learn Res 1: 211-244. 

Dukart J, Holiga S, Rullmann M, Lanzenberger R, Hawkins PCT, Mehta MA, et al. (2020): JuSpace: A tool for spatial correlation analyses of magnetic resonance imaging data with nuclear imaging derived neurotransmitter maps. bioRxiv doi: https://doi.org/10.1101/2020.04.17.046300. 

