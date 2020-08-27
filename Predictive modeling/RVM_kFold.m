function results = RVM_kFold(X, y, cvarg, Confound, CovCateIdx, CovSiteIdx)

%%INPUT
% X          : A matrix with n rows (observations/subjects) and d columns (features)
% y          : A vector with the dependent (continuous) variable to be predicted 
% cvarg      : A structure defines number of folds and repelications; default:numRep=500; numFold=10 
% Confound   : A matrix with confounding variables that would like to be adjusted, here both the
%              dependent variable and the predictors are adjusted according to the current
%              recommendations in Pervaiz et al. (2020)
%              Numbering the site column, if there is only one site, just put ones 
% CovCateIdx : A vector indicates which columns in your confound matrix are categorical variables, 
%              Example: CovCatIdx=[1,2]
% CovSiteIdx  :Numeric,indicating which column encodes the site in your confound matrix
%              Example: CovSiteIdx=[2]
% 
%
% OUTPUT (a structure with results including performance measures)
% results.
%        AllWei: Features with Non-zero weights in nFold*nRepeat RVM predictions 
%        R: correlation between target variable and their predicted scores
%        YPredAll: out-of-sample predicted scores
%        YTrueAll: confound-adjusted true scores

%EXAMPLE USAGE
% iris = load('fisheriris.mat');
% X = iris.meas(:,1:2);
% y = iris.meas(:,3);
% Confound = iris.meas(:,4);
% Add the site index column to Confound: Confound(:,2)=ones; 
% cvarg = [];
% cvarg.NumFolds = 100;
% cvarg.NumRepeats = 10;
% CovCateIdx = [2];
% CovSiteIdx = [2];
% results = RVM_10Fold_Ji(X, y, cvarg, Confound, CovCateIdx, CovSiteIdx)

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
%


if ~isempty(cvarg.NumRepeats)   
    numRep=cvarg.NumRepeats;
else
    numRep=500;
end

if ~isempty(cvarg.NumFolds)   
    numFold=cvarg.NumFolds;
else
    numFold=10;
end

if unique (Confound(:,CovSiteIdx))~=1
%if multiple sites, the folds are stritified by site   
CVindices=nan(size(y,1),numRep);
CV=Confound(:,CovSiteIdx);
sites = unique(CV); 
  indices = {};
  for i=1:length(sites)
      indices{i} = find(CV==sites(i));
  end

for ith_repeat = 1:numRep
  for i=1:length(sites)
      ind = indices{i};
      ith_partition = cvpartition(length(ind),'KFold',numFold);
      for ith_fold=1:numFold
          j = ith_partition.test(ith_fold);
          CVindices(ind(j),ith_repeat) = ith_fold;
      end
  end
end

else
     CVindices = cross_validation_partition(y, numFold, numRep);
end

%% True accuracy 
for ith_repeat=1:numRep
 YPred=nan(size(X,1),1);
 YTrue=nan(size(X,1),1);
 nowCV=CVindices(:,ith_repeat);
   for ith_fold=1:numFold

 [perf, ypred_val,y_val,Weight] = RVM_one_fold_weights(X, y, nowCV, ith_fold, Confound, CovCateIdx);
 
 Wei=zeros(size(X,2),1);
 Wei(find(Weight~=0),1)=1;
 nZW(:,ith_fold)=Wei;

 results.RAll(ith_fold,ith_repeat)=perf.r_val;
 YPred(nowCV==ith_fold,1)=ypred_val;
 YTrue(nowCV==ith_fold,1)=y_val;
   end
results.AllWei{ith_repeat} = nZW;
results.R(:,ith_repeat)=corr(YPred,YTrue,'type', 'Pearson', 'Rows', 'complete');
results.YPredAll(:,ith_repeat)=YPred;
results.YTrueAll(:,ith_repeat)=YTrue;
end