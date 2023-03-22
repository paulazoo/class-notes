function curse_of_dimensionality
%% Demonstrate distribution of distances and angles of random
%% vectors at high dimensions.
%% Eli Tziperman, 201611, APM120

%% parameters:
N=1000; % number of vectors, make it even
% font size:
set(0,'defaulttextfontsize',16); set(0,'defaultaxesfontsize',16);

%% loop over dimension:
for d=[1,2,3,10,50,100,200,300]; 
  %% setup a set of row vectors of uniformly distributed random
  %% numbers between -1 and 1 - each row of X is a vector:
  X=2*(rand(N,d)-0.5);
  Xnorm=zeros(N,1);
  for i=1:N
    Xnorm(i)=sqrt(dot_product(X(i,:),X(i,:)));
  end
  
  i=0;
  distances=NaN(N*(N-1)/2,1);
  angles=NaN(N*(N-1)/2,1);
  for n=1:N
    for m=2:(n-1)
      i=i+1;
      diff=X(n,:)-X(m,:); distances(i)=sqrt(dot_product(diff,diff));
      angles(i)=acos(dot_product(X(n,:),X(m,:))/(Xnorm(n)*Xnorm(m)));
    end
  end
  dist_mean=mean(distances(1:i));
  distances=distances(1:i)/dist_mean;
  angle_mean=mean(angles(1:i))*180/pi;
  angles=angles(1:i)*180/pi;

  figure(1); clf
  %% plot distribution of distances:
  subplot(2,1,1);
  [counts,centers]=hist(distances,100);
  counts=counts/sum(counts);
  bar(centers,counts,'edgecolor','none');
  xlim([0,2]);
  title(sprintf('distance distribution, dim=%d, $\\langle{}dist\\rangle$=%.2g',d,dist_mean) ...
        ,'interpreter','LaTeX');
  xlabel('distance/mean');
  ylabel('freq');
  
  subplot(2,1,2);
  %% plot distribution of angles:
  [counts,centers]=hist(angles,100);
  counts=counts/sum(counts);
  bar(centers,counts,'edgecolor','none');
  xlim([0,180]);
  title(sprintf('angle distribution, dim=%d, $\\langle\\theta\\rangle$=%.2g',d,angle_mean) ...
        ,'interpreter','LaTeX');
  xlabel('angle (degree)');
  ylabel('freq');

  if 0
    %% save as pdf:
    set(gcf, 'PaperUnits', 'inches'); set(gcf, 'PaperSize', [5 4]);
    set(gcf, 'PaperPosition', [0 0 5 4]); % [left, bottom, width, height];
    saveas(gcf,sprintf('output/curse%3.3d.pdf',d));
  end
  
  pause
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function scalar=dot_product(x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% L2:
scalar=sum(x.*y);
