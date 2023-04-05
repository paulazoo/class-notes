%% centering and normalizing
clc
X=[ 24.1552 20.4351 17.9566 19.3815 19.7865 18.2850
22.0827 20.3116 18.9283 19.6601 19.7500 19.2672];
Y=[ 10.2826 9.6848 10.8158 9.6649 9.7696 9.7823
9.4235 10.4251 8.4773 10.7371 10.7736 10.1634];

%-------------------------------
[Mx,N]=size(X); [My,N]=size(Y);
X_mean=mean(X,2)
for j=1:N;X(:,j)=X(:,j)-X_mean;end
X
Y_mean=mean(Y,2)
for j=1:N;Y(:,j)=Y(:,j)-Y_mean;end
Y

sumsumX = sum(sum(X.^2))
NM = (N*Mx)
Xstd=sqrt(sum(sum(X.^2))/(N*Mx))
X=X/Xstd

sumsumY = sum(sum(Y.^2))
NM = (N*My)
Ystd=sqrt(sum(sum(Y.^2))/(N*My))
Y=Y/Ystd


%% multivariate

% PCA of [X; Y]

%% MCA
N = 6;

%------------------------------
X_YT=X*Y'
C_MCA=X*Y'/N

% do svd on C_MCA
[U_MCA,S_MCA,V_MCA]=svd(C_MCA)