clear all;
close all;
clc;
rng(6);
%% Initilization
%Globals vars and the Field
Global.T = 27;
Global.MotMdl = [.75 .25; .35 .65;];
Global.NumStates = size(Global.MotMdl,1);
initState = 1;
%Network
Network.NumNodes = 2;
Network.Node(1).ObsMdl = [5/6, 1/6;3/12, 9/12];
Network.Node(2).ObsMdl = [4/6, 2/6;4/12, 8/12];

% Network.ProbOfLinkFail = 1*ones(Global.T,1);
% Network.ProbOfLinkFail(1:2) = 0;
% Network.ProbOfLinkFail(6) = 0;
Network.ProbOfLinkFail = [0 0 0 1 1 1 1 0 0 0 0 0 1 1 1 1 1 1 1 0 0 0 0 0 0 0 0];

[Network,Global.GT] = HMM_SimpleSampling(Global.T,Global.MotMdl,initState,Network);

for i = 1:Network.NumNodes
    Network.Node(i).Prior = zeros(2,Global.T);
    Network.Node(i).Prior(initState,1) = 1;
end
%% Simulations
Network_GMD = Network;
Network_FDN = Network;
Network_OPT = Network;
Network_GCF = Network;
Network_CEN = Network;
Network_IND = Network;
for k=1:Global.T
    if k~=1
        for i = 1:Network.NumNodes
            Network_GMD.Node(i).Prior(:,k) = Network_GMD.Node(i).Post(:,k-1);
            Network_FDN.Node(i).Prior(:,k) = Network_FDN.Node(i).Post(:,k-1);
            Network_OPT.Node(i).Prior(:,k) = Network_OPT.Node(i).Post(:,k-1);
            Network_GCF.Node(i).Prior(:,k) = Network_GCF.Node(i).Post(:,k-1);
            Network_CEN.Node(i).Prior(:,k) = Network_CEN.Node(i).Post(:,k-1);
            Network_IND.Node(i).Prior(:,k) = Network_IND.Node(i).Post(:,k-1);
        end
    end
    Network_GMD = GMD(Global,Network_GMD,k);
    Network_FDN = FDN(Global,Network_FDN,k);
    Network_OPT = OPT(Global,Network_OPT,k);
    Network_GCF = GCF(Global,Network_GCF,k);
    Network_CEN = CEN(Global,Network_CEN,k);
    Network_IND = IND(Global,Network_IND,k);
end
PM_GMD_GT = PerfMeas_GT(Global,Network_GMD);
PM_FDN_GT = PerfMeas_GT(Global,Network_FDN);
PM_OPT_GT = PerfMeas_GT(Global,Network_OPT);
PM_GCF_GT = PerfMeas_GT(Global,Network_GCF);
PM_CEN_GT = PerfMeas_GT(Global,Network_CEN);
PM_IND_GT = PerfMeas_GT(Global,Network_IND);

PM_GMD_CEN = PerfMeas_CEN(Global,Network_GMD,Network_CEN);
PM_GCF_CEN = PerfMeas_CEN(Global,Network_GCF,Network_CEN);


PM_GMD_CEN.BCS
PM_GMD_CEN.HEL
PM_GMD_CEN.meanBCS
PM_GMD_CEN.meanHEL
%% Analysis
%Mutual Information(MI) between FDN and GMD
P_FDN_N1 = Network_FDN.Node(1).Post;
P_FDN_N2 = Network_FDN.Node(2).Post;
P_GMD_N1 = Network_GMD.Node(1).Post;
P_GMD_N2 = Network_GMD.Node(2).Post;

%plot(P_FDN_N1(1,:)-P_GMD_N1(1,:));hold;plot(P_FDN_N2(1,:)-P_GMD_N2(1,:));
%% PLOT
figure;
subplot(311);
hold on;
plot(PM_GMD_GT.Node(1).Post_Entropy(1:end-1))
plot(PM_GMD_GT.Node(1).Prior_Entropy(2:end))
legend('Post','Prior')

subplot(312);
hold on;
plot(PM_GMD_GT.Node(2).Post_Entropy(1:end-1))
plot(PM_GMD_GT.Node(2).Prior_Entropy(2:end))
legend('Post','Prior')

subplot(313);
hold on;
plot(PM_GMD_GT.Node(1).Post_Entropy(1:end-1)+PM_GMD_GT.Node(2).Post_Entropy(1:end-1))
plot(PM_GMD_GT.Node(1).Prior_Entropy(2:end)+PM_GMD_GT.Node(2).Prior_Entropy(2:end))
legend('Post','Prior')




figure
subplot(321)
plot(PM_GMD_CEN.BCS(1,:)); hold on ; plot(PM_GCF_CEN.BCS(1,:)); hold on
xlabel('step')
ylabel('BC distance')
legend('N1_GMD','N1_GCF')


subplot(323)
plot(PM_GMD_CEN.BCS(2,:)); hold on ; plot(PM_GCF_CEN.BCS(2,:)); hold on
xlabel('step')
ylabel('BC distance')
legend('N2_GMD','N2_GCF')


subplot(325)
plot(PM_GMD_CEN.meanBCS); hold on ; plot(PM_GCF_CEN.meanBCS);
xlabel('step')
ylabel('BC distance')
legend('Mean BC GMD','Mean BC GCF')



subplot(322)
plot(PM_GMD_CEN.HEL(1,:)); hold on ; plot(PM_GCF_CEN.HEL(1,:)); hold on
xlabel('step')
ylabel('HEL distance')
legend('N1_GMD','N1_{GCF}')


subplot(324)
plot(PM_GMD_CEN.HEL(2,:)); hold on ; plot(PM_GCF_CEN.HEL(2,:)); hold on
xlabel('step')
ylabel('HEL distance')
legend('N2_GMD','N2_GCF')


subplot(326)
plot(PM_GMD_CEN.meanHEL); hold on ; plot(PM_GCF_CEN.meanHEL);
xlabel('step')
ylabel('HEL distance')
legend('Mean BC GMD','Mean BC GCF')



