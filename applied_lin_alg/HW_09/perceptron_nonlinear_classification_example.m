%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function perceptron_nonlinear_classification_example
%% A nonlinear perceptron classification example
%% Eli Tziperman, APM120, 202003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(0,'defaulttextfontsize',16); set(0,'defaultaxesfontsize',16);
% initialize for plotting purposes:
hl_previous.MarkerSize=0; 

%%------------------------------------------------------------------------
%% Parameters:
%%------------------------------------------------------------------------
% number of data points
N=500;
% number of epochs (passes over all data points)
Nepochs=20;
% my very own fancy adjustable step:
do_adjustable_step=1;
% pause after each iteration to look carefully at what's going on:
do_pause=0;
% base rate of adjustment of perceptron coefficients:
eta0=0.01;

%% true solution for creating training data:
% perceptron equation is something like
% w1*x+w2*y+w3*x^2+w4*y^2+w5*x*y+w6=0, 
% or as specified in the function below.
w_true=[-1,-3,-1,2,3,1]';
%% normalize inputs for ease of comparison to final solution:
norm1=norm([w_true]);
w_true=w_true/norm1;
fprintf(1,'true value: w_true='); disp(w_true')
%%------------------------------------------------------------------------
rng default; % For reproducibility
XX = (rand(2,N)-0.5)*2;
X=[XX(1,:);XX(2,:);XX(1,:).^2;XX(2,:).^2;XX(1,:).*XX(2,:);ones(1,N)];

%% initialize perceptron to be calculated:
dim=length(X(:,1));
w=w_true+0.1*ones(dim,1);
fprintf(1,'initual guess: w='); disp(w')

%% calculate training lables based on true weights and threshold:
for i=1:N; y(i)=sign(w_true'*X(:,i));end

% save data and initial guess to matlab file:
%save('nonlinear-perceptron-HW.mat','w','XX','y')

%% x,y values to use only for plotting perceptron lines, no need to change:
xx=[-1:0.02:1]; yy=[-1:0.02:1];
Nx=length(xx); Ny=length(yy);

%% plot training data:
sym(1:N)='o';
sym(y<0)='x';
figure(1);clf
for i=1:N;
  plot(X(1,i),X(2,i),['b' sym(i)],'markersize',14,'linewidth',2);
  if N<=30; text(X(1,i)+0.05,X(2,i),num2str(i)); end
  hold on;
end
%xlim([-1.15 1]);ylim([-1.15 1]);
axis square

%% plot initial separation line as the zero contour level:
field=calc_perceptron_contour(w,xx,yy,Nx,Ny);
[hl,hc]=contour(xx,yy,field',[0,1000],'linewidth',2,'color','k');
hold on
axis square
xlabel('X_1');
ylabel('X_2');
epoch=0;
title(sprintf('Perceptron demo: o=+1; x=-1; epoch=%d',epoch));
pause

%% training/ learning loop:
for epoch=1:Nepochs
for i=1:N

  %% label the current data point:
  yp=w'*X(:,i);

  %% draw currently considered data point in red, adjust previous
  %% one back to blue:
  if i>1; delete(h_red_symbol); end
  h_red_symbol=plot(X(1,i),X(2,i),['r' sym(i)],'markersize',14,'linewidth',2);

  if sign(yp) ~= sign(y(i))  || sign(yp)==0

    % my addition: make the correction amplitude eta proportional to
    % how far we are from the correct answer for the current point,
    % and make the max and minimum limits go down with epoch number
    % for convergence:
    if do_adjustable_step
      if yp==0; eta=eta0/epoch; else eta=abs(yp); end
      eta=min(eta,1e-2*eta0/epoch); eta=max(eta,2*eta0/epoch);
    else
      eta=eta0;
    end

    %% adjustment step:
    w_old=w;
    w=w+eta*y(i)*X(:,i);

    %% normalize to order 1. is this a good idea?
    w=w/norm(w); 

    %% plot new preceptron-derived separation line using:
    % first make older previous line blue dash: 
    %if hl_previous.MarkerSize~=0;set(hl_previous,'color','b');end
    % and make most recent previous line green dash:
    hc_previous=hc;
    set(hc_previous,'color','g','linestyle','--','linewidth',0.25);
    % then plot new line:
    field=calc_perceptron_contour(w,xx,yy,Nx,Ny);
    [hl,hc]=contour(xx,yy,field',[0,1000],'linewidth',2,'color','k');

    axis square

    %% pause to display updated line position:
    pause(0.05)
  end

  %% pause to see which point is being considered and the consequences:
  if do_pause
    pause
  end

end % one epoch
title(sprintf('Perceptron demo: o=+1; x=-1; epoch=%d',epoch));
pause(0.01)
end % all epochs


%% draw final solution:
field=calc_perceptron_contour(w,xx,yy,Nx,Ny);
title(sprintf('Perceptron demo: o=+1; x=-1; epoch=%d',epoch));
[hl,hc]=contour(xx,yy,field',[0,1000],'linewidth',3,'color','r');

fprintf(1,'final value: w='); disp(w');

end

function field=calc_perceptron_contour(w,xx,yy,Nx,Ny)
for i=1:Nx; for j=1:Ny
  field(i,j)=w(1)*xx(i)+w(2)*yy(j)+w(3)*xx(i)^2+w(4)*yy(j)^2+w(5)*xx(i)*yy(j)+w(6);
end; end
end
