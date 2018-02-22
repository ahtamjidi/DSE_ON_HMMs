clearvars;
close all;
clc;
rng(1458);
%% Initilization
%Globals vars and the Field
Global.T = 27*3;
Global.MotMdl = [.75 .25; .35 .65; ];
Global.NumStates = size(Global.MotMdl,1);
initState = 1;
%Network
Network.NumNodes = 3;
Network.Node(1).ObsMdl = [5/6, 1/6;3/12, 9/12];
Network.Node(2).ObsMdl = [4/6, 2/6;4/12, 8/12];
Network.Node(3).ObsMdl = [4/6, 2/6;4/12, 8/12];

% Network.ProbOfLinkFail = 1*ones(Global.T,1);
% Network.ProbOfLinkFail(1:2) = 0;
% Network.ProbOfLinkFail(6) = 0;
Network.ProbOfLinkFail = [0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

[Network,Global.GT] = HMM_SimpleSampling(Global.T,Global.MotMdl,initState,Network);

for i = 1:Network.NumNodes
    Network.Node(i).Prior = zeros(2,Global.T);
    Network.Node(i).Prior(initState,1) = 1;
end
%% Simulations
Network_GMD = Network;
%Network_FDN = Network;
%Network_OPT = Network;
Network_GCF = Network;
Network_CEN = Network;
%Network_IND = Network;
for k=1:Global.T
    if k~=1
        for i = 1:Network.NumNodes
            Network_GMD.Node(i).Prior(:,k) = Network_GMD.Node(i).Post(:,k-1);
    %        Network_FDN.Node(i).Prior(:,k) = Network_FDN.Node(i).Post(:,k-1);
   %         Network_OPT.Node(i).Prior(:,k) = Network_OPT.Node(i).Post(:,k-1);
            Network_GCF.Node(i).Prior(:,k) = Network_GCF.Node(i).Post(:,k-1);
            Network_CEN.Node(i).Prior(:,k) = Network_CEN.Node(i).Post(:,k-1);
  %          Network_IND.Node(i).Prior(:,k) = Network_IND.Node(i).Post(:,k-1);
        end
    end
    Network_GMD = GMD(Global,Network_GMD,k);
%     Network_GMD = AMD_ENT(Global,Network_GMD,k);

 %   Network_FDN = FDN(Global,Network_FDN,k);
 %   Network_OPT = OPT(Global,Network_OPT,k);
    Network_GCF = GCF(Global,Network_GCF,k);
%     Network_GCF = GCF_AMD_ENT(Global,Network_GCF,k);

    Network_CEN = CEN(Global,Network_CEN,k);
 %   Network_IND = IND(Global,Network_IND,k);
end
%PM_GMD_GT = PerfMeas_GT(Global,Network_GMD);
%PM_FDN_GT = PerfMeas_GT(Global,Network_FDN);
%PM_OPT_GT = PerfMeas_GT(Global,Network_OPT);
%PM_GCF_GT = PerfMeas_GT(Global,Network_GCF);
%PM_CEN_GT = PerfMeas_GT(Global,Network_CEN);
%PM_IND_GT = PerfMeas_GT(Global,Network_IND);

PM_GMD_CEN = PerfMeas_CEN(Global,Network_GMD,Network_CEN);
PM_GCF_CEN = PerfMeas_CEN(Global,Network_GCF,Network_CEN);
%PM_OPT_CEN = PerfMeas_CEN(Global,Network_OPT,Network_CEN);


%PM_GMD_CEN.BCS
%PM_GMD_CEN.HEL
%PM_GMD_CEN.meanBCS
%PM_GMD_CEN.meanHEL
%% Analysis
%Mutual Information(MI) between FDN and GMD
%P_FDN_N1 = Network_FDN.Node(1).Post;
%P_FDN_N2 = Network_FDN.Node(2).Post;
%P_GMD_N1 = Network_GMD.Node(1).Post;
%P_GMD_N2 = Network_GMD.Node(2).Post;

%plot(P_FDN_N1(1,:)-P_GMD_N1(1,:));hold;plot(P_FDN_N2(1,:)-P_GMD_N2(1,:));
%% PLOT
% figure;
% subplot(311);
% hold on;
% plot(PM_GMD_GT.Node(1).Post_Entropy(1:end-1))
% plot(PM_GMD_GT.Node(1).Prior_Entropy(2:end))
% legend('Post','Prior')
% 
% subplot(312);
% hold on;
% plot(PM_GMD_GT.Node(2).Post_Entropy(1:end-1))
% plot(PM_GMD_GT.Node(2).Prior_Entropy(2:end))
% legend('Post','Prior')
% 
% subplot(313);
% hold on;
% plot(PM_GMD_GT.Node(1).Post_Entropy(1:end-1)+PM_GMD_GT.Node(2).Post_Entropy(1:end-1))
% plot(PM_GMD_GT.Node(1).Prior_Entropy(2:end)+PM_GMD_GT.Node(2).Prior_Entropy(2:end))
% legend('Post','Prior')




figure
subplot(321)
for i = 1: size(Network.isConnected,2)
    if Network.isConnected(i)==1
        patch([i-1 i i i-1],[1 1 0.96 0.96],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
gm = plot(PM_GMD_CEN.BCS(1,:),'*-'); hold on ; cf = plot(PM_GCF_CEN.BCS(1,:),'*-'); hold on; %plot(Network.isConnected(1,:),'.k');
xlabel('step')
ylabel('BC distance')
legend([gm,cf],'N1_{GMD}','N1_{GCF}')


subplot(323)
for i = 1: size(Network.isConnected,2)
    if Network.isConnected(i)==1
        patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
gm = plot(PM_GMD_CEN.BCS(2,:),'*-'); hold on ; cf=plot(PM_GCF_CEN.BCS(2,:),'*-'); hold on
xlabel('step')
ylabel('BC distance')
legend([gm,cf],'N2_{GMD}','N2_{GCF}')

subplot(325)
for i = 1: size(Network.isConnected,2)
    if Network.isConnected(i)==1
        patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
gm = plot(PM_GMD_CEN.BCS(3,:),'*-'); hold on ; cf=plot(PM_GCF_CEN.BCS(3,:),'*-'); hold on
xlabel('step')
ylabel('BC distance')
legend([gm,cf],'N3_{GMD}','N3_{GCF}')

subplot(322)
for i = 1: size(Network.isConnected,2)
    if Network.isConnected(i)==1
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_CEN.Node(1).Post;
b=Network_GMD.Node(1).Post;
c=Network_GCF.Node(1).Post;
gm=plot(a(1,:),'*-'); hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-');
xlabel('step')
ylabel('CEN')
legend([gm,cf,cf2],'CEN Post_1','GMD Post_1','GCF Post_1')

subplot(324)
for i = 1: size(Network.isConnected,2)
    if Network.isConnected(i)==1
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_CEN.Node(2).Post;
b=Network_GMD.Node(2).Post;
c=Network_GCF.Node(2).Post;
gm=plot(a(1,:),'*-'); hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-');
xlabel('step')
ylabel('CEN')
legend([gm,cf,cf2],'CEN Post_2','GMD Post_2','GCF Post_2')

subplot(326)
for i = 1: size(Network.isConnected,2)
    if Network.isConnected(i)==1
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_CEN.Node(3).Post;
b=Network_GMD.Node(3).Post;
c=Network_GCF.Node(3).Post;
gm=plot(a(1,:),'*-'); hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-');
xlabel('step')
ylabel('CEN')
legend([gm,cf,cf2],'CEN Post_3','GMD Post_3','GCF Post_3')

% close all
% temp = Network.ProbOfLinkFail;
% temp(temp==0)=nan;
% figure
% subplot(211)
% plot(PM_GMD_CEN.BCS(1,:),'-o',...
%                 'LineWidth',2,...
%                'MarkerSize',7); hold on;
% plot(PM_OPT_CEN.BCS(1,:),'-o',...
%                 'LineWidth',2,...
%                 'MarkerSize',7); hold on;
% plot(PM_GCF_CEN.BCS(1,:),'-o',...
%                 'LineWidth',2,...
%                 'MarkerSize',7); hold on;
% 
% plot(temp,'LineWidth',2); hold on;
% legend('N1_GMD','N1_OPT','N1_GCF','DISCON')
% grid on ;grid minor;
%  
% 
% subplot(212)
% plot(PM_GMD_CEN.BCS(2,:),'-o',...
%                 'LineWidth',2,...
%                 'MarkerSize',7); hold on;
% plot(PM_OPT_CEN.BCS(2,:),'-o',...
%                 'LineWidth',2,...
%                 'MarkerSize',7); hold on;
% plot(PM_GCF_CEN.BCS(2,:),'-o',...
%                 'LineWidth',2,...
%                 'MarkerSize',7); hold on;
% 
% plot(temp,'LineWidth',2); hold on;
% legend('N1_GMD','N1_OPT','N1_GCF','DISCON')
% grid on ;grid minor;






