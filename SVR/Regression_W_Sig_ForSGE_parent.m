
function Regression_W_Sig_ForSGE_parent(w_Brain_Path_Cell, Rand_w_Brain_Path_Cell_Path)


for i = 1:length(w_Brain_Path_Cell)
    i
    Regression_W_Sig_ForSGE(w_Brain_Path_Cell{i}, Rand_w_Brain_Path_Cell_Path);
end