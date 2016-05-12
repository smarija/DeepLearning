function [ featuresTr,featuresTe ] = create_pairs( Xtr,Xte )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cutoff=size(Xtr,1);
matrix=[Xtr;Xte];
%create the features only from the training set
list=triu(Xtr'*Xtr,1);
[x,y,z]=find(list);
i=find(z==1);
x(i)=[];
y(i)=[];
clear Xtr Xte
% fill out the data for the features
features=matrix(:,x).*matrix(:,y);
featuresTr=features(1:cutoff,:);
featuresTe=features(cutoff+1:end,:);
end

