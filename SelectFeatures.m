%���ѡ��k���������Ծ�����ʽ���أ�ÿ������Ϊ�����е�һ��
function X1=SelectFeatures(X,k)
    [n,d]=size(X);
    a = randperm(d);
    %[~,a] = sort(rand(n,1));
    a = a(1:k);
    X1=X(:,a);
end