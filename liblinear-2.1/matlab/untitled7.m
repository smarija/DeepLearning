cd('/home/ms10007/DeepLearning/liblinear-2.1/matlab')
datasets={'TaFeng'}%{'MovieLens100k','PAKDD','NorwegianCompanies','ReallityMining'}%,'YahooMovies','Fraud','BookCrossing','TaFeng','Flickr'};
vec=[0,1,2,3,4,5,6,7,8];
for i=1:numel(datasets)
    coverage=0;
    count=1;
    path=strcat('/scratch/ms10007/Datasets/Datasets/',datasets{i});
    load(strcat(path,'/matrix.mat'));
    load(strcat(path,'/label.mat'));
    [auc1]=logistic_regression(matrix,label,0);
    save(strcat(datasets{i},'LogIt1'),'auc1');
    [auc2]=logistic_regression(matrix,label,1);
    save(strcat(datasets{i},'LogIt2'),'auc2');
    while(coverage<1)
        K=10^vec(count);
        [auc3,coverage,nb_feat]=logistic_regression(matrix,label,2,K);
        save(strcat(datasets{i},'LogIt3K',num2str(floor(nb_feat))),'auc3');
        if (nb_feat<K)
            break
        end
        count=count+1;
    end
end
% [auc1,auc2,auc3]