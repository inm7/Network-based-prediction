function results = RVM_LOSO(X, y, Confound, CovCateIdx, CovSiteIdx)

% This script may be used if you want to test the generalizability of your
% model across sites, as the leave-one-site-out cross-validation, when your 
% data have multiple sites, i.e., training the model on all sites but one and testing on the left-out site

%%INPUT
% X          :A matrix with n rows (observations/subjects) and d columns (features)
% y          :A vector with the dependent (continuous) variable to be predicted 
% Confound   :A matrix with confounding variables that would like to be adjusted, here both the
%             target variable and the predictors are adjusted based on the current
%             recommendations in Pervaiz et al. (2020)
% CovCateIdx  :A vector indicates which columns in your confound matrix are categorical variables, 
%              Example: CovCatIdx=[1,2]
% CovSiteIdx  :Numeric,indicating which column encodes the site in your confound matrix
%              Example: CovSiteIdx=[2]

% OUTPUT (a structure with results including performance measures)
% results.
%        AllWei: Features with Non-zero weights in Site*1 RVM predictions 
%        REach: correlation between target variable and their predicted scores for each site
%               prediction accuracy after pooling the predicted scores for all sites 
%        YPredAll: out-of-sample predicted scores
%        YTrueAll: confound-adjusted true scores

% ---References
% Pervaiz U, Vidaurre D, Woolrich MW, Smith SM (2020): Optimising network 
% modelling methods for fMRI. NeuroImage 211, 116604.

% Tipping ME (2001): Sparse Bayesian learning and the relevance vector machine. 
% J Mach Learn Res 1: 211-244.

% Chen J, Mueller VI, Dukart J, et al.(2020):Connectivity patterns of task-specific 
% brain networks allow individual prediction of cognitive symptom dimension of 
% schizophrenia and link to molecular architecture. bioRxiv 
% doi: https://doi.org/10.1101/2020.07.02.185124.

%Ji Chen, last edited on 24-Aug-2020

%% 

 YPred=nan(size(X,1),1);
 YTrue=nan(size(X,1),1);
 nowCV=Confound(:,CovSiteIdx);
 
for ith_fold=1:length(unique(nowCV))


 [perf, ypred_val,y_val,weights] = RVM_one_fold_LOSO(X, y, nowCV, ith_fold,Confound, CovCateIdx, CovSiteIdx);
 Wei=zeros(size(X,2),1);
 Wei(find(weights~=0),1)=1;
 results.AllWei(:,ith_fold)=Wei;
 
 results.REach(ith_fold,1)=perf.r_val; 
 YPred(nowCV==ith_fold,1)=ypred_val;
 YTrue(nowCV==ith_fold,1)=y_val;

end
results.RAll=corr(YPred,YTrue,'type', 'Pearson', 'Rows', 'complete');  

