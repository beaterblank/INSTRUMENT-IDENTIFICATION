function precision = SVM()
    [train,test,res] = createtbl();
    mdl = fitcecoc(train,res);
    res_test = predict(mdl,test);
    precision = PRECISION(res,res_test);
end

