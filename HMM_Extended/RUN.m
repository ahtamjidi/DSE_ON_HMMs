%% Cleanup
clearvars;
close all;
clc;
addpath(genpath('./'),'-end');
%% Configuration
Sim = Config112();
%% Simulation
[PM,Sim,HMM,Network] = SIM(Sim);
%% Plots
PlotNodesL1(1:Network.NumNodes,Sim,Network,PM);
% PlotGraphs(Sim,HMM,Network);