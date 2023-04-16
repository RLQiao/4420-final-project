%% 4420 Final Project
filenames = ["Subject_1.mat", "Subject_2.mat", "Subject_3.mat", "Subject_4.mat", ...
             "Subject_5.mat", "Subject_6.mat", "Subject_7.mat", "Subject_8.mat"];
num_subject = 1;
n_test = zeros(1,num_subject);
n_train = zeros(1,num_subject);
n_trials = zeros(1,num_subject);

for i = 1:8
    filepath = sprintf('/Users/joannaq/Desktop/Spring 23/4420/final project/Signal_Processing_FC/%s', filenames(i));
    data_struct = load(filepath);
    n_test(i) = data_struct.n_TEST;
    n_train(i) = data_struct.n_TRAIN;
    n_trials(i) = data_struct.nTrial;
    train_data = preprocess(data_struct.X_EEG_TRAIN);
    test_data = preprocess(data_struct.X_EEG_TEST);
    train_label = data_struct.Y_EEG_TRAIN;
    save_filepath = sprintf('/Users/joannaq/Desktop/Spring 23/4420/final project/preprocessed_data/%s', filenames(i));
    save(save_filepath, "train_data", "test_data", "train_label");
end

function EEG = preprocess(data)
    eeglab redraw;
    EEG = pop_importdata('dataformat','array','nbchan',60,'data', data,'srate',1000, ...
                         'chanlocs', '/Users/joannaq/Desktop/Spring 23/4420/final project/Signal_Processing_FC/standard60.loc');
    EEG = pop_eegfiltnew(EEG, 'locutoff',0.5,'hicutoff',40); % 0.5-40 bandpass filter
end