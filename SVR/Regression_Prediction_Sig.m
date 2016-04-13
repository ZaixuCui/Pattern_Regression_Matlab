
function Prediction_Sig = Regression_Prediction_Sig(Real_Prediction_Path, Rand_Prediction_Path_Cell)

load(Real_Prediction_Path);

RandomQuantity = length(Rand_Prediction_Path_Cell);
for i = 1:RandomQuantity
    i
    tmp = load(Rand_Prediction_Path_Cell{i});
    Rand_Corr(i) = tmp.Prediction.Corr;
    Rand_MAE(i) = tmp.Prediction.MAE;
end
% Corr, the bigger, the better
Corr_Sig = length(find(Rand_Corr >= Prediction.Corr)) / RandomQuantity;
% MAE, the smaller, the better
MAE_Sig = length(find(Rand_MAE <= Prediction.MAE)) / RandomQuantity;

Prediction_Sig.Corr_PValue = Corr_Sig;
Prediction_Sig.MAE_PValue = MAE_Sig;

[ResultantFolder, ~, ~] = fileparts(Real_Prediction_Path);
save([ResultantFolder filesep 'Prediction_Sig.mat'], 'Prediction_Sig');
