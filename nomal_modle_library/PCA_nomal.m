function [P,T, LATENT,A,Jth_T2,Jth_SPE]=PCA_nomal(X,Y)
% clc
% data=xlsread('nomal_data.xlsx');
% Y=data(17,:);
% X=data(1:50,:);
%���ֵ
Y_mean=mean(Y,2);
X_mean=mean(X,2);
%���׼��
Y_std = std(Y,0,2);
X_std = std(X,0,2);
%���ݱ�׼��
[mY,nY]=size(Y);
[mX,nX]=size(X);
Y=(Y - repmat(Y_mean,1,nY))./repmat(Y_std,1,nY);
X=(X - repmat(X_mean,1,nX))./repmat(X_std,1,nX);
X = transpose(X);
%��׼ģ��
[COEFF, SCORE, LATENT] = pca(X);
P=COEFF;
T= SCORE;
per=0.85;
A=0;
for i=1:mX
     cpv(i)=sum(LATENT(1:i))/sum(LATENT); %ǰA����Ԫ���ۼƹ����ʹ�ʽ
    if cpv(i)>=per
       A=i;
       break
    end
end
%���������
m=mX;
n=nX;
alpha=0.95;%����ˮƽ
theta1=sum(LATENT(A+1:m));
theta2=sum(LATENT(A+1:m).^2);
theta3=sum(LATENT(A+1:m).^3);
h0=1-2*theta1*theta3/(3*theta1^2);
ca= norminv(alpha,0,1);

Jth_T2=A*(n^2-1)*finv(alpha,A,n-A)/(n*(n-A));
Jth_SPE=theta1*(ca*sqrt(2*theta2*h0^2)/theta1+1+theta2*h0*(h0-1)/theta1^2)^(1/h0);
% P=P(:,1:A);
% LATENT=LATENT(1:A);