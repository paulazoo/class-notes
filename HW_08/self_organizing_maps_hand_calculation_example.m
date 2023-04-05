function self_organizing_maps_hand_calculation_example(icase)
%% a simple SOM example calculated from scratch to demonstrate the
%% algorithm.
%% Eli Tziperman, 201604

%% create random clustered data:
rng(989189);
sigma=0.5;
N=20;
N_points_to_pause=20; % pause animation for first few iterations
shift1=ones(2,N);
shift2=[ones(1,N);-ones(1,N)];
shift3=[-ones(1,N);ones(1,N)];
shift4=[-ones(1,N);-ones(1,N)];
X = [randn(2,N)*sigma*0.25-0.5*ones(1,N), ...
     randn(2,N)*sigma*0.25+shift1, ...
    randn(2,N)*sigma*0.35+shift2, ...
    randn(2,N)*sigma*0.4+shift3, ...
    randn(2,N)*sigma*0.35+1.5*shift4];
%% apply a random permutation to the order of the data points
%% (columns), so that they are not organized in 3 neat groups: 
RN=randperm(5*N);
X=X(:,RN);
harrow=nan; % initialize graphics.

%% specify input parameters:
if nargin<1; icase=1; end
if icase==1 % standard case
  %% neighborhood kernel:
  K_nearest=0.9;
  K_other=0.05;
  %% initial guess for representative point locations:
  N_grid=5;
  for j=1:N_grid
    Xref(:,j)=[-2+1*(j-1);2]; 
  end
elseif icase==2 % not adjusting neighbors in grid space
  %% neighborhood kernel:
  K_nearest=1;
  K_other=0.0;
  %% initial guess for representative point locations:
  N_grid=5;
  for j=1:N_grid
    Xref(:,j)=[-2+1*(j-1);2]; 
  end
end

%% base learning rate:
eta0=0.1;
%% number of epochs:
N_epochs=3;

%% plot data:
set(0,'defaulttextfontsize',18); set(0,'defaultaxesfontsize',18);

figure(1); clf
scatter(X(1,:),X(2,:),100,'bo');
box on
xlim([-2 2]);
ylim([-2 2]);
hold on

% plot reference points:
href=scatter(Xref(1,:),Xref(2,:),200,'rx');
for ii=1:N_grid 
  h_ref_text(ii)=text(Xref(1,ii)+0.07,Xref(2,ii),num2str(ii),'FontSize',20);
end

%% iterate over entire data set a few times:
iter=0; % counter of data points being examined
for iepoch=1:N_epochs
  title(sprintf('SOM demo, epoch=%d',iepoch));

  %% make learning rate smaller for higher iterations
  eta=eta0;%/sqrt(iter);
  
  %% loop over data points:
  for n=1:length(X(1,:))
    iter=iter+1;
  
    %% find which reference point is nearest to current data point: 
    [Dmin,I]=min([norm(X(:,n)-Xref(:,1)),norm(X(:,n)-Xref(:,2))...
                  ,norm(X(:,n)-Xref(:,3)),norm(X(:,n)-Xref(:,4)),norm(X(:,n)-Xref(:,5))]);
  
    %% draw current data point in red:
    if ~(n==1 && iepoch==1); delete(h_current_data); end
    h_current_data=scatter(X(1,n),X(2,n),100,'ro','MarkerFaceColor','r');
    if iter<N_points_to_pause; pause; end
    
    %% adjust the nearest reference point using the learning rate:
    Xref(:,I)=Xref(:,I)+eta*K_nearest*(X(:,n)-Xref(:,I));
    x0=Xref(:,I); dx=K_nearest*(X(:,n)-Xref(:,I)); dx=0.6*dx/norm(dx);
    if ~isnan(harrow); delete(harrow); end
    harrow(1)=arrow(x0,x0+dx,'linewidth',2,'FaceColor','g','EdgeColor','g');
    %% adjust the other reference points using the specified kernel:
    nearest_neighbors_grid_space=[I-1,I+1];
    nearest_neighbors_grid_space(nearest_neighbors_grid_space==0)=N_grid;
    nearest_neighbors_grid_space(nearest_neighbors_grid_space==N_grid+1)=1;
    i1=0;
    for nn=nearest_neighbors_grid_space
      i1=i1+1;
      Xref(:,nn)=Xref(:,nn)+eta*K_other*(X(:,n)-Xref(:,nn));
      x0=Xref(:,nn); dx=K_nearest*(X(:,n)-Xref(:,nn)); dx=0.3*dx/norm(dx);
      harrow(1+i1)=arrow(x0,x0+dx,'linewidth',1,'FaceColor','g','EdgeColor','g');
    end
    
    %% erase previous ref points and plot new ones:
    delete(href);delete(h_ref_text);
    href=scatter(Xref(1,:),Xref(2,:),200,'rx');
    for ii=1:N_grid 
      h_ref_text(ii)=text(Xref(1,ii)+0.07,Xref(2,ii),num2str(ii),'FontSize',20);
    end
    if iter<N_points_to_pause; pause; end
    pause(0.05)
  end
end
