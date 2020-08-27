function results = RVM_Validation(X,y, Confound, GroupIdx, CovCateIdx, CovSiteIdx)

% For validation analysis: assuming you have two independent datasets,
% then you train a RVM model within one dataset and then apply it to the
% other dataset for validation. The training and the validation datasets
% used for this analysis should have the same number of features and confounds 
% X          :A matrix with n rows (observations/subjects) and d columns
%            (features) for both the training and the validation datasets 
% y          :A vector with the dependent (continuous) variable to be predicted for both the datasets 
% GroupIdx   :A numeric column array indexing which subjects are the training
%             sample and which are from the validation dataset
%             Example: GroupIdx=[1;1;1;1;1;2;2;2;2;2]; 
% Confound   :A matrix with confounding variables that would like to be adjusted, here both the
%             dependent variable and the predictors are adjusted according to the current
%             recommendations in Pervaiz et al. (2020)
% CovCateIdx :A vector indicates which columns in your confound matrix are categorical variables, 
%             Example: CovCatIdx=[1,2]
% CovSiteIdx :Numeric,indicating which column encodes the site in your confound matrix
%             Example: CovSiteIdx=[2]

% OUTPUT (a structure with results including performance measures)
% results.
%        Wei: Features with Non-zero weights in the trained RVM model
%        R & P: correlation coefficient between target variable and their
%        predicted scores as well as the p value
%        YPred: out-of-sample predicted scores
%        YTrue: confound-adjusted true scores

prompt = {'Enter a number you encode the training sample in "GroupIdx"'};
dlgtitle = 'GroupIndex';
TrainNum = inputdlg(prompt,dlgtitle);

prompt = {'Enter a number you encode the independent validation sample in "GroupIdx"'};
dlgtitle = 'GroupIndex';
ValNum = inputdlg(prompt,dlgtitle);
TrainIdx=GroupIdx==str2num(TrainNum{1});
ValIdx=GroupIdx==str2num(ValNum{1});
XTrain=X(TrainIdx,:);
XVal=X(ValIdx,:);
yTrain=y(TrainIdx,:);
yVal=y(ValIdx,:);
ConfoundTr=Confound(TrainIdx,:);
ConfoundVal=Confound(ValIdx,:);

DesignMatrix1=x2fx(ConfoundTr, 'linear',CovCateIdx);
[y_train, reg_y] = regress_confounds(yTrain, ...
    DesignMatrix1);
[x_train, reg_x] = regress_confounds(XTrain, ...
    DesignMatrix1);
[nn,d]=size(x_train);
[model.rvm, model.hyperparams, model.diagnostics] = SparseBayes('Gaussian', [x_train, ones(nn,1)], y_train);

   model.weights = zeros(d,1);

   model.b = 0;
   if model.rvm.Relevant(end)==(d+1) 
     model.b = model.rvm.Value(end);
     model.weights(model.rvm.Relevant(1:end-1)) = model.rvm.Value(1:end-1);
   else
     model.weights(model.rvm.Relevant) = model.rvm.Value;
   end 
   results.Wei=model.weights;

NumCov=1:size(ConfoundTr,2);
NumCov(:,CovSiteIdx)=[];
CovCate=intersect(NumCov,CovCateIdx);
if CovCate>CovSiteIdx
    CovCate=CovCate-1;
end
ConfoundTr(:,CovSiteIdx)=[];
DesignMatrix2=x2fx(ConfoundTr, 'linear',CovCate);
[~, reg_y1] = regress_confounds(yTrain, ...
    DesignMatrix2);
[~, reg_x1] = regress_confounds(XTrain, ...
    DesignMatrix2);

if unique(ConfoundVal(:,CovSiteIdx))~=1
DesignMatrixVal=x2fx(ConfoundVal(:,CovSiteIdx), 'linear',1);
[y_val, ~] = regress_confounds(yVal, ...
    DesignMatrixVal);
[x_val, ~] = regress_confounds(XVal, ...
    DesignMatrixVal);
else
    y_val=yVal;
    x_val=XVal;
end
ConfoundVal(:,CovSiteIdx)=[];
[y_val,~] = regress_confounds(y_val, x2fx(ConfoundVal, 'linear'), reg_y1);
x_val = regress_confounds(x_val,  x2fx(ConfoundVal, 'linear'), reg_x1);

ypred_val = x_val*model.weights + model.b; 

results.YPred=ypred_val;
results.YTrue=y_val;
[results.R,results.P]=corr(ypred_val,y_val, 'type', 'Pearson', 'Rows', 'complete');


