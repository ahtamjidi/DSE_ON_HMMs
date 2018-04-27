clearvars;
close all;
clc;
rng(1458);
%% Initilization
%Globals vars and the Field
Sim = initSim();
HMM = initHMM(Sim);
Network = initNetwork(Sim,HMM);

%% Simulations
for k = 1:Sim.EndTime    
    [HMM,Network] = HMM_Step(HMM,Network,k);
    [Network] = Network_step(Network,k);
    Network = GMD(HMM,Network,k);
    Network = GCF(HMM,Network,k);
    Network = FHS(HMM,Network,k);
%     Network_CEN = CEN(Global,Network_CEN,k);     
end

%% Fix it
PM_GMD_FHS = PerfMeas_FHS(Sim,Network,'GMD');
PM_GCF_FHS = PerfMeas_FHS(Sim,Network,'GCF');
% PM_GMD_CEN = PerfMeas_CEN(Global,Network_GMD,Network_CEN);
% PM_GCF_CEN = PerfMeas_CEN(Global,Network_GCF,Network_CEN);
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