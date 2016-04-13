
RandW_Cell = g_ls('/data/s5/cuizaixu/DATA_ShuHua_ReadingAbility/SVR_Analysis/FunctionalConn_DARTEL_Random_L512R512_NoSmooth_GlobalRegress_01/res_WLR_left_44/Permutation/Permutation_W/*.mat');
RandMerge100_Cell = g_ls('/data/s5/cuizaixu/DATA_ShuHua_ReadingAbility/SVR_Analysis/FunctionalConn_DARTEL_Random_L512R512_NoSmooth_GlobalRegress_01/res_WLR_left_44/Permutation/Permutation_W_Merge100/*.mat');
ResultantFolder = '/data/s5/cuizaixu/DATA_ShuHua_ReadingAbility/SVR_Analysis/FunctionalConn_DARTEL_Random_L512R512_NoSmooth_GlobalRegress_01/res_WLR_left_44/Permutation/Permutation_W_P_2';
Regression_W_Sig_100_SGE(RandW_Cell([1:5000]), RandMerge100_Cell, ResultantFolder, '-q veryshort.q')