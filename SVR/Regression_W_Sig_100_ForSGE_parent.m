
function Regression_W_Sig_100_ForSGE_parent(w_Brain_Path_Cell, Rand_w_Brain_100_Path_Cell, ResultantFolder)


for i = 1:length(w_Brain_Path_Cell)
    i
    DateNow = datevec(datenum(now));
    DateNowString = [num2str(DateNow(1)) '_' num2str(DateNow(2), '%02d') '_' num2str(DateNow(3), '%02d') '_' num2str(DateNow(4), '%02d') '_' num2str(DateNow(5), '%02d')];
    disp(DateNowString);
    Regression_W_Sig_100_ForSGE(w_Brain_Path_Cell{i}, Rand_w_Brain_100_Path_Cell, ResultantFolder);
end