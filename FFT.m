function count = FFT(directory_in,directory_dataset)
    %input directory
    %directory_in=input("enter directory path of the dataset of each instrument:",'s');
    %directory_in = 'D:\Matlab\DSP project\n_data\';
    %directory_dataset =input('enter filename of the dataset file: ','s');
    %directory_dataset = "D:\Matlab\DSP project\dataset_f_test.csv";
    count = 0;
    fid = fopen( directory_dataset, 'w' );
    
    d = dir(directory_in);
    isub = [d(:).isdir];
    nameFolds = {d(isub).name}';
    nameFolds(ismember(nameFolds,{'.','..'})) = [];
    %loop thru all the files
    for i = 1:size(nameFolds)
        nums = [nameFolds{i,:}];
        s = strcat(directory_in,nums);
        
        allFiles = dir(s);
        allNames = {allFiles.name};   
        allNames(ismember(allNames,{'.','..'})) = [];
        
        [rows, columns] = size(allNames);
        
        for j = 1:columns
            
            %loop through all the audio signals
            count = count+1;
            audio_path = strcat(s,'\',[allNames{:,j}]);
            [y,Fs] = audioread(audio_path);
            y = y/abs(max(y));
            indices = find(abs(y)<0.03);
            y(indices) = [];     
            y_fft = fft(y, length(y));
            fftLength = length(y);
            freq = [0:fftLength-1].*(Fs/fftLength);
            freqsYouCareAbout = freq(freq < Fs/2);
            y_fft_YouCareAbout = abs(y_fft(1:round(fftLength/2)));
            [sort_y_fft, sortIndex] = sort(y_fft_YouCareAbout(:),'descend');
            
            %sort first 10 max frequencies
    
            maxIndex = sortIndex(1:10);
            maxFreq = freqsYouCareAbout(maxIndex);
            maxFreq(1,11) = i;
            
            %write the max frequencies in a file       
    
            dlmwrite(directory_dataset,maxFreq,'delimiter',',','-append');
        end    
    end
end