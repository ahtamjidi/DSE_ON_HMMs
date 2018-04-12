clearvars;
close all;
clc;
rng(1458);
%% Initilization
%Globals vars and the Field
Global.T = 27*2;
Global.MotMdl = [.25 .75; .65 .35; ];

Global.NumStates = size(Global.MotMdl,1);
initState = 1;
%Network
Network.NumNodes = 4;
Network.Node(1).ObsMdl = [5/6, 1/6;3/12, 9/12];
Network.Node(2).ObsMdl = [4/6, 2/6;4/12, 8/12];
Network.Node(3).ObsMdl = [4/6, 2/6;3/12, 9/12];
Network.Node(4).ObsMdl = [0.95, 0.05;0.05, 0.95];

Network.Connectivity = zeros(Network.NumNodes,Global.T);
Network.Connectivity([1 2],5:9) = 1;
Network.Connectivity([2 3],13:20) = 1;
Network.Connectivity([1 3],30:35) = 1;
Network.Connectivity([1 2 3],40:end-5) = 1;
Network.Connectivity([1 4],18:25) = 1;
                      
[Network,Global.GT] = HMM_SimpleSampling(Global.T,Global.MotMdl,initState,Network);

Network.ConHist(:,:,1) = zeros(Network.NumNodes);
for i = 1:Network.NumNodes
    Network.Node(i).Prior = zeros(2,Global.T);
    Network.Node(i).Prior(initState,1) = 1;
    Network.ConHist(i,i,1) = 1;
end
%% Simulations
Network_GMD = Network;
Network_GCF = Network;
Network_CEN = Network;
Network_FHS = Network;
for k=1:Global.T
    if k~=1
        for i = 1:Network.NumNodes
            Network_GMD.Node(i).Prior(:,k) = Network_GMD.Node(i).Post(:,k-1);
            Network_GCF.Node(i).Prior(:,k) = Network_GCF.Node(i).Post(:,k-1);
            Network_CEN.Node(i).Prior(:,k) = Network_CEN.Node(i).Post(:,k-1);
            Network_FHS.Node(i).Prior(:,k) = Network_FHS.Node(i).Post(:,k-1);
        end
    end
    Network_GMD = GMD(Global,Network_GMD,k);
    Network_GCF = GCF(Global,Network_GCF,k);
    Network_CEN = CEN(Global,Network_CEN,k);
    Network_FHS = FHS(Global,Network_FHS,k);
end

PM_GMD_CEN = PerfMeas_CEN(Global,Network_GMD,Network_CEN);
PM_GCF_CEN = PerfMeas_CEN(Global,Network_GCF,Network_CEN);
PM_GMD_FHS = PerfMeas_FHS(Global,Network_GMD,Network_FHS);
PM_GCF_FHS = PerfMeas_FHS(Global,Network_GCF,Network_FHS);

%% PLOT FHS L1
figure
for j=1:Network.NumNodes
    subplot(Network.NumNodes*100+1*10+j)
    for i = 1:Global.T
        if Network.isConnected(j,i)==1
            patch([i-1 i i i-1],[max(PM_GCF_FHS.L1(j,:))  max(PM_GCF_FHS.L1(j,:)) 0 0],'g','EdgeColor','none','FaceAlpha',.5);
        end   
    end
    hold on;
    gm = plot(PM_GMD_FHS.L1(j,:),'*-'); hold on ; cf = plot(PM_GCF_FHS.L1(j,:),'*-'); hold on; 
    xlabel('step')
    ylabel(strcat('L',int2str(j)))
    legend([gm,cf],strcat('N',int2str(j),'_{GMD}'),strcat('N',int2str(j),'_{GCF}'))
end