
function w_Brain_PValue = Regression_W_Sig_ForSGE(w_Brain_Path, Rand_w_Brain_Path_Cell_Path)

%
% w_Brain_Path:
%     The full path of .mat file contain w_Brain to be converted to p map
%
% Rand_w_Brain_Path_Cell_Path:
%     The full path of .mat file contain the paths of rand w_brain
%

load(w_Brain_Path);
load(Rand_w_Brain_Path_Cell_Path);

RandomQuantity = length(Rand_w_Brain_Path_Cell);
w_Brain_PValue = zeros(1, length(w_Brain));

for i = 1:RandomQuantity
    if ~mod(i, 1000)
        disp(i);
    end
    Rand_W = load(Rand_w_Brain_Path_Cell{i});

    Compare_w = abs(Rand_W.w_Brain) - abs(w_Brain);
    Compare_w(find(Compare_w >= 0)) = 1;
    Compare_w(find(Compare_w < 0)) = 0;
    w_Brain_PValue = w_Brain_PValue + Compare_w;
end
w_Brain_PValue = w_Brain_PValue / RandomQuantity;

[ResultantFolder, FileName, ~] = fileparts(w_Brain_Path);
save([ResultantFolder filesep FileName '_PValue.mat'], 'w_Brain_PValue');