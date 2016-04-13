
function SVR_Permutation(Data_Path, Score, Real_Prediction_Path, Perm_times_Range, ResultantFolder)

for i = Perm_times_Range
    i
    Rand_Index = randperm(length(Score));
    Rand_Score = Score(Rand_Index);
    ResultantFolder_Sub{i} = [ResultantFolder filesep 'time_' num2str(i)];
    mkdir(ResultantFolder_Sub{i});
    save([ResultantFolder_Sub{i} filesep 'Rand_Index.mat'], 'Rand_Index');
    save([ResultantFolder_Sub{i} filesep 'Rand_Score.mat'], 'Rand_Score');
    
    Job_Name = ['perm_' num2str(i)];
    pipeline.(Job_Name).command = 'SVR_LOOCV_ForSGE(opt.para1, opt.para2, opt.para3)';
    pipeline.(Job_Name).opt.para1 = Data_Path;
    pipeline.(Job_Name).opt.para2 = Rand_Score';
    pipeline.(Job_Name).opt.para3 = ResultantFolder_Sub{i};
    pipeline.(Job_Name).files_out.Rand_prediction = [ResultantFolder_Sub{i} filesep 'Prediction_res.mat'];
    pipeline.(Job_Name).files_out.w_Brain = [ResultantFolder_Sub{i} filesep 'w_Brain.mat'];
    
end

% Job_Name = ['Sig_test'];
% for i = Perm_times_Range
%     Perm_JobName_I = ['perm_' num2str(i)];
%     pipeline.(Job_Name).files_in.Rand_prediction{i} = pipeline.(Perm_JobName_I).files_out.Rand_prediction;
%     pipeline.(Job_Name).files_in.w_Brain{i} = pipeline.(Perm_JobName_I).files_out.w_Brain;
% end
% pipeline.(Job_Name).command = 'Regression_Prediction_Sig(opt.para1, files_in.Rand_prediction)';
% pipeline.(Job_Name).opt.para1 = Real_Prediction_Path;

Pipeline_opt.mode = 'qsub';
Pipeline_opt.qsub_options = '-q veryshort.q';
Pipeline_opt.mode_pipeline_manager = 'batch';
Pipeline_opt.max_queued = 200;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 0;
Pipeline_opt.flag_update = 1;
Pipeline_opt.path_logs = [ResultantFolder filesep 'logs'];

psom_run_pipeline(pipeline,Pipeline_opt);


