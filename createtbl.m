function [train,test,res] = createtbl()
    opts_1 = detectImportOptions('dataset.csv');
    opts_1.VariableNames={'A1','A2','A3','A4','A5','A6','A7','A8','A9','A10','A11','A12','A13','A14','A15'};
    opts_2 = detectImportOptions('dataset_f.csv');
    opts_2.VariableNames={'B1','B2','B3','B4','B5','B6','B7','B8','B9','B10','B11'};
    
    mfcc_dat = readtable("dataset.csv",opts_1);
    fft_dat  = readtable("dataset_f.csv",opts_2);
    mfcc_dat_test = readtable("dataset_test.csv",opts_1);
    fft_dat_test  = readtable("dataset_f_test.csv",opts_2);
    
    train = [mfcc_dat(:,1:13) fft_dat(:,1:10)];
    test = [mfcc_dat_test(:,1:13) fft_dat_test(:,1:10)];
    res = mfcc_dat(:,14);
end