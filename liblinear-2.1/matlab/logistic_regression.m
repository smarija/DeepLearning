function [ auc_te,cov,nb_f ] = logistic_regression( X,Y , mode,K,name, sample )

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%mode 0 - logistic regression on the regular feature set
%mode 1 - logistic regression with all the pairs
%mode 2 - logistic regression with selected pairs
%mode 3 - logistic regression with only pairs
%pom=[0:1:100000];
nb_f=[]; %avearge number of features
cov=[]; % average coverage
% Y(Y==0)=-1;
X = double(logical(X));
fold=mod([1:1:numel(Y)],10);
c_opt=[0.01,0.1,1,10];
auc_best_val=[];
auc_te=[];
nb_feat_test_all=[];

%10 fold cross-validation
    for i=0:9
        disp(strcat('Fold:',num2str(i)))
        [~,ind,~]=find(fold~=i);
        [~,te,~]=find(fold==i);
        if (sample)
            nb=floor(numel(ind)*(sample/100));
            ind = datasample(ind,nb);
        end
        Xind=X(ind,:);
        Xte=X(te,:);
        Yind=Y(ind);
        Yte=Y(te);
        %inner cross-validation for best C
        fold_cross=mod([1:1:numel(ind)],3);
        for k=1:4
            c=c_opt(k);  
            auc_val=[];
            for j=0:2
                [~,tr,~]=find(fold_cross~=j);
                [~,val,~]=find(fold_cross==j);
                Xtr=Xind(tr,:);
                Xval=Xind(val,:);
                Ytr=Yind(tr);
                Yval=Yind(val);                       
                if (mode==1)
                    [featuresTr,featuresVal]=create_pairs(Xtr,Xval,mode);
                     Xtr=[Xtr,featuresTr];
                     Xval=[Xval,featuresVal];
                elseif (mode==2) %select the best pairs
                    [featuresTr,featuresVal]=create_pairs(Xtr,Xval,mode);
                    [featuresTr,featuresVal]=select_best_covering_pairs(featuresTr,featuresVal,K);
                    Xtr=[Xtr,featuresTr];
                    Xval=[Xval,featuresVal];   
                elseif (mode==3)
                    [featuresTr,featuresVal]=create_pairs(Xtr,Xval,mode);
                    Xtr=[featuresTr];
                    Xval=[featuresVal];
                elseif (mode==4)
                    [featuresTr,featuresVal]=create_pairs(Xtr,Xval,mode);
                    param=strcat({'-s 6  -c '},{num2str(c)});%-e 0.001                
                    model = train(Ytr, featuresTr, char(param)); % 
                    [~,f,~]=find(model.w==0);
                    featuresTr(:,f)=[];
                    if(featuresTr)
                        disp('S')
                    end
                    featuresVal(:,f)=[];                 
                    Xtr=[Xtr,featuresTr];
                    Xval=[Xval,featuresVal];
                elseif (mode==5)
                    [featuresTr,featuresVal]=create_pairs(Xtr,Xval,mode);
                    [featuresTr,featuresVal]=select_features(featuresTr,featuresVal, Ytr);
                     Xtr=[Xtr,featuresTr];
                     Xval=[Xval,featuresVal];
                end                   
                param=strcat({'-s 0  -c '},{num2str(c)});%-e 0.001
                model = train(Ytr, Xtr, char(param)); %              
                [predicted_label, accuracy, prob_estimates] = predict(Yval, Xval, model);
                [~,~,~,auc_tmp] = perfcurve(Yval,prob_estimates,model.Label(1));  
                auc_val=[auc_val,auc_tmp];
             end
             auc_best_val(k)=sum(auc_val)/3;      
        end   
        if (mode==1)
            [featuresInd,featuresTe,coverage,nb_feat,nb_feat_test ]=create_pairs(Xind,Xte,mode);
            Xind=[Xind,featuresInd];
            Xte=[Xte,featuresTe];
            nb_f=[nb_f,nb_feat];
            cov=[cov,coverage];
        elseif (mode==2) %select the best pairs
            [featuresInd,featuresTe,coverage,nb_feat]=create_pairs(Xind,Xte,mode);
            [featuresInd,featuresTe,coverage,nb_feat]=select_best_covering_pairs(featuresInd,featuresTe,K);
            Xind=[Xind,featuresInd];
            Xte=[Xte,featuresTe];           
            nb_f=[nb_f,nb_feat];       
            cov=[cov,coverage];
        elseif (mode==3)
            [featuresInd,featuresTe,coverage,nb_feat,nb_feat_test ]=create_pairs(Xind,Xte,mode);
            Xind=[featuresInd];
            Xte=[featuresTe];
            nb_f=[nb_f,nb_feat];
            cov=[cov,coverage];
        elseif (mode==4)
            [featuresInd,featuresTe,coverage,nb_feat,nb_feat_test ]=create_pairs(Xind,Xte,mode);
            [~,y,~]=find(auc_best_val==max(auc_best_val));
            c= c_opt(y(1));%best performing c
            param=strcat({'-s 6  -c '},{num2str(c)});
            model = train(Yind, featuresInd, char(param)); %-e 0.001
            [~,f,~]=find(model.w==0);
            featuresInd(:,f)=[];
            featuresTe(:,f)=[];
            Xind=[Xind,featuresInd];
            Xte=[Xte,featuresTe];
            nb_f=[nb_f,nb_feat];
            cov=[cov,coverage];
        elseif (mode==5)
            [featuresInd,featuresTe,coverage,nb_feat,nb_feat_test ]=create_pairs(Xind,Xte,mode);
            [featuresInd,featuresTe]=select_features(featuresInd,featuresTe, Yind);
            Xind=[Xind,featuresInd];
            Xte=[Xte,featuresTe];
            nb_f=[nb_f,nb_feat];
            cov=[cov,coverage];
        end                   
        [~,y,~]=find(auc_best_val==max(auc_best_val));
        c= c_opt(y(1));%best performing c
        param=strcat({'-s 0  -c '},{num2str(c)});
        model = train(Yind, Xind, char(param)); %-e 0.001
        [predicted_label, accuracy, prob_estimates] = predict(Yte, Xte, model);
        [~,~,~,auc_tmp1] = perfcurve(Yte,prob_estimates,model.Label(1));
        prob_est=[te;prob_estimates'];
       % save(strcat(name,'_',num2str(i)),'prob_est');
        auc_te=[auc_te,auc_tmp1]
     %   nb_feat_test_all(i+1,:)=nb_feat_test;
        
    end
    auc=sum(auc_te)/10
    name_tmp=strcat(name,num2str(mode),'.mat');
    save(name_tmp, 'auc_te');
%     nb_feat_all=mean(nb_feat_test_all,1);
%     nb_feat_all=mean(nb_feat_test_all,1);
%     [~,y,~]=find(nb_feat_all~=0);
%     nb_feat_all=nb_feat_all(y);
%     scatter(y-1,nb_feat_all);
%     set(gca,'yscale','log');
%     title({name,strcat('Number of Features:',num2str(size(X,2))), strcat('All pairs:',num2str(mean(nb_feat))), strcat('Not used in test set:',num2str(nb_feat_all(1)/mean(nb_feat)*100),'%')})
%     
    
end


