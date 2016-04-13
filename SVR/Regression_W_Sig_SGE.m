
function Regression_W_Sig_SGE(w_Brain_Path_Cell, Rand_w_Brain_Path_Cell_Path, Queue)

TaskQuantity = 100;
JobsPerTask = fix(length(w_Brain_Path_Cell) / TaskQuantity);
JobsRemain = mod(length(w_Brain_Path_Cell), TaskQuantity * JobsPerTask);

for i = 1:100
    w_Brain_Path_Cell_Sub = w_Brain_Path_Cell([(i - 1) * JobsPerTask + 1 : i * JobsPerTask]);
    if i == 100 & JobsRemain
        w_Brain_Path_Cell_Sub = [w_Brain_Path_Cell_Sub; w_Brain_Path_Cell_Sub(length(Perm_times_Range) - JobsRemain + 1 : end)];
    end
    Job_Name = ['perm_w2p_' num2str(i)];
    pipeline.(Job_Name).command = 'Regression_W_Sig_ForSGE_parent(opt.para1, opt.para2)';
    pipeline.(Job_Name).opt.para1 = w_Brain_Path_Cell_Sub;
    pipeline.(Job_Name).opt.para2 = Rand_w_Brain_Path_Cell_Path;
end

Pipeline_opt.mode = 'qsub';
Pipeline_opt.qsub_options = Queue;
Pipeline_opt.mode_pipeline_manager = 'batch';
Pipeline_opt.max_queued = 100;
Pipeline_opt.flag_verbose = 1;
Pipeline_opt.flag_pause = 0;
Pipeline_opt.flag_update = 1;
Pipeline_opt.path_logs = [pwd filesep 'logs'];

psom_run_pipeline(pipeline,Pipeline_opt);
