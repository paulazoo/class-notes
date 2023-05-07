%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function CURE_find_representatives_using_hierarchical_clustering(N,sigma,distance)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Demonstrate finding representatives for CURE using hierarchical
%% clustering. This example actually only does the Hierarchical
%% clustering step. In a real application this step would be done
%% on a small subset of the data, and then the a few representative
%% would be chosen from each cluster.
%% Eli Tziperman, APM120, 201604

%% generate data:
if nargin<1; N=200; end
if nargin<2; sigma=0.2; end
if nargin<3; distance='centroid'; end % other, more appropriate, option is 'single'

%% Generate data of two radial clusters:
rng(34567); % For reproducibility
r1=2+sigma*randn(1,N);
theta1=2*pi*randn(1,N);
r2=0+sigma*randn(1,N);
theta2=2*pi*randn(1,N);
% outside circlr:
x1=r1.*cos(theta1);
y1=r1.*sin(theta1);
% inside circle:
x2=r2.*cos(theta2);
y2=r2.*sin(theta2);
X=[x1,x2;y1,y2];

% label size on plots:
set(0,'defaulttextfontsize',16); set(0,'defaultaxesfontsize',16);

%% draw original data:
figure(1); clf
plot(X(1,:),X(2,:),'.','markersize',12);
if N<21;
  for ii=1:N
    text(X(1,ii)+0.05,X(2,ii),num2str(ii),'FontSize',20);
  end
end
legend('     data','Location','NorthWestOutside')
title('Randomly generated data');
pause

%% Calculate distances between all pairs of points:
Y = pdist(X','euclid'); 
distances=squareform(Y);
if 0
  figure(55); clf
  imagesc(distances); colorbar
  title('distances between all pairs of data points')
  pause
end

%% perform near-neighbor hierarchial clustering of all data:
% * Single linkage, also called nearest neighbor, uses the smallest ...
%   distance between objects in the two clusters: 
% * Centroid linkage uses the Euclidean distance between the centroids 
%   of the two clusters: 
Z = linkage(Y,distance); % distance is a string: 'single' or 'centroid'

figure(2); clf
dendrogram(Z);
box on
title('Dendrogram of hierarchical clustering results')
pause

kmax=5;
for k=1:kmax
  
  %% divide into requested number of clusters:
  idx = cluster(Z,'maxclust',k); 
  k=max(idx);
  
  %% draw calculated clusters:
  figure(3); clf
  color ='rgbcmyrgbcmyrgbcmyrgbcmy';
  marker='......xxxxxx++++++oooooo';
  for i=1:k
    plot(X(1,idx==i),X(2,idx==i),[color(i) marker(i)],'MarkerSize',12)
    hold on
  end
  % write legend:
  for i=1:k
    if i<10
      legends(i,:)=['Cluster ' num2str(i)];
    else
      legends(i,:)=['Cluster' num2str(i)];
    end
  end
  legend(legends,'Location','NorthWestOutside');
  title(sprintf('Cluster assignments, maxclust=%d',k));

  if 0
    %% save as pdf:
    set(gcf, 'PaperUnits', 'inches'); set(gcf, 'PaperSize', [5 4]);
    set(gcf, 'PaperPosition', [0 0 5 4]); % [left, bottom, width, height];
    saveas(gcf,sprintf('Output/CURE_distance=%s_k=%d.pdf',distance,k));
  end
  
  pause
end

end

