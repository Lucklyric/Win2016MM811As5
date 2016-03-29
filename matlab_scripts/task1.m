clear;
%% part a
train_path = '../ECG5000_TRAIN';
test_path = '../ECG5000_TEST';

%% part b
% train_path = '../NonInvasiveFatalECG_Thorax1_TRAIN';
% test_path = '../NonInvasiveFatalECG_Thorax1_TEST';

% original sequence with full ed_mode 
sequenceType = 0;
edMode = 0;
symmetry_mode = 0;

workerScript;

