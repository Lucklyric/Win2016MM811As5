%% Main worker script
% Setting has been defined before call this script

% Load data from disk
test_dataset = load(test_path);
train_dataset = load(train_path);
test_length = length(test_dataset);
train_length = length(train_dataset);
% A vector store all classified labes
classifier_label = zeros(1,test_length);
ed_time_cost = zeros(1,test_length*train_length);
% For each entry in test data find 1-NN
for i = 1:test_length;
    min_distance = inf;
    label = -1;
    test_feature = test_dataset(i,2:end);
    for j = 1:train_length
        train_feature = train_dataset(j,2:end);
        
        if sequenceType == 0
            % original sequence
            tic;
            [dist, check] = ownED(test_feature,train_feature,min_distance,edMode,sequenceType,symmetry_mode);
            ed_time_cost(1,(i-1)*train_length+j) = toc;
        else
            % dft sequence
            fft_test_feature = fft(test_feature);
            fft_train_feature = fft(train_feature);
            
            % tic time
            tic;
            [dist, check] = ownED(fft_test_feature,fft_train_feature,min_distance,edMode,sequenceType,symmetry_mode);
            ed_time_cost(1,(i-1)*train_length+j) = toc;
        end
        
        % check if new ed is smallest
        if check == true
            min_distance = dist;
            label = train_dataset(j,1);
        end
    end
    fprintf('classified:%d\n',i);
    classifier_label(i) = label;
end
% print out the result
num_correct = length(find(classifier_label == test_dataset(:,1)'));
fprintf('accuracy = %d/%d = %.2f%%\n',num_correct,test_length,100*num_correct/test_length);
mean_ed_time = mean(ed_time_cost);
std_ed_time = std(ed_time_cost);
fprintf('mean = %f\n',mean_ed_time*1000);
fprintf('standard deviation = %f\n',std_ed_time*1000);


