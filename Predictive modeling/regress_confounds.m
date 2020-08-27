function [var, reg] = regress_confounds(var, DesignMatrix, existing_reg)
% 

% This function regresses out confounds from prediction targets y and features X. 
% For training data, pass in y or X and the DesignMatrix for the confounds (generated from 
% the Matlab x2fx function) to perform regression, obtaining the new y or X and the 
% regression coefficients reg. For validation data, also pass in the regression coefficients 
% obtained from the training data. Basically, regression coefficients should be estimated 
% using only training data, and applied to both training and validation data.
%
% Inputs:
%       - var           :
%                      A Nx1 matrix containing the target values from N
%                      subjects or a NxF matrix containing F features from N    
%
%       - DesignMatrix   :
%                      The design matix of the matrix of confounds generated from the x2fx 
%                      function for regression
%
%       - existing_reg:
%                      (Optional) Existing regression coefficients to use
%                      for regressing out confounds in validation set.
%
% Output:
%        - var    :
%                A vector containing the target values or a matrix containing the features with
%                confounds removed
%        - reg:
%                A cell containing the regression coefficient for
%                each confound and for each target variable y or feature X. The first row of the 
%                column array within a cell correspond to the offset, i.e. a confound of constant 1.
%
% Example:
% 1) [y_train, reg_y] = regress_confounds(y_train, confounds)
%    This command regresses out confounds from the training targets (y), also
%    returning the regression coefficients
% 2) y_val = regress_confounds_y (y_val, confounds, reg_y)
%    This command regresses out confounds from the validation targets,
%    using the regression coefficients previously determined based on
%    training data
%
% ---References:
% Snoek L, Mileti? S, Scholte HS (2019): How to control for confounds in decoding analyses of neuroimaging data. NeuroImage 184: 741-760
%
% More S, Eickhoff SB, Julian C, Patil, KR (2020): Confound Removal and Normalization in Practice: A Neuroimaging Based Sex Prediction Case Study. 
% Preprint available at https://juser.fz-juelich.de/record/877721; Accepted in the European Conference on Machine Learning and Principles and Practice 
% of Knowledge Discovery in Databases (ECML PKDD; https://ecmlpkdd2020.net/programme/accepted/#ADSTab).
%
%
% Ji Chen, last edited on 24-Aug-2020

% set up
t = size(var, 2);
n = size(var, 1);

reg=cell(t);varhat=nan(n,t);
% perform regression
if nargin < 3
    % for training set

    reg=cell(t,1);
    for target = 1:t
        [reg{target}, ~, var(:, target)] = regress(var(:,target), DesignMatrix);
    end
else
    % for validation set

    
    for ith_col=1:t
    for nn=1:n
     varhat(nn,ith_col) =  sum(existing_reg{ith_col}'.*DesignMatrix(nn,:));
    end
    end
     var=var-varhat;
end
   
    
end
