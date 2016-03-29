clear;
% uncomment each part and comments others for experiments

%% part a
% To create 5 pairs validation sequece I choose firt test sequence from
% ECG_TEST paried with firt 5 sequences from ECG_TRAIN

% uncomment for part a %%%
train_path = '../ECG5000_TRAIN';
test_path = '../ECG5000_TEST';
test_dataset = load(test_path);
train_dataset = load(train_path);
first_test = test_dataset(1,2:5);
sequence_table = cell(5,2);

distance_table = zeros(5,2);
for i=1:5
    sequence_table{i,1} = (first_test);
    sequence_table{i,2} = (train_dataset(i,2:5));
    % compute the ED for original sequence
    [dist, ~] = ownED(first_test,train_dataset(i,2:5),inf,0,0,0);
    distance_table(i,1) = dist;
    [dist, ~] = ownED(fft(first_test),fft(train_dataset(i,2:5)),inf,0,1,0);
    distance_table(i,2) = dist;
end
% uncomment for part a %%%


%% part b

% % uncomment for part b %%%
% % dataset a
% % train_path = '../ECG5000_TRAIN';
% % test_path = '../ECG5000_TEST';
% % dataset b
% train_path = '../NonInvasiveFatalECG_Thorax1_TRAIN';
% test_path = '../NonInvasiveFatalECG_Thorax1_TEST';
% 
% % Using fft sequence model with eraly aband and symmetry property
% sequenceType = 1;
% edMode = 1;
% symmetry_mode = 1;
% workerScript;
% % uncomment for part b %%%

%% part c

% % uncomment for part c %%%
% % dataset a
% % train_path = '../ECG5000_TRAIN';
% % test_path = '../ECG5000_TEST';
% % dataset b
% train_path = '../NonInvasiveFatalECG_Thorax1_TRAIN';
% test_path = '../NonInvasiveFatalECG_Thorax1_TEST';
% 
% % Using fft sequence model full ed_mode and symmetry property
% sequenceType = 4; % cheange to differnt mode from 2 to 4
% edMode = 0;
% symmetry_mode = 1;
% workerScript;
% % uncomment for part c %%%

%% part d
% % uncomment for part d %%%
% % dataset a
% % train_path = '../ECG5000_TRAIN';
% % test_path = '../ECG5000_TEST';
% % dataset b
% train_path = '../NonInvasiveFatalECG_Thorax1_TRAIN';
% test_path = '../NonInvasiveFatalECG_Thorax1_TEST';
% 
% % Using fft sequence model full ed_mode and not use symmetry property
% sequenceType = 4; % cheange to differnt mode from 2 to 4
% edMode = 0; %1 for part d(b) 0 for part d(c) 
% symmetry_mode = 0;
% workerScript;
% % uncomment for part d %%%