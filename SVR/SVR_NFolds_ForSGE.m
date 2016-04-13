function SVR_NFolds_ForSGE(Subjects_Data_Path, Subjects_Scores, Covariates, FoldQuantity, ResultantFolder)
%
% Subject_Data:
%           m*n matrix
%           m is the number of subjects
%           n is the number of features
%
% Subject_Scores:
%           the continuous variable to be predicted
%
% ResultantFolder:
%           the path of folder storing resultant files
%
% Covariates:
%           m*n matrix
%           m is the number of subjects
%           n is the number of covariates
%
% SplitTimes: 
%           The times for split half
%

ImgData = load(Subjects_Data_Path);
FieldName = fieldnames(ImgData);

SVR_NFolds(ImgData.(FieldName{1}), Subjects_Scores, Covariates, FoldQuantity, ResultantFolder);