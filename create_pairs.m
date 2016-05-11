function [ featuresTr,featuresTe ] = create_pairs( Xtr,Xte )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
cutoff=size(Xtr,1);
matrix=[Xtr;Xte];
list=triu(matrix'*matrix,1);
[x,y,~]=find(list);
features=matrix(:,x).*matrix(:,y);
featuresTr=features(1:cutoff,:);
featuresTe=features(cutoff+1:end,:);
end

