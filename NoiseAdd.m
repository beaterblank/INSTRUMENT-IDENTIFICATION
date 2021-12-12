function count = NoiseAdd(snr)

    count = 0 ;
    
    %directory_in=input('enter directory path of the dataset of each instrument: ','s');
    directory_in = 'D:\Matlab\DSP project\data\';
    
    %directory_noisy=input('enter directory path for the noisy data of each instrument: ','s');
    directory_noisy = 'D:\Matlab\DSP project\n_data';

    d = dir(directory_in);
    isub = [d(:).isdir];
    nameFolds = {d(isub).name}';
    nameFolds(ismember(nameFolds,{'.','..'})) = [];
    
    for i = 1:size(nameFolds)
        nums = [nameFolds{i,:}];
        s = strcat(directory_in,nums);
        count = count+1;
        allFiles = dir(s);
        allNames = {allFiles.name};
        allNames(ismember(allNames,{'.','..'})) = [];
        
        [rows, columns] = size(allNames);
        
        for j = 1:columns
            count = count+1;
            audio_path = strcat(s,'\',[allNames{:,j}]);
            [y,Fs] = audioread(audio_path);
    
            %adding white guassian noise to y
    
            yy = awgn(y,snr);
            c = strcat(directory_noisy,"\",nums,"\",[allNames{:,j}],".wav");
    
            %writing a new file
    
            audiowrite(c,yy,Fs);
        end
    end
end