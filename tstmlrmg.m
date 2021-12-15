clear 
clc
datasets = {'yeast'};
rounds=1;

%load data
for pt = 1:size(datasets,1)  %datasets
    try
        load(['../dataset/lj/',datasets{pt}, '.mat'])                   
    catch error
       error('Error: No training data');
    end
    for i = 1:rounds
        try
            load(['../dataset/lj/randlabeled/',datasets{pt}, 'Trn', num2str(i),'.mat'])                   
        catch error
            error('Error: No training data');
        end
    
    end

end
%[a,b] = find(y == 0);
%y(a,b)=-1;
[N,Dim] = size(x);
X=NewScale(double(x));

kg=100;
kf=floor(4*sqrt(Dim));
tic;
[G,F]=MultiGraphs(X,y,trX,trLab,tsX,tsLab,indTrn,kg,kf);
time = toc;

%evaluations
Pre_Labels=Propagated_train_labelVector(num_of_Labeled_data+1:N,:);
HammingLoss=Hamming_loss(Pre_Labels,tsLab)
RankingLoss=Ranking_loss(Pre_Labels,tsLab)
OneError=One_error(Pre_Labels,tsLab)
Coverage=coverage(Pre_Labels,tsLab)
Average_Precision=Average_precision(Pre_Labels,tsLab)