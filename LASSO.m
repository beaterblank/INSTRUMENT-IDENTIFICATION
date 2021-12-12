function precision = LASSO()
    [train,test,res] = createtbl();
    [B,FitInfo] = lasso(table2array(train),table2array(res),'Alpha',0.75,'CV',10);
    idxLambda1SE = FitInfo.Index1SE;
    coef = B(:,idxLambda1SE);
    coef0 = FitInfo.Intercept(idxLambda1SE);
    XTest = table2array(test);
    yhat = round(XTest*coef + coef0);
    precision = PRECISION(res,yhat);
end