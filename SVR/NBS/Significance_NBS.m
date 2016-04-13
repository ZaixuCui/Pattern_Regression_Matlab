

% Random_P_Map = g_ls('/data/s5/cuizaixu/DATA_ShuHua_ReadingAbility/SVR_Analysis/FunctionalConn_DARTEL_Random_L512R512_NoSmooth_GlobalRegress_01/res_WLR_left_44/Permutation/Permutation_W_P/*.mat');
tmp = tril(magic(512), -1);
Index = find(tmp);

% for i = 1:length(Random_P_Map)
%     i
%     load(Random_P_Map{i});
%     Sig_Index = find(w_Brain_PValue < 0.0005);
%     Sig_Mask = zeros(size(w_Brain_PValue));
%     Sig_Mask(Sig_Index) = 1;
%     Sig_Mask_Matrix = zeros(size(tmp));
%     Sig_Mask_Matrix(Index) = Sig_Mask;
%     Sig_Mask_Matrix = Sig_Mask_Matrix + Sig_Mask_Matrix';
%     [ci_rand sizes_rand] = components(sparse(Sig_Mask_Matrix));
%     NumofEdge_rand = zeros(length(sizes_rand),1);
%     for j = 1:length(sizes_rand)
%         index_subn = find(ci_rand == j);
%         if length(index_subn) == 1
%             NumofEdge_rand(j) = 0;
%         else
%             subn = Sig_Mask_Matrix(index_subn, index_subn);
%             NumofEdge_rand(j) = sum(sum(subn))/2;
%         end
%     end
%     max_NumofEdge_rand(i) = max(NumofEdge_rand);
% end
% save max_NumofEdge_rand.mat max_NumofEdge_rand;

load /data/s5/cuizaixu/DATA_ShuHua_ReadingAbility/SVR_Analysis/FunctionalConn_DARTEL_Random_L512R512_NoSmooth_GlobalRegress_01/res_WLR_left_44/w_Brain_PValue.mat;
Sig_Index = find(w_Brain_PValue < 0.0005);
Sig_Mask = zeros(size(w_Brain_PValue));
Sig_Mask(Sig_Index) = 1;
Sig_Mask_Matrix = zeros(size(tmp));
Sig_Mask_Matrix(Index) = Sig_Mask;
Sig_Mask_Matrix = Sig_Mask_Matrix + Sig_Mask_Matrix';
[ci_real sizes_real] = components(sparse(Sig_Mask_Matrix));
NumofEdge_real = zeros(length(sizes_real),1);
num = 0;
for j = 1:length(sizes_real)
    index_subn = find(ci_real == j);
    if length(index_subn) == 1
        NumofEdge_real(j) = 0;
    else
        subn = Sig_Mask_Matrix(index_subn, index_subn);
        NumofEdge_real(j) = sum(sum(subn))/2;
        if length(find(max_NumofEdge_rand > NumofEdge_real(j))) / 10000 <= 0.05
            num = num + 1;
            SigComponent_index{num} = index_subn;
        end
    end
end
save NumofEdge_real.mat NumofEdge_real;

load /data/s5/cuizaixu/DATA_ShuHua_ReadingAbility/SVR_Analysis/FunctionalConn_DARTEL_Random_L512R512_NoSmooth_GlobalRegress_01/res_WLR_left_44/w_Brain.mat;
NBSSig_Mask = zeros(size(tmp));
Weight_Matrix = zeros(size(tmp));
Weight_Matrix(Index) = w_Brain;
Weight_Matrix = Weight_Matrix + Weight_Matrix';
for i = 1:length(SigComponent_index)
    NBSSig_Mask(SigComponent_index{i}, SigComponent_index{i}) = NBSSig_Mask(SigComponent_index{i}, SigComponent_index{i}) + ...
        Sig_Mask_Matrix(SigComponent_index{i}, SigComponent_index{i});
end
NBSSig_W = NBSSig_Mask .* Weight_Matrix;
save NBSSig_W.mat NBSSig_W;

Node_Weight = sum(NBSSig_W);
Node_Index = find(Node_Weight);
BrainNet_GenCoord('/data/s5/cuizaixu/DATA_ShuHua_ReadingAbility/GM_Atlas/Random_left_512_right_512_2/Left_512_Right_512_Template/left_512_right_512_44.nii', 'WLR_left_00005_NBS005.node', Node_Index, Node_Weight(Node_Index));

Edge_00005_NBS005 = NBSSig_W(Node_Index, Node_Index);
save WLR_left_00005_NBS005.edge Edge_00005_NBS005 -ascii;