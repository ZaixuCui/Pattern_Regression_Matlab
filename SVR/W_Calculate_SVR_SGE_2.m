
function W_Calculate_SVR_SGE_2(Subjects_Data_Path, Subjects_Scores, i, ResultantFolder)

tmp = load(Subjects_Data_Path);
FieldName = fieldnames(tmp);
Rand_Index = randperm(length(Subjects_Scores));
Rand_Scores = Subjects_Scores(Rand_Index);
[w_Brain, ~] = W_Calculate_SVR(tmp.(FieldName{1}), Rand_Scores);
save([ResultantFolder filesep 'w_Brain_' num2str(i) '.mat'], 'w_Brain');