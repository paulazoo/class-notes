%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function spectral_clustering_example(N,sigma,k)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Demonstrate spectral clustering, dividing a set into two or more
%% subsets using the eigenvectors of the Laplacian matrix.
%% Laplacian matrix is defined as adjacency matrix minus degree
%% matrix, see below.
%% Eli Tziperman, APM120, 201511
%%
%% Inputs: 
%% N - number of points in each of the four clusters,
%% sigma - std in each sluter,
%% k - number of clusters to calculate.

%% Parameters controlling data generation:
% size of data is N*3, made of 3 N-sized clusters.  
% try first N=2 and then N=20
if nargin<1; N=20; end
% Set how randomly spread the four clusters are (larger means more spread):
if nargin<=1; sigma=0.3; end
if nargin==2; k=2; end
if nargin>3; fprintf(1,'too many input arguments.\n');return; end
if nargin==0; 
  fprintf(1,['setting default parameters, to\n'...
             'N=%d; sigma=%g; k=%d\n' ...
             'you may change them using:\n' ...
             'spectral_clustering_example(N,sigma)\n'],N,sigma,k);
end

% label size on plots:
set(0,'defaulttextfontsize',14); set(0,'defaultaxesfontsize',14);
color ='rgbcmyrgbcmyrgbcmyrgbcmy';
marker='......xxxxxx++++++oooooo';

%% Generate data of random clusters:
shift1=[ones(N,1),zeros(N,1)];
shift2=[zeros(N,1),ones(N,1)];
rng(34567); % For reproducibility
X = [randn(N,2)*sigma*0.35+shift1+shift2;
    randn(N,2)*sigma*0.25-0.75*shift1;
    randn(N,2)*sigma*0.25-0.75*shift2];

%% draw original data:
ifig=1; figure(ifig); clf
plot(X(:,1),X(:,2),'.','markersize',12);
if N*3<9;
  for ii=1:N*3
    text(X(ii,1)+0.05,X(ii,2),num2str(ii),'FontSize',20);
  end
end
legend('     data','Location','NorthWestOutside')
title('data');
xlabel('x');
ylabel('y');
pause

%% Calculate distances between all pairs of points:
Y = pdist(X,'euclid'); % or could use, for example, Y = pdist(X,'minkowski',1);
distances=squareform(Y);
ifig=ifig+1;figure(ifig); clf
subplot(2,2,1)
imagesc(distances); colorbar
title('distances, $d_{ij}=|x_i-x_i|$','Interpreter','LaTeX')
pause

%% build similarity matrix from distances (Luxburg 2007):
dist_mean=mean(distances(:));
sigma=dist_mean/2; % a somewhat arbitrary choice of a threshold
W=exp(-distances.^2/sigma^2);
subplot(2,2,2)
imagesc(W); colorbar
title('similarity: $\exp(-d_{ij}^2/\sigma^2)$','Interpreter','LaTeX')
pause

%% degree matrix is some over rows of adjacency matrix:
D=diag(sum(W));
subplot(2,2,3)
imagesc(D); colorbar
title('Degree matrix','Interpreter','LaTeX')
pause
%% Laplacian matrix:
L=D-W;
subplot(2,2,4)
imagesc(L); colorbar
title('Laplacian: $L=D-W$','Interpreter','LaTeX')
pause

%% calculate eivenvectors of Laplacian matrix:
[V,D] = eig(L);

if k==2
  fprintf(1,'Using eigenvector #2 to cluster the data!\n')
else
  fprintf(1,'Using eigenvectors #2-%d to cluster the data!\n',k)
end

%% plot eivenvalues and eigenvectors
ifig=ifig+1;figure(ifig); clf
d=diag(D);
plot(d,'-x');
hold on
%% highlight second smallest eigenvalue:
plot(2,d(2),'ro','markersize',15);
plot(2,d(2),'rx','markersize',15);
xlabel('eigenvalue number, i')
ylabel('eigenvalue, \lambda_i')
title('(d) Laplacian eigenvalues');
%% save as pdf:
set(gcf, 'PaperUnits', 'inches'); set(gcf, 'PaperSize', [5 4]);
set(gcf, 'PaperPosition', [0 0 5 4]); % [left, bottom, width, height];
saveas(gcf,sprintf('Output/spectral-eigenvalues.pdf'));

ifig=ifig+1;figure(ifig); clf
plot(0*V(:,1),'--k','linewidth',0.5);
hold on
for ii=1:k
  hl(ii)=plot(V(:,ii),[color(ii) 'x-']);
  if ii>=2; set(hl,'linewidth',3,'markersize',15); end
  legend_text(ii)=sprintf('%d',ii);
  hold on
end
title(sprintf('(b) Laplacian eigenvectors',k));
xlabel('data point #')
ylabel('eigenvector')
legend([hl(:)],legend_text(:));
%% save as pdf:
set(gcf, 'PaperUnits', 'inches'); set(gcf, 'PaperSize', [5 4]);
set(gcf, 'PaperPosition', [0 0 5 4]); % [left, bottom, width, height];
saveas(gcf,sprintf('Output/spectral-eigenvectors.pdf'));
pause

if k==2
  %% assign clusters based on sign of second eigenvector:
  idx=NaN(N*3,1);
  idx(V(:,2)>0)=1;
  idx(V(:,2)<=0)=2;
elseif k>2
  fprintf(1,['\nClustering eigenvectors 2-k: clustering n [which is the number of \n' ...
             'data points, & also size of L] (k-1)-dimensional [eigenvectors 2-k] \n' ...
             'data vectors into k clusters. Much more \n' ...
             'efficient than clustering original n d-dimensional \n' ...
             'data points where d could be much larger than (k-1).\n\n'])
  opts = statset('Display','final');
  [idx,C] = kmeans(V(:,2:k),k,'Distance','sqeuclidean' ...
                   ,'Replicates',5,'Options',opts);
end

%% draw calculated clusters:
ifig=ifig+1;figure(ifig); clf
for i=1:k
  plot(X(idx==i,1),X(idx==i,2),[color(i) marker(i)],'MarkerSize',12)
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
legend(legends,'Location','NorthWest');
title(sprintf('(a) Data & cluster assignments'));
xlabel('x');
ylabel('y');
%% save as pdf:
set(gcf, 'PaperUnits', 'inches'); set(gcf, 'PaperSize', [5 4]);
set(gcf, 'PaperPosition', [0 0 5 4]); % [left, bottom, width, height];
saveas(gcf,sprintf('Output/spectral-assignments.pdf'));

if k==3
  %% draw clusters in eigernvector space:
  ifig=ifig+1;figure(ifig); clf
  for i=1:k
    plot(V(idx==i,2),V(idx==i,3),[color(i) marker(i)],'MarkerSize',12)
    hold on
  end
  legend(legends,'Location','SouthWest');
  title(sprintf('(c) eigenvector space'));
  xlabel('eigenvector 2');
  ylabel('eigenvector 3');

  %% save as pdf:
  set(gcf, 'PaperUnits', 'inches'); set(gcf, 'PaperSize', [5 4]);
  set(gcf, 'PaperPosition', [0 0 5 4]); % [left, bottom, width, height];
  saveas(gcf,sprintf('Output/spectral-eigenvector-space.pdf'));

end

end

