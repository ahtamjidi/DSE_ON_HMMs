%% Cleanup
clearvars;
close all;
clc;
addpath(genpath('./'),'-end');
%% Configurations
Config.EndTime = 27*2;
Config.seed = 1458;
Config.NetworkMdl = 2;
Config.MarkovMdl = 1;
Config.EstimatorMdl = 1;
Config.NumStates = 5;
Config.NumNodes = 5;
Config.NetConnectivity = zeros(Config.NumNodes,Config.EndTime);
Config.NetConnectivity([1 2],5:9) = 1;
Config.NetConnectivity([2 3],13:20) = 1;
Config.NetConnectivity([1 3],30:35) = 1;
Config.NetConnectivity([1 2 3],40:end-5) = 1;
Config.NetConnectivity([1 4],18:25) = 1;
Config.NetConnectivity([1 5],10:17) = 1;
%% Simulation
[PM_GMD_FHS,PM_GCF_FHS,Sim,HMM,Network] = SIM(Config);
%% Plots
PlotNodesL1(1:Network.NumNodes,Sim,Network,PM_GMD_FHS,PM_GCF_FHS);