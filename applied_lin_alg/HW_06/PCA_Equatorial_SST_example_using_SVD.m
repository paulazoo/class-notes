%% PCA analysis using SVD of data matrix, in 1 Matlab command
%% Eli Tziperman, APM120

%% set data matrix X(Nx,Nt):
%% -------------------------
load Data/SST-equatorial-Pacific.mat;
X=SST_eq_Pacific;
[Nx,Nt]=size(X);
X_mean=mean(X,2); for t=1:Nt; X(:,t)=X(:,t)-X_mean;end

%% calculate first 20 PCs (columns of PC) and corresponding time
%% series (columns of TS) using svd of data matrix X(Nx,Nt):
%% ------------------------------------------------------------------------
[PC,S,TS]=svds(X,20,'L'); 
%% reconstruct reduced dimensional data:
X_rec=X*0; for i=1:20; X_rec=X_rec+PC(:,i)*S(i,i)*TS(:,i)'; end

%% ------------------------------------------------------------------------
%% plot:
figure(1); clf
imagesc(longitude,time_years,X_rec'); 
colormap(jet); 
colorbar
