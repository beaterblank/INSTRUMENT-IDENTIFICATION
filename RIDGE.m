function precision = RIDGE()
    [train,test,res] = createtbl();
    b = ridge(table2array(res),table2array(train),5,0);     
    res_test = round(b(1) + table2array(test)*b(2:end));
    precision = PRECISION(res,res_test);
end