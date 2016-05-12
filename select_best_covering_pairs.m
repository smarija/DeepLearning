function [ featuresTr, featuresTe ] = select_best_covering_pairs( featuresTr, featuresTe)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes her
K=1000;
tmp=featuresTr;
selected_features=[];
[prev_tick, interval_time,start  ] = timer_start(60 );
for i=1:K
    if (size(tmp,1)>0)
        cover=sum(tmp,1);
        [~,ind]=max(cover);
        selected_features=[selected_features,(ind(1))];
        tmp(logical(tmp(:,ind(1))),:)=[]; 
    end
    [ prev_tick] = timer_mid( prev_tick, interval_time ,start, K, i );
end
featuresTr=featuresTr(:,selected_features);
featuresTe=featuresTe(:,selected_features);
end

