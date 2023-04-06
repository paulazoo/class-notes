%% Implement CURE, using heirarchical clustering of a subsample of
%% the data to get the representatives, then use the
%% representatives for making the point assignments for all data.
%% Eli Tziperman, APM120, 201703

echo on
%% load data:
load Data/CURE_data.mat;
N=length(X(1,:));
%pause

%% randomly shuffle data:
rng(3989);
myrandperm = randperm(N);
X = X(:,myrandperm);
%pause

%% subsample first Nrepresentatives points to find representatives
Nrepresentatives=300;
Xrepresentatives=X(:,1:Nrepresentatives);
%pause

%% Heirarchical clustering of subsample to get representatives
Y=pdist(Xrepresentatives','euclid'); 
method='single';
Z=linkage(Y,method);
k=2;
IDXrepresentatives = cluster(Z,'maxclust',k);
%pause
echo off

%% print the next loop which cannot be displayed using "echo on":
fprintf(1,'\n\n%% Go over full data set to decide on clustering of all points\n');
fprintf(1,'for i=1:N\n');
fprintf(1,'  %% find nearest representative to data point i:\n');
fprintf(1,'  for j=1:Nrepresentatives\n');
fprintf(1,'    distances(j)=norm(X(:,i)-Xrepresentatives(:,j));\n');
fprintf(1,'  end\n');
fprintf(1,'  %% assign data point i to cluster of nearest representative point:\n');
fprintf(1,'  [M,Inearest] = min(distances);\n');
fprintf(1,'  IDX(i)=IDXrepresentatives(Inearest);\n');
fprintf(1,'end\n');

%% Go over full data set to decide on clustering of all points
for i=1:N
  %% find nearest representative to data point i:
  for j=1:Nrepresentatives
    distances(j)=norm(X(:,i)-Xrepresentatives(:,j));
  end
  %% assign data point i to cluster of nearest representative point:
  [M,Inearest] = min(distances);
  IDX(i)=IDXrepresentatives(Inearest);
end
%pause

%% plot full unclustered data:
figure(1); clf
plot(X(1,:),X(2,:),'.k');
title(sprintf('full unclustered data, N=%d',N));

%% plot representatives:
set(0,'defaulttextfontsize',18); set(0,'defaultaxesfontsize',18);
figure(2); clf
red_rep=Xrepresentatives(:,IDXrepresentatives==1);
blue_rep=Xrepresentatives(:,IDXrepresentatives==2);
plot(red_rep(1,:),red_rep(2,:),'.r');
hold on
plot(blue_rep(1,:),blue_rep(2,:),'.b');
title(sprintf('representatives, N=%d',Nrepresentatives));
legend('cluster 1','cluster 2');

%% plot full clustered data:
figure(3); clf
red=X(:,IDX==1);
blue=X(:,IDX==2);
plot(red(1,:),red(2,:),'.r');
hold on
plot(blue(1,:),blue(2,:),'.b');
title(sprintf('full clustered data, N=%d',N));
legend('cluster 1','cluster 2');

