
function w_Brain_PValue = Regression_W_Sig_MaximumStatistics(Real_w_Brain_Path, Rand_w_Brain_Path_Cell)

Original_W = load(Real_w_Brain_Path);
Original_w_Brain_Matrix = repmat(abs(Original_W.w_Brain), length(Rand_w_Brain_Path_Cell), 1);

RandomQuantity = length(Rand_w_Brain_Path_Cell);
w_Brain_PValue = zeros(1, length(Original_W.w_Brain));
for i = 1:RandomQuantity
    i
    Rand_W = load(Rand_w_Brain_Path_Cell{i});
    Rand_W_Maximum(i) = max(abs(Rand_W.w_Brain));
end
Rand_W_Maximum_Matrix = repmat(Rand_W_Maximum', 1, length(Original_W.w_Brain));

Compare_W = Rand_W_Maximum_Matrix - Original_w_Brain_Matrix;
Compare_W(find(Compare_W >= 0)) = 1;
Compare_W(find(Compare_W < 0)) = 0;
Compare_W_Sum = sum(Compare_W);
w_Brain_PValue = Compare_W_Sum / RandomQuantity;

[ResultantFolder, ~, ~] = fileparts(Real_w_Brain_Path);
save([ResultantFolder filesep 'w_Brain_PValue_MaximumStatistics.mat'], 'w_Brain_PValue');