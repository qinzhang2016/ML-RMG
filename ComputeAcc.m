%compute the accuracy of semisupervised method
function acc=ComputeAcc(y,label,numLabeled)
n=size(label,1);
k=length(unique(label));
%acc= length(find(y==label))/n; 
err=0;
for i=1:k
    ind= label==i;
    A=y(ind);
    a=min(A);
    b=max(A);
    [num,~] = hist(A,a:b);
    err=err+size(A,1)-max(num);
end
acc=1-err/(n-numLabeled);
end

% function score = ComputeAcc(true_labels, cluster_labels)
% %ACCURACY Compute clustering accuracy using the true and cluster labels and
% %   return the value in 'score'.
% %
% %   Input  : true_labels    : N-by-1 vector containing true labels
% %            cluster_labels : N-by-1 vector containing cluster labels
% %
% %   Output : score          : clustering accuracy
% 
% % Compute the confusion matrix 'cmat', where
% %   col index is for true label (CAT),
% %   row index is for cluster label (CLS).
% n = length(true_labels);
% cat = spconvert([(1:n)' true_labels ones(n,1)]);
% cls = spconvert([(1:n)' cluster_labels ones(n,1)]);
% cls = cls';
% cmat = full(cls * cat);
% 
% %
% % Calculate accuracy
% %
% [match, cost] = hungarian(-cmat);
% score = (-cost)/n;
