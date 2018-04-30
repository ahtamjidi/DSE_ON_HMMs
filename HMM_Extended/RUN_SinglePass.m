%% Cleanup
clearvars;
close all;
clc;
addpath(genpath('./'),'-end');
%% Configuration
Sim = Config321();
%% Simulation
[PM,Sim,HMM,Network] = SIM(Sim,1);
%% Plots
PlotNodesL1(1:Network.NumNodes,Sim,Network,PM);
%PlotGraphs(Sim,HMM,Network);
figure
graphplot(dtmc(HMM.MotMdl),'ColorEdges',true);
axis equal
%% Animations
% Vis = InitVis(Sim,HMM,Network,[]);
% for t = 2:Sim.EndTime
%     Vis = VisStep(Sim,HMM,Network,Vis,t);
%     pause(.25);
% end
%% UI Control
PlotGrid(Sim,HMM,Network);