function [perf,ypred_val,y_val,weights] = RVM_one_fold_LOSO(x, y, cv_ind, fold, confounds, CovCateIdx, CovSiteIdx)

%
% This function runs RVM for one cross-validation fold. The
% relationship between features and targets is assumed to be 
% y = x * weights + b.
%
% INPUT:
%       - x       : NxF matrix containing F features from N subjects
%       - y       : Nx1 matrix containing the target values from N subjects
%       - cv_ind  : Nx1 matrix containing cross-validation fold assignment
%                   for N subjects. Values should range from 1 to the total number 
%                   of sites for a leave-one-site-out cross-validation                
%       - fold    : Fold to be used as validation set   
%       -confounds: NxD matrix containing D confounds for N subjects.

% OUTPUT:
%       - r_val  :Pearson correlation between predicted target values and
%                 actual target values in validation set              
%       - weights:Fx1 matrix containing weights of the F features                
%
%
% ------  Ji Chen, last edited on 24-Aug-2020


x_val = x(cv_ind == fold, :);
y_val = y(cv_ind == fold);
x_train=x(cv_ind~=fold,:);
y_train=y(cv_ind~=fold);
TrainInd=find(cv_ind~=fold);
ValInd=find(cv_ind==fold);

NumCov=1:size(confounds,2);
NumCov(:,CovSiteIdx)=[];
CovCate=intersect(NumCov,CovCateIdx);
if CovCate>CovSiteIdx
    CovCate=CovCate-1;
end
%confounds(:,CovSiteIdx)=[];
DesignMatrixAll=x2fx(confounds(:,NumCov), 'linear',CovCate);
DesignMatrixAllTr=x2fx(confounds(TrainInd, :), 'linear',CovCateIdx);

% confound regression
[y_train2, reg_y] = regress_confounds(y_train, ...
    DesignMatrixAllTr);
[~,reg_y1] = regress_confounds(y_train, ...
    DesignMatrixAll(TrainInd, :));
[y_val,~] = regress_confounds(y_val, DesignMatrixAll(ValInd, :), reg_y1);

[x_train2, reg_x] = regress_confounds(x_train, ...
    DesignMatrixAllTr);
[~, reg_x1] = regress_confounds(x_train, ...
    DesignMatrixAll(TrainInd, :));
x_val = regress_confounds(x_val, DesignMatrixAll(ValInd, :), reg_x1);


[nn,d]=size(x_train);
[model.rvm, model.hyperparams, model.diagnostics] = SparseBayes('Gaussian', [x_train2, ones(nn,1)], y_train2);

   model.weights = zeros(d,1);

   model.b = 0;
   if model.rvm.Relevant(end)==(d+1) 
     model.b = model.rvm.Value(end);
     model.weights(model.rvm.Relevant(1:end-1)) = model.rvm.Value(1:end-1);
   else
     model.weights(model.rvm.Relevant) = model.rvm.Value;
   end 
   weights=model.weights;
   ypred_val = x_val*model.weights + model.b;  

perf.r_val = corr(y_val, ypred_val, 'type', 'Pearson', 'Rows', 'complete');





