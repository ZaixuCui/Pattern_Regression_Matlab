
Rand_w_Brain_Path_Cell = g_ls('/data/s5/cuizaixu/DATA_ShuHua_ReadingAbility/SVR_Analysis/FunctionalConn_DARTEL_Random_L512R512_NoSmooth_GlobalRegress_01/res_WLR_left_44/Permutation/Permutation_W/w_Brain*.mat');
ResultantFolder = '/data/s5/cuizaixu/DATA_ShuHua_ReadingAbility/SVR_Analysis/FunctionalConn_DARTEL_Random_L512R512_NoSmooth_GlobalRegress_01/res_WLR_left_44/Permutation/Permutation_W_200';

for i = 1:50
    disp(i);
    for j = 1:200
        Rand_W = load(Rand_w_Brain_Path_Cell{(i - 1) * 200 + j});
        Rand_W_200(j, :) = Rand_W.w_Brain;
    end
    save([ResultantFolder filesep 'Rand_W_200_' num2str(i) '.mat'], 'Rand_W_200');
    clear Rand_W_200;
end