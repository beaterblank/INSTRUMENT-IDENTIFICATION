    function [svm,lr,la,ri] = MAIN(snr)
    warning off;
    NoiseAdd(snr);
    MFCC("D:\Matlab\DSP project\n_data\","D:\Matlab\DSP project\dataset_test.csv");
    FFT("D:\Matlab\DSP project\n_data\","D:\Matlab\DSP project\dataset_f_test.csv");
    svm = SVM();
    lr = LR();
    la = LASSO();
    ri = RIDGE();
end