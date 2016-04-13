function [Prediction w_Brain] = SVR_NFolds_Avg(Prediction_Cell, ResultantFolder)
%
% Prediction_Cell:
%     Cell of path of .mat file
%     .mat file with variable name 'Prediction'
%     Prediction.Corr
%     Prediction.MAE
%     Prediction.w_Brain
%

Tmp = load(Prediction_Cell{1});
Corr = Tmp.Prediction.Corr;
MAE = Tmp.Prediction.MAE;
w_Brain = Tmp.Prediction.w_Brain;

for i = 2:length(Prediction_Cell)
    Tmp = load(Prediction_Cell{i});
    Corr = Corr + Tmp.Prediction.Corr;
    MAE = MAE + Tmp.Prediction.MAE;
    w_Brain = w_Brain + Tmp.Prediction.w_Brain;
end

Prediction.Corr = Corr / length(Prediction_Cell);
Prediction.MAE = MAE / length(Prediction_Cell);
w_Brain = w_Brain / length(Prediction_Cell);
save([ResultantFolder filesep 'Prediction.mat'], 'Prediction');
save([ResultantFolder filesep 'w_Brain.mat'], 'w_Brain');


