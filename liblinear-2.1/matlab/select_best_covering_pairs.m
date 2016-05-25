function [ featuresTr, featuresTe,coverage,nb_features ] = select_best_covering_pairs( featuresTr, featuresTe,K)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes her
%K=1000;
tmp=featuresTr;
selected_features=[];
[prev_tick, interval_time,start  ] = timer_start(60 );
for i=1:K
    if (nnz(tmp))
        cover=sum(tmp,1);
        [val,ind]=max(cover);
        if (val(1)==1)
            %ind=find(cover==1);
            [row,ind,~]=find(tmp==1);
            [~,ia,~] = unique(row);
            ind=ind(ia);
            if(numel(ind)>=(K-i))
                selected_features=[selected_features,ind(1:K-i+1)'];%if all the remaining pairs cover only one instance, add the
               % [vec,~,~]=find(tmp(:,ind)); %Check
               % tmp(vec,:)=[];
                %random first K-i pairs
                 break;
            else
                selected_features=[selected_features,ind'];
               % [vec,~,~]=find(tmp(:,ind)); %Check
               % tmp(vec,:)=[];
                break;
            end
        end
        selected_features=[selected_features,(ind(1))];
        [vec,~,~]=find(tmp(:,ind(1)));
        tmp(vec,:)=[];
        
       % tmp(logical(tmp(:,ind(1))),:)=[]; 
    else
        break
    end
    [ prev_tick] = timer_mid( prev_tick, interval_time ,start, K, i );
end
coverage=sum(logical(sum(featuresTr(:,selected_features),2)))/size(featuresTr,1);
featuresTr=featuresTr(:,selected_features);
featuresTe=featuresTe(:,selected_features);
nb_features=numel(selected_features);
end

