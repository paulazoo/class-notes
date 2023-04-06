%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function perceptron_classification_example(N,do_calc_threshold,do_adjustable_step,do_pause,eta0)
%% Perceptron classification example
%% Eli Tziperman, APM120, 201511
%% Try the following:
%% ------------------
%% Calculating slope only, threshold is zero, using a few data points:
%% perceptron_classification_example(30,0,0,1,0.5)
%% Same with many points, to show difficulty to converge:
%% perceptron_classification_example(2000,0,0,0,0.5)
%% Same with adjustable step to improve convergence:
%% perceptron_classification_example(2000,0,1,0,0.5)
%% Calculating threshold too, few points only:
%% perceptron_classification_example(30,1,1,1,0.5)
%% Same, lots of points, showing good convergence calculating threshold too:
%% perceptron_classification_example(2000,1,1,0,0.5)
%% to reproduce the example in the class notes:
%% perceptron_classification_example(5,1,0,1,0.4)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(0,'defaulttextfontsize',16); set(0,'defaultaxesfontsize',16);
% initialize for plotting purposes:
hl_previous.MarkerSize=0; 
harrow_previous=0;
%%------------------------------------------------------------------------
%% Parameters:
%%------------------------------------------------------------------------
% number of data points
if nargin<1; N=30; end
% 1 or 0 for calculating threshold theta or assuming it known:
if nargin<2; do_calc_threshold=0; end
% my very own fancy adjustable step:
if nargin<3; do_adjustable_step=0; end
% pause after each iteration to look carefully at what's going on:
if nargin<4; do_pause=1; end
% base rate of adjustment of perceptron coefficients:
if nargin<5; eta0=0.5; end

%% true solution for creating training data:
w_true=[-1,3]';
theta_true=1;
if ~do_calc_threshold; theta_true=0; end

%%------------------------------------------------------------------------


%% initialize perceptron and threshold (theta, last element of w) to be calculated:
dim=2;
if do_calc_threshold
  w=ones(dim+1,1); 
else
  w=ones(dim,1); 
end

%% generate training data:
if N==5
  %% example for course notes:
  X=[ -8.1   4.5   6.5   1.1   -1.2;
      8.7   -8.7   -0.5   -7.6   4.3]/10;
  y=[ -1   1   1   1   -1];
  theta=-0.4;
  w=[-1 -1.8 theta]';
  w_true=[1 -1]';
  theta_true=0;
else
  rng default; % For reproducibility
  X = (rand(dim,N)-0.5)*2;
  %% calculate training lables based on true weights and threshold:
  for i=1:N; y(i)=sign(w_true'*X(:,i)-theta_true);end
end

%% normalize inputs for ease of comparison to final solution:
if do_calc_threshold
  norm1=norm([w_true;theta_true]);
  w_true=w_true/norm1; theta_true=theta_true/norm1;
  theta=0;
else
  norm1=norm(w_true);
  w_true=w_true/norm1;
  theta=0;
end

%% two x values to use only for plotting perceptron line, no need to change:
x=[-10,5]; 

%% plot training data:
sym(1:N)='o';
sym(y<0)='x';
figure(1);clf
for i=1:N;
  plot(X(1,i),X(2,i),['b' sym(i)],'markersize',14,'linewidth',2);
  if N<=30; text(X(1,i)+0.05,X(2,i),num2str(i)); end
  hold on;
end
xlim([-1.15 1]);ylim([-1.15 1]);
axis square


%% plot initial separation line:
hl=plot(x,(-x*w(1)+theta)/w(2),'-');
%% superimpose the w vector pointing toward positive values:
%% find start point [xw0,yw0] of w vector from, in the middle of svm line:
xw=[-5:0.1:5]; yw=(-xw*w(1)+theta)/w(2);
xw(yw<-1)=nan; xw(yw>1)=nan; xw(xw<-1)=nan; xw(xw>1)=nan; yw(isnan(xw))=nan;
xw0=0.5*(nanmin(xw)+nanmax(xw)); yw0=0.5*(nanmin(yw)+nanmax(yw));
harrow_previous=arrow([xw0,yw0],[xw0,yw0]+0.25*[w(1),w(2)]/norm(w) ...
                      ,'linewidth',2,'FaceColor','g','EdgeColor','g');
axis square
xlabel('X_1');
ylabel('X_2');
title('Perceptron demo: o=+1; x=-1');
if N~=5; 
  text(-1.08,-1.08,'(--b old; --g recent; -b current; -r final)','fontsize',22,'color','r');
end
pause

%% training/ learning loop:
for i=1:N

  %% label the current data point:
  if do_calc_threshold
    yp=w'*[X(:,i);-1];
  else
    yp=w'*X(:,i);
  end

  %% draw currently considered data point in red, adjust previous
  %% one back to blue:
  if i>1; delete(h_red_symbol); end
  h_red_symbol=plot(X(1,i),X(2,i),['r' sym(i)],'markersize',14,'linewidth',2);

  if sign(yp) ~= sign(y(i))  || sign(yp)==0

    %% my addition: make the correction amplitude eta proportional to how
    %% far we are from the correct answer for the current point:
    if do_adjustable_step
      if yp==0; eta=eta0; else eta=abs(yp); end
      eta=min(1,eta); eta=max(eta,0.1);
    else
      eta=eta0;
    end

    %% adjustment step:
    w_old=w;
    theta_old=theta;
    if do_calc_threshold
      w=w+eta*y(i)*[X(:,i);-1];
    else
      w=w+eta*y(i)*X(:,i);
    end

    %% normalize to order 1. is this a good idea?
    w=w/norm(w); 
    if do_calc_threshold; theta=w(dim+1); end

    fprintf(1,' testing data X(:,%d)=[%4.2f,%4.2f]; y''=%g; sign(y'')=%d, sign(y(i))=%d\n' ...
            ,i,X(:,i),yp,sign(yp),sign(y(i)))
    fprintf(1,'adjusted from w=[%4.2g,%4.2g]; theta=%4.2f; to w=[%4.2g,%4.2g]; theta=%4.2g\n' ...
            ,w_old(1:dim),theta_old,w(1:dim),theta);
    %% plot new preceptron-derived separation line using:
    % first make older previous line blue dash: 
    if hl_previous.MarkerSize~=0;set(hl_previous,'color','b');end
    % and make most recent previous line green dash:
    hl_previous=hl;
    set(hl_previous,'color','g','linestyle','--');
    % then plot new line:
    if w(2) ~= 0
      hl=plot(x,(theta-x*w(1))/w(2),'b-');
    elseif w(1) ~= 0
      hl=plot((theta-x*w(2))/w(1),x,'b-');
    end
    %% superimpose the w vector pointing toward positive values:
    %% find start point [xw0,yw0] of w vector from, in the middle of svm line:
    if harrow_previous~=0; delete(harrow_previous); end
    xw=[-5:0.1:5]; yw=(-xw*w(1)+theta)/w(2);
    xw(yw<-1)=nan; xw(yw>1)=nan; xw(xw<-1)=nan; xw(xw>1)=nan; yw(isnan(xw))=nan;
    xw0=0.5*(nanmin(xw)+nanmax(xw)); yw0=0.5*(nanmin(yw)+nanmax(yw));
    harrow_previous=arrow([xw0,yw0],[xw0,yw0]+0.25*[w(1),w(2)]/norm(w) ...
          ,'linewidth',2,'FaceColor','g','EdgeColor','g');
    axis square

    %% pause to display updated line position:
    pause(0.05)
  else
    if N==5; 
      fprintf(1,' testing data X(:,%d)=[%4.2f,%4.2f]; y''=%g; sign(y'')=%d, sign(y(i))=%d\n' ...
              ,i,X(:,i),yp,sign(yp),sign(y(i)))
    end
  end

  %% pause to see which point is being considered and the consequences:
  if do_pause
    pause
  end

end

%% draw final solution:
if w(2) ~= 0
  hl=plot(x,(theta-x*w(1))/w(2),'r-','linewidth',2);
elseif w(1) ~= 0
  hl=plot((theta-x*w(2))/w(1),x,'r-','linewidth',2);
end

fprintf(1,'Final solution: w=[%4.2g,%4.2g]; theta=%4.2g\n' ...
        ,w(1:dim),theta);
fprintf(1,' True solution: w=[%4.2g,%4.2g]; theta=%4.2g\n' ...
        ,w_true(1:dim),theta_true);
