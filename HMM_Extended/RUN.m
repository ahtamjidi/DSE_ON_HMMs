%% Cleanup
clearvars;
close all;
clc;
addpath(genpath('./'),'-end');
%% Configurations
% General
Sim.EndTime = 27*2;
Sim.seed = 1458;
Sim.MarkovMdl = 1;    
Sim.NetworkMdl = 2;    
Sim.EstimatorMdl = 1;
Sim.EstDoOpt = 0;
% Mode specific
Sim.NumStates = 15; % Works for 2_Hom-nxn mode
Sim.NoSelfLoop = false;
Sim.NumNodes = 5; % Works for 1_Small-nNodes-2States and 2_Small-nNodes-mStates
Sim.MCperTran = 0.6; % Works for 2_Hom-nxn mode
Sim.NetConnectivity = zeros(Sim.NumNodes,Sim.EndTime); % Works for 1_Small-nNodes-2States and 2_Small-nNodes-mStates
Sim.NetConnectivity([1 2],5:11) = 1;
Sim.NetConnectivity([4 5],5:11) = 2;
Sim.NetConnectivity([ 3 4],12:16) = 1;
Sim.NetConnectivity([1 3 5],17:23) = 2;
Sim.NetConnectivity([2 4],24:30) = 1;
Sim.NetConnectivity([1 2 3 ],32:34) = 1;
Sim.NetConnectivity([1 2 3 ],36:38) = 1;
Sim.NetConnectivity([1 2 3 ],40:42) = 1;
Sim.NetConnectivity([4 5],32:34) = 2;
Sim.NetConnectivity([4 5],36:38) = 2;
Sim.NetConnectivity([4 5],40:42) = 2;
Sim.NetConnectivity([1 2 3 4 5],44:54) = 1;



Sim.ConnectivityPeriod = 8;
Sim.WS_beta = 0.25;
Sim.WS_K = 3;
Sim.ImageName = 'World_small2.bmp';
Sim.InitState = 1;

%% Simulation
[PM_GMD_FHS,PM_GCF_FHS,Sim,HMM,Network] = SIM(Sim);
%% Plots
PlotNodesL1(1:Network.NumNodes,Sim,Network,PM_GMD_FHS,PM_GCF_FHS);
PlotGraphs(Sim,HMM,Network);