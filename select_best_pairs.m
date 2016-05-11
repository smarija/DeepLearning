function [ featuresTr, featuresTe ] = select_best_pairs( featuresTr, featuresTe )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

support=sum(featuresTr,1)/size(featuresTr,1);
tmp=featuresTr;
%choose the one with the highest support
[~,y,~]=find(support==max(support));
%until all instances are covered, do:
support(y(1))=-support(y(1));
%remove the instances already covered and choose the next pair with the
[x,~,~]=find(tmp(:,y(1)));
tmp(x,:)=[];
%highest support
[prev_tick, interval_time,start  ] = timer_start(60 );
K=1; %counter for features
i=0; %counter
while(~isempty(tmp) && ~all(support<=0) && K<100)
    [~,y,~]=find(support==max(support));
    if(sum(tmp(:,y(1)))>0)
        support(y(1))=-support(y(1));
        [x,~,~]=find(tmp(:,y(1)));
        tmp(x,:)=[];
        K=K+1;
    else
        support(y(1))=0;    %for those features with high support, but already covered by the previous datasets
    end  
    i=i+1;
   [ prev_tick] = timer_mid( prev_tick, interval_time ,start, size(tmp,1), i );
end

%add the best features
[~,y,~]=find(support<0);
featuresTr=featuresTr(:,y);
featuresTe=featuresTe(:,y);

end

