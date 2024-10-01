load('pcaeksempel.mat')

[n, m] = size(X);

meanX=mean(X);
stdX=std(X);

for j=1:m
    X(:,j)=X(:,j)-meanX(j);

    if stdX(j)~=0
        X(:,j) = X(:,j)/stdX(j);
    end
end

Xnorm=X;