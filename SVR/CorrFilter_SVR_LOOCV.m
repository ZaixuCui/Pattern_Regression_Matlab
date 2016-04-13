function Prediction = CorrFilter_SVR_LOOCV(Subjects_Data, Subjects_Scores, CoefThreshold, ResultantFolder)
%
% Subject_Data:
%           m*n matrix
%           m is the number of subjects
%           n is the number of features
%
% Subject_Scores:
%           the continuous variable to be predicted
%
% Pre_Method:
%           'Normalize' or 'Scale'
%
% ResultantFolder:
%           the path of folder storing resultant files
%

if nargin >= 4
    if ~exist(ResultantFolder, 'dir')
        mkdir(ResultantFolder);
    end
end

[Subjects_Quantity, Feature_Quantity] = size(Subjects_Data);

Feature_Frequency = zeros(1, Feature_Quantity);
for i = 1:Subjects_Quantity
    
    disp(['The ' num2str(i) ' iteration!']);
    
    Training_data = Subjects_Data;
    Training_scores = Subjects_Scores;
    
    % Select training data and testing data
    test_data = Training_data(i, :);
    test_score = Training_scores(i);
    Training_data(i, :) = [];
    Training_scores(i) = [];

    coef = corr(Training_data, Training_scores');
    coef(find(isnan(coef))) = 0;
    RetainID{i} = find(abs(coef) > CoefThreshold);
    Training_data_New = Training_data(:, RetainID{i});
    Selected_Mask = zeros(1, Feature_Quantity);
    Selected_Mask(RetainID{i}) = 1;
    Feature_Frequency = Feature_Frequency + Selected_Mask;
    
    % Normalizing
    if strcmp(Pre_Method, 'Normalize')
        % Normalizing
        MeanValue = mean(Training_data_New);
        StandardDeviation = std(Training_data_New);
        [~, columns_quantity] = size(Training_data_New);
        for j = 1:columns_quantity
            Training_data_New(:, j) = (Training_data_New(:, j) - MeanValue(j)) / StandardDeviation(j);
        end
    elseif strcmp(Pre_Method, 'Scale')
        % Scaling to [0 1]
        MinValue = min(Training_data_New);
        MaxValue = max(Training_data_New);
        [~, columns_quantity] = size(Training_data_New);
        for j = 1:columns_quantity
            Training_data_New(:, j) = (Training_data_New(:, j) - MinValue(j)) / (MaxValue(j) - MinValue(j));
        end
    end

    % SVR training
    Training_scores = Training_scores';
    Training_data_New = double(Training_data_New);
    model(i) = svmtrain(Training_scores, Training_data_New,'-s 3 -t 2');
    
    test_data_New = test_data(:, RetainID{i});
    % Normalizing
    if strcmp(Pre_Method, 'Normalize')
        % Normalizing
        test_data_New = (test_data_New - MeanValue) ./ StandardDeviation;
    elseif strcmp(Pre_Method, 'Scale')
        % Scale
        test_data_New = (test_data_New - MinValue) ./ (MaxValue - MinValue);
    end

    % predicts
    test_data_New = double(test_data_New);
    [Predicted_Scores(i), ~, ~] = svmpredict(test_score, test_data_New, model(i));
    
end
Prediction.Score = Predicted_Scores;
[Prediction.Corr, ~] = corr(Predicted_Scores', Subjects_Scores');
Prediction.MAE = mean(abs((Predicted_Scores - Subjects_Scores)));
Prediction.Feature_Frequency = Feature_Frequency;
if nargin >= 4
    save([ResultantFolder filesep 'Prediction_res.mat'], 'Prediction');
    disp(['The correlation is ' num2str(Prediction.Corr)]);
    disp(['The MSE is ' num2str(Prediction.MAE)]);
end

