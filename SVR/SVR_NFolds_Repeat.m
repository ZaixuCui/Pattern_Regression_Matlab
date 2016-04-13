function Prediction = SVR_NFolds_Repeat(Subjects_Data_Path, Subjects_Scores, Covariates, FoldQuantity, RepetitionTimes, ResultantFolder, QsubOption)
%
% Subject_Data_Path:
%           The path of .mat file which contans m*n matrix
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
% RepetitionTimes:
%           The repetition times for spliting N folds
%

if ~exist(ResultantFolder, 'dir')
    mkdir(ResultantFolder);
end

for i = 1:RepetitionTimes
    Sub_ResFolder = [ResultantFolder filesep 'EachTime/res_' num2str(i)];
    mkdir(Sub_ResFolder);
    Job_Name = ['Repetition_' num2str(i)];
    pipeline.(Job_Name).command = 'SVR_NFolds_ForSGE(opt.parameters1, opt.parameters2, opt.parameters3, opt.parameters4, opt.parameters5)';
    pipeline.(Job_Name).opt.parameters1   = Subjects_Data_Path;
    pipeline.(Job_Name).opt.parameters2   = Subjects_Scores;
    pipeline.(Job_Name).opt.parameters3   = Covariates;
    pipeline.(Job_Name).opt.parameters4   = FoldQuantity;
    pipeline.(Job_Name).opt.parameters5   = Sub_ResFolder;
    pipeline.(Job_Name).files_out{1} = [Sub_ResFolder filesep 'Prediction.mat'];
end

Job_Name = ['Average'];
pipeline.(Job_Name).command = 'SVR_NFolds_Avg(files_in, opt.parameter1)';
for i = 1:RepetitionTimes    
    Job_Name_I = ['Repetition_' num2str(i)];
    pipeline.(Job_Name).files_in{i} = pipeline.(Job_Name_I).files_out{1};
end
pipeline.(Job_Name).opt.parameter1   = ResultantFolder;

Pipeline_opt.mode = 'qsub';
Pipeline_opt.qsub_options = QsubOption;
Pipeline_opt.mode_pipeline_manager = 'batch';
Pipeline_opt.max_queued = 200;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 0;
Pipeline_opt.flag_update = 1;
Pipeline_opt.path_logs = [ResultantFolder filesep 'logs'];

psom_run_pipeline(pipeline,Pipeline_opt);