
function w_Brain_PValue = Regression_W_Sig_100_ForSGE(Real_w_Brain_Path, Rand_w_Brain_100_Path_Cell, ResultantFolder)

load(Real_w_Brain_Path);
w_Brain_100 = repmat(w_Brain, 100, 1);
 
RandomQuantity = length(Rand_w_Brain_100_Path_Cell);
w_Brain_PValue = zeros(1, length(w_Brain));
 
for i = 1:RandomQuantity
    Rand_W = load(Rand_w_Brain_100_Path_Cell{i});
 
    Compare_w = abs(Rand_W.Rand_W_100) - abs(w_Brain_100);
    Compare_w(find(Compare_w >= 0)) = 1;
    Compare_w(find(Compare_w < 0)) = 0;
    w_Brain_PValue = w_Brain_PValue + sum(Compare_w);
end
w_Brain_PValue = w_Brain_PValue / (RandomQuantity * 100);
 
[~, FileName, ~] = fileparts(Real_w_Brain_Path);
save([ResultantFolder filesep FileName '_PValue.mat'], 'w_Brain_PValue');
