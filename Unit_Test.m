load('data.mat');
[A,b,c,RMSE] = MD_Orthogonal_Analysis(x,y);
[hx] = SimulateFunc(A,b,c,x);
dif=hx(:)-y(:);
RMSE=sqrt(sum(dif.^2)/length(dif));
disp('Fitting RMSE:')
disp(RMSE)
