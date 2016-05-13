cd('/home/ms10007/DeepLearning')
make
load('/scratch/ms10007/Datasets/matrix.mat')
load('/scratch/ms10007/Datasets/label.mat')
[auc1]=logistic_regression(matrix,label,0);
save('LogIt0',auc1);
[auc2]=logistic_regression(matrix,label,1);
save('LogIt1',auc2);
[auc3]=logistic_regression(matrix,label,2);
save('LogIt0',auc3);
% [auc1,auc2,auc3]