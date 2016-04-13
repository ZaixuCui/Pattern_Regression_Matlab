
function SVR_LOOCV_ForSGE(Subjects_Data_Path, Subjects_Scores, ResultantFolder)

Subjects_Data = load(Subjects_Data_Path);
FieldName = fieldnames(Subjects_Data);
SVR_LOOCV(Subjects_Data.(FieldName{1}), Subjects_Scores, [], ResultantFolder);