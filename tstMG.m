%%%test for Random MultiGraphs
clear
clc

% datasets = {'dermatology', 'iris', 'wine', 'glass', 'balance', 'segmentation', 'pendigits', 'vowel', 'yeast', 'satimage', 'letter', ...
%                  'optdigits', 'shuttle', 'vehicle', 'ecoli', 'waveform21', 'waveform40', 'usps', 'soybean', 'YaleB', ...
%                 'breast', 'protein', 'pima', 'ionosphere','housing','newsgroups','mnist'};
datasets= {'usps','newsgroups'};
NumRanPat = 10;
Accus = zeros(NumRanPat, 1); 
RunTime = zeros(NumRanPat, 1);

for dts = 1:length(datasets)
        try
            load(['../datasets/', datasets{dts}, 'Data', '.mat']);             
        catch error
            error('Error: No training data');
        end
        % Now we have data(not scaled) and labels;
     for pt = 1:NumRanPat
        try
            load(['../datasets/randlabeled/', datasets{dts}, 'Trn', num2str(pt), '.mat']);             
        catch error
            error('Error: No training data');
        end
        % Now we have labeled data: trX,trLab,indTrn;  and unlabeled data:
        % tsX,tsLab,indTst. trX and txX have been scaled to -1 and 1.
        
        % Scale the data
        [N,Dim] = size(data);
        X=NewScale(double(data));
        k=length(unique(labels));
        
        %CV on the first turn
%         if pt == 1
%            sigma = CV(X,labels,k);
%         end
        
        
        %sigma=1;
        kg=100;
        kf=floor(4*sqrt(Dim));
        tic;
        [G,F]=MultiGraphs(X,labels,trX,trLab,tsX,tsLab,indTrn,kg,kf);
        time = toc;

        %compute the accuracy
        [a,y]=max(F,[],2);
        
        Accus(pt) = 1-length(find(y~=labels))/(N-size(trX,1));;
        RunTime(pt) = time;

    end
    DtsAccu = mean(Accus);
    AveRunTime = mean(RunTime);
    save(['../results/RMG/', datasets{dts}, 'Error_RMG.mat'], 'DtsAccu','AveRunTime'); 
end
