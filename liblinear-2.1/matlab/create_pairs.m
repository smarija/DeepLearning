function [ featuresTr,featuresTe,coverage, nb_features ] = create_pairs( Xtr,Xte )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
batch=500000;
cutoff=size(Xtr,1);
matrix=[Xtr;Xte];
%create the features only from the training set
[x,y,~]=find(triu(Xtr'*Xtr,1));
%[x,y,~]=find(list);
%fill out the data for the features
runs=floor(numel(x)/batch)+1;
begining=1;
ending=1;
features=[];
[prev_tick, interval_time,start  ] = timer_start(60 );
for i=1:runs
    if(i==runs)
        ending=numel(x);
    else
        ending=ending+batch;
    end
    x_tmp=x(begining:ending);
    y_tmp=y(begining:ending);
    tmp=matrix(:,x_tmp).*matrix(:,y_tmp);
    features=[features,tmp];   
    begining=begining+batch; 
    [ prev_tick] = timer_mid( prev_tick, interval_time ,start, runs, i );
end

% features=matrix(:,x).*matrix(:,y);
featuresTr=features(1:cutoff,:);
featuresTe=features(cutoff+1:end,:);
coverage=sum(logical(sum(featuresTr,2)))/size(featuresTr,1);
nb_features=size(featuresTr,2);
end

