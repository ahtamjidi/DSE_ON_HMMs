%% update current local map
%
% inputs:
% - fc:     free counter 
% - oc:     occupied counter 
% - map:    current laser measurement map
% - X:      estimated odometry data
% - i:      current measurement number
% - st:     the step between measurement no. (for debug)
% - gs:     grid size (in each dim.)
%
% outputs:
% - fc:     free counter 
% - oc:     occupied counter 
% - fmp:    current local map
%
% P.S. it uses " Piotr's Image&Video Toolbox Version 3.01" for
% transformation
%
% Alireza Asvadi, Aug. 24 2014 

function [fmp, fc, oc] = upd(fc, oc, map, X, i, st, gs)

%% new measurement: count t
nfc     = double(map == 1);               % compute counters t
noc     = double(map == 0); 
%% update history with new measurement: count t = count t + count (t - 1)
nfc     = nfc + fc;                       % update counter values [count t <= count t + count (t - 1)]
noc     = noc + oc; 
cn      = (nfc == 0) & (noc == 0);        % unkown region (has -1 value for both fc & oc)
%% move updated new measurement to the history: count t => count (t - 1)
fc      = trns(nfc, X, i, i + st, gs);    % transform free counter t (now t -1) on the next free counter ( t)
oc      = trns(noc, X, i, i + st, gs);    % transform occupancy counter t (now t -1) on the next occupancy counter (map t)
fc      = fc .* double(fc >= 0);          % keep valid part (discard -1 values)
oc      = oc .* double(oc >= 0); 
%% local map
fmp     = double(nfc > noc);              % filled map: free and occupied grid cells
fmp(cn) = 0.5;                            % unkown grid cells

end
