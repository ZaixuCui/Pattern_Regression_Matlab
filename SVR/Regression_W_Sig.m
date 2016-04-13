
function w_Brain_PValue = Regression_W_Sig(Real_w_Brain_Path, Rand_w_Brain_Path_Cell)

Original_W = load(Real_w_Brain_Path);

RandomQuantity = length(Rand_w_Brain_Path_Cell);
w_Brain_PValue = zeros(1, length(Original_W.w_Brain));
for i = 1:RandomQuantity
    i
    Rand_W = load(Rand_w_Brain_Path_Cell{i});

    Compare_w = abs(Rand_W.w_Brain) - abs(Original_W.w_Brain);
    Compare_w(find(Compare_w >= 0)) = 1;
    Compare_w(find(Compare_w < 0)) = 0;
    w_Brain_PValue = w_Brain_PValue + Compare_w;
end
w_Brain_PValue = w_Brain_PValue / RandomQuantity;

[ResultantFolder, ~, ~] = fileparts(Real_w_Brain_Path);
save([ResultantFolder filesep 'w_Brain_PValue.mat'], 'w_Brain_PValue');