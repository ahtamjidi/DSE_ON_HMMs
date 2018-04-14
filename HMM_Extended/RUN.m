clearvars;
close all;
clc;
addpath(genpath('./'),'-end');
%% Initilization
EndTime = 27*2;
seed = 1458;
NetworkMdl = 1; 
MarkovMdl = 1;
EstimatorMdl = 1; 
[Sim, HMM, Network] = initSim(EndTime,seed,NetworkMdl,MarkovMdl,EstimatorMdl);
%% Simulations
for k = 1:Sim.EndTime
    [HMM,Network] = stepHMM(Sim,HMM,Network,k);
    [Network] = stepNET(Sim,HMM,Network,k);
    [Network] = stepEST(Sim,HMM,Network,k);
end
%% Performance Measures
PM_GMD_FHS = PerfMeas_FHS(Sim,Network,'GMD');
PM_GCF_FHS = PerfMeas_FHS(Sim,Network,'GCF');
%% PLOT FHS L1
figure
for j=1:Network.NumNodes
    subplot(Network.NumNodes*100+1*10+j)
    for i = 1:Sim.EndTime
        if Network.Connectivity(j,i)==1
            patch([i-1 i i i-1],[max(PM_GCF_FHS.L1(j,:))  max(PM_GCF_FHS.L1(j,:)) 0 0],'g','EdgeColor','none','FaceAlpha',.5);
        end   
    end
    hold on;
    gm = plot(PM_GMD_FHS.L1(j,:),'*-'); hold on ; cf = plot(PM_GCF_FHS.L1(j,:),'*-'); hold on; 
    xlabel('step')
    ylabel(strcat('L',int2str(j)))
    legend([gm,cf],strcat('N',int2str(j),'_{GMD}'),strcat('N',int2str(j),'_{GCF}'))
end