function [ featuresTr,featuresTe,coverage, nb_features ] = create_pairs( Xtr,Xte )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cutoff=size(Xtr,1);
matrix=[Xtr;Xte];
%create the features only from the training set
list=triu(Xtr'*Xtr,1);
[x,y,~]=find(list);
%fill out the data for the features
features=matrix(:,x).*matrix(:,y);
featuresTr=features(1:cutoff,:);
featuresTe=features(cutoff+1:end,:);
coverage=sum(logical(sum(featuresTr,2)))/size(featuresTr,1);
nb_features=size(featuresTr,2);
end

