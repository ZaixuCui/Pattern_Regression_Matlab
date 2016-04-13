
function W_Calculate_SVR_SGE(Subjects_Data_Path, Rand_Scores, ID, ResultantFolder)

tmp = load(Subjects_Data_Path);
FieldName = fieldnames(tmp);

for i = 1:length(ID)
    disp(ID(i));
    [w_Brain, ~] = W_Calculate_SVR(tmp.(FieldName{1}), Rand_Scores{i});
    save([ResultantFolder filesep 'w_Brain_' num2str(ID(i)) '.mat'], 'w_Brain');
end