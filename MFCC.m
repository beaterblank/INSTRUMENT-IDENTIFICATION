function count = MFCC(dir_in,dir_ds)
    % setting the dir of required files %
    %dir_in = input("Enter dir of training data",'s');
    %dir_in = "D:\Matlab\DSP project\n_data\";
    %dir_ds = input("Enter dir of dataset.csv",'s');
    %dir_ds = "D:\Matlab\DSP project\dataset_test.csv";
    % opening the requried files %

    count = 0;
    fid = fopen(dir_ds,"w"); % open the file using fopen 
    d   = dir(dir_in); % read all the sub folders
    isub = [d(:).isdir];
    nameFolds = {d(isub).name}';
    nameFolds(ismember(nameFolds,{'.','..'})) = [];
    
    % looping over all the filenames in the given dir % 
    
    for i = 1:size(nameFolds)
        nums = [nameFolds{i,:}];
        s = strcat(dir_in,nums);
        allFiles = dir(s);
        allNames = {allFiles.name};
        allNames(ismember(allNames,{'.','..'})) = [];
        [rows, columns] = size(allNames);
    
        % looping over the audio files in the folder %
    
        for j=1:columns
            count = count+1;
            audio_path = strcat(s,"\",[allNames{:,j}]);
            [y,Fs] = audioread(audio_path);
    
            % Silence removal %
            
            y(abs(y) <= 0.009) = [];
    
            % Computing MFCC for a frame length of p = 20 ms %
    
            dt = 20/1000;%20 ms in s
            p  = Fs*dt;
            a  = size(y,1);
            num_frames = floor(a/p);
    
            w = hamming(p);
            y_new = y;
    
            for ii = 1:num_frames
                t = (ii-1)*p + 1 : ii*p;
                interval = y_new((ii-1)*p + 1 : ii*p );
                filt = interval.*w;
                ftransform(t) = dct(filt);
                pp(t) = 2595*log(((abs(t))/700) + 1);
            end
            inv_transform = idct(log(abs(ftransform)+0.1));
            k = 1:13;
            xx = zeros(1,14);
            xx(1,1:13) = inv_transform(1,1:13);
            xx(1,14) = i;
            dlmwrite(dir_ds,xx,'delimiter',',','-append');
            %figure,plot(xx);
        end
    end
end
