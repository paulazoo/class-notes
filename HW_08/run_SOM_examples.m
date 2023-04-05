close all; clear all; clc
fprintf(1,['first an example based on programming the algorithm explicitly \n' ...
      'for a 5x1 SOM:\n'])
pause
self_organizing_maps_hand_calculation_example(1)
pause

fprintf(1,['what if we eliminate the adjustment to the neighbors in grid space:\n'])
pause
self_organizing_maps_hand_calculation_example(2)
pause

fprintf(1,['\n\nThen a set of examples using Matlab''s SOM routines and \n' ...
      'demonstrating some more advanced issues:\n'])
self_organizing_maps_library_function_example
