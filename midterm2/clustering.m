X=[ 1, 9, 1.5, 1, 3, 3, 8.5;
    9, 5, 8.5, 8, 8, 7.5, 4];



clc
close('all')
[~, N]=size(X);

% get dists matrix
dists = squareform(pdist(X'))

% plot the points
figure; hold on
cmap = jet(N);
for i=1:1:N
    scatter(X(1,i), X(2,i), [], cmap(i,:))
end
xlim([0 10]); ylim([0 10])
grid on
hold off

% cluster
Z=linkage(dists,'complete');
% plot dendrogram from Z
figure
dendrogram(Z);

% elbow plot
figure
plot(1:1:N-1,flip(Z(:,3)'), '-o')