function precision = LR()
    [train,test,res] = createtbl();
    mdl = fitlm([train res]);
    res_test = round(predict(mdl,test));
    precision = PRECISION(res,res_test);
end