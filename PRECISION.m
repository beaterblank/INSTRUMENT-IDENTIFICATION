function precision = PRECISION(res,res_test)
    count=0;
    same =0;
    for i=1:height(res)
        count= count+1;
        if(res_test(i,:)==res{i,:})
            same= same+1;
        end
    end
    precision = same*100/count;
end