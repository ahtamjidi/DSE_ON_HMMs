%% initialize mapping  
%
% inputs:
% - i:      current measurement number
% - X:      estimated odometry data
% - Lx, Ly: laser end points [x & y]
% - trsh:   treshold to remove outlier (laser endpoints that are outside the reliable range of laser)     
% - gs:     grid size (in each dim.)
% - sz:     size of each cell (in meter)
% - st:     the step between measurement no. (for debug)
%
% outputs:
% - fc:     free counter 
% - oc:     occupied counter 
%
% Alireza Asvadi, Aug. 24 2014 

function [fc, oc] = init(i, X, Lx, Ly, trsh, gs, sz, st)

%% first map
map     = mp(i, Lx, Ly, trsh, gs, sz);    % compute local grid map t - 1    
tmap    = trns(map, X, i, i + st, gs);    % transform map t - 1 (on the map t)
%% free and occupied cell counters
fc      = double(tmap == 1);              % compute counters t - 1
oc      = double(tmap == 0);

end
