
function W_Calculate_SVR_SGE_3(Subjects_Data_Path, Subjects_Scores_rand, i, ResultantFolder)

tmp = load(Subjects_Data_Path);
FieldName = fieldnames(tmp);

[w_Brain, ~] = W_Calculate_SVR(tmp.(FieldName{1}), Subjects_Scores_rand);
save([ResultantFolder filesep 'w_Brain_' num2str(i) '.mat'], 'w_Brain');