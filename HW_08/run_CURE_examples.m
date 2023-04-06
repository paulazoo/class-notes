close all
clc
fprintf(1,'------------------------------------------------------------------------\n');
fprintf(1,['Trying to cluster concentric clusters using inappropriate \n' ...
      '''centroid'' distance between clusteroids:\n']);
pause
CURE_find_representatives_using_hierarchical_clustering(200,0.2,'centroid');
pause


fprintf(1,'\n\n------------------------------------------------------------------------\n');
fprintf(1,['Trying to cluster concentric clusters using the appropriate \n' ...
      '''single'' smallest distance between objects in clusters:\n']);
pause
CURE_find_representatives_using_hierarchical_clustering(200,0.2,'single');


fprintf(1,'\n\n------------------------------------------------------------------------\n');
fprintf(1,['now both steps: finding representatives using Heirarchical clustering, \n' ...
      'and then the point assignment step:\n']);
close all
pause
CURE
