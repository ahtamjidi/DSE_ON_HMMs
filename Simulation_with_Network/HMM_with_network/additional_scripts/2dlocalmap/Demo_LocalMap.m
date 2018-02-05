%% Local Grid Map
% Inputs: laser range data (L) and estimated odometry (X)
% Output: local occupancy grid map
% Alireza Asvadi, 2014 Aug 29
%% clear memory & command window
clc
clear all
close all
%% set parameters
gs            = 0.05;     % grid size [typ: 0.1 meter]
sz            = 200;      % no. of grid cells in each dimension [typ:200 cells *must be even]
trsh          = 40;       % remove outlier data [typ: 40 meters]
rbr           = 0.2;      % robot radius [meter]
nm            = 1097;     % number of the measurements
sf            = 1;        % start frame [typ: 1]
st            = 1;        % step [typ: 1]
ef            = nm;       % last measurement no. [typ: nm]
pts           = [];       % to save all points for plot
%% local grid map
[X, Lx, Ly]   = prc;      % odometry ([1097*3]) and laser x & y end points (each Lx, Ly: [1097*180])
figure('units','normalized','outerposition',[0 0 1 1])
for i         = sf : st : ef - st;
if i == sf;
%% initialize mapping
[fc, oc]      = init(i, X, Lx, Ly, trsh, gs, sz, st);               % initialize mapping 
else
%% new map
map           = mp(i, Lx, Ly, trsh, gs, sz);                        % compute local grid map t
%% update map
[map, fc, oc] = upd(fc, oc, map, X, i, st, gs);                     % updated local map
%% plot
pts           = shw(map, Lx, Ly, X, pts, i , st, nm, rbr, gs, sz);  % plot
end
end
