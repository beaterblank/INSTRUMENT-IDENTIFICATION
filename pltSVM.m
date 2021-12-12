function [x,y]  = pltSVM(snrs)
    warning('off','all')
    n = length(snrs);
    x=zeros(1,n);
    y=zeros(1,n);
    for i=1:n
        x(i) = snrs(i);
        disp(snrs(i))
        y(i) = MAIN(snrs(i));
        disp(y(i));
    end
    a = plot(x,y);
    xlabel("SNR (dB)");
    ylabel("Precision (%)");
    title("SNR vs Precision");
end