%% Self Organized Maps (SOM) clustering example.
%% Based on http://www.mathworks.com/help/nnet/ref/selforgmap.html
%% Eli Tziperman, APM 120, 201601

set(0,'defaulttextfontsize',18); set(0,'defaultaxesfontsize',18);

%% get and plot data:
X = simplecluster_dataset;
ifig=1;
figure(ifig); clf; 
scatter(X(1,:),X(2,:));
xlabel('x');
ylabel('y');
title(sprintf('data to be clustered'));

for icase=1:5
  %% specify SOM geometry:
  if icase==1
    nx=4; ny=1;
  elseif icase==2
    nx=2; ny=2;
  elseif icase==3
    nx=3; ny=3;
  elseif icase==4
    nx=2; ny=4;
  elseif icase==5
    nx=4; ny=2;
  end
  
  %% ------------------------------------------------------------------
  %% Matlab's self organizing maps clustering done here:
  %% ------------------------------------------------------------------
  fprintf(1,' SOM geometry is (nx,ny)=(%d,%d).\n',nx,ny)  
  %% specify geometry of SOM:
  net = selforgmap([nx ny]);
  %% train the network to find clusteroids:
  net = train(net,X);
  %% examine network:
  view(net);
  %% classify, Y is a set of vectors (y1,...yn), one per each data point,
  %% containing cluster assignments for all data points, e.g.,
  %% assuming four clusters, if y_i=[0,1,0,0], then the
  %% corresponding i'th data point belongs to cluster 2:
  Y = net(X);
  %% classes is a single vector contain the cluster assignments of all
  %% data points: if classes(i)=2, point i belongs to cluster 2:
  classes = vec2ind(Y);
  %% ------------------------------------------------------------------
  %% end of actual clustering.
  %% ------------------------------------------------------------------

  %% plot clusters in different colors:
  ifig=ifig+1;figure(ifig); clf
  color ='rgbcmyrgbcmyrgbcmyrgbcmy';
  marker='......xxxxxx++++++oooooo';
  Nmaps=nx*ny;
  for i=1:Nmaps
    plot(X(1,classes==i),X(2,classes==i),[color(i) marker(i)],'MarkerSize',12)
    hold on
  end
  xlabel('x');
  ylabel('y');
  title(sprintf('SOM geometry: (nx,ny)=(%d,%d)',nx,ny));
  pause
end
