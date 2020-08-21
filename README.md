# Network-based-prediction

The density maps of receptors/transporters from prior molecular imaging studies are already publicly available in the “JuSpace” toolbox which can be freely downloaded from the website at https://github.com/juryxy/JuSpace. JuSpace is a comprehensive Matlab-based toolbox for the integration of PET- and SPECT- derived modalities with other brain imaging data (Dukart et al., 2020). 

For the meta-analytic networks, the coordinates used for generating the nodes have been reported in the source meta-analytic publications, but to facilitate re-use, we now provide text files containing the peak-activation coordinates for each of the 17 employed networks as well as the NIFTI images denoting the node-locations

We employed a relevance vector machine (RVM) (23) as implemented in the SparseBayes package (http://www.miketipping.com/index.htm) to achieve multivariable regression so that continuous target variables can be predicted based on set of features (i.e., exploratory variables). The RVM refers to a specialization of the general Bayesian framework which has an identical functional form to the support vector machine (SVM) (24)
Sparsity can be achieved in RVM through sparse modeling with no additional penalty terms needed to shrink the predictor coefficients as the posterior distributions of many of the estimated weights are already towards zero.
