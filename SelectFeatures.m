%随机选择k个特征，以矩阵形式返回，每个特征为矩阵中的一列
function X1=SelectFeatures(X,k)
    [n,d]=size(X);
    a = randperm(d);
    %[~,a] = sort(rand(n,1));
    a = a(1:k);
    X1=X(:,a);
end