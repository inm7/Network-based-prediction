function CVindices = cross_validation_partition(y, k, m)

% generate random (i.e., non-stratified) cross validation partition(s)
% y : dependent variable to be predicted 
% k : number of folds
% m : number of repeats
% CVindices: a matrix with partitions, each column is one CV
% with each entry as id of the fold

% lasted edited by Ji Chen 24-Aug-2020

switch nargin
    case 0
        error('give me y')
    case 1
        k=10; m=10; 
    case 2
        m=10; 
end

n = length(y);
CVindices = nan(n,m);
% get the corss-validation indices
for ith_repeat = 1:m
  ith_partition = cvpartition(n,'KFold',k);
  for ith_fold=1:k
    j = ith_partition.test(ith_fold);
    CVindices(j,ith_repeat) = ith_fold;
  end
end 

