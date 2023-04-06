close all; clear all; clc

fprintf(1,'\n\n------------------------------------------------------------------\n');
disp(['Calculating slope only, threshold is zero, using a few data ' ...
      'points:'])
pause
perceptron_classification_example(30,0,0,1,0.5)
disp('done.')
pause

%fprintf(1,'\n\n------------------------------------------------------------------\n');
%disp(['Calculating slope only, threshold is zero, with many points, ' ...
%      'to show difficulty to converge:'])
%pause
%perceptron_classification_example(2000,0,0,0,0.5)
%disp('done.')
%pause

%fprintf(1,'\n\n------------------------------------------------------------------\n');
%disp(['Calculating slope only, threshold is zero, with adjustable ' ...
%      'step to improve convergence:'])
%pause
%perceptron_classification_example(2000,0,1,0,0.5)
%disp('done.')
%pause

fprintf(1,'\n\n------------------------------------------------------------------\n');
disp('Calculating threshold too, few points only:')
pause
perceptron_classification_example(30,1,1,1,0.5)
disp('done.')
pause


fprintf(1,'\n\n------------------------------------------------------------------\n');
disp(['Calculating threshold too, lots of points, showing good ' ...
      'convergence calculating threshold too:'])
pause
perceptron_classification_example(1000,1,1,0,0.5)
disp('done.')

fprintf(1,'\n\n------------------------------------------------------------------\n');
disp(['a nonlinear perceptron example: w1*x+w2*y+w3*x^2+w4*y^2+w5*x*y+w6=0:'])
pause
perceptron_nonlinear_classification_example
disp('done.')
