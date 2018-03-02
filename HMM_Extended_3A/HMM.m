clearvars;
close all;
clc;
rng(1458);
%% Initilization
%Globals vars and the Field
Global.T = 27*3;
Global.MotMdl = [.25 .75; .65 .35; ];
Global.NumStates = size(Global.MotMdl,1);
initState = 1;
%Network
Network.NumNodes = 3;
Network.Node(1).ObsMdl = [5/6, 1/6;3/12, 9/12];
Network.Node(2).ObsMdl = [4/6, 2/6;4/12, 8/12];
Network.Node(3).ObsMdl = [4/6, 2/6;4/12, 8/12];
%Network.Node(3).ObsMdl = [0.95, 0.05;0.05, 0.95];

Network.ProbOfLinkFail = [0 0 1 1 0 0 1 1 0 0 0 0 1 1 0 0 0 1 1 1 1 1 1 1 1 0 0
                          0 0 1 1 0 0 1 1 0 1 1 0 0 0 0 0 0 1 1 1 1 1 1 1 1 0 0
                          0 0 1 1 0 0 0 0 0 1 1 0 1 1 0 0 0 0 0 0 0 1 1 1 1 0 0];

[Network,Global.GT] = HMM_SimpleSampling(Global.T,Global.MotMdl,initState,Network);

for i = 1:Network.NumNodes
    Network.Node(i).Prior = zeros(2,Global.T);
    Network.Node(i).Prior(initState,1) = 1;
end
%% Simulations
Network_GMD = Network;
Network_GCF = Network;
Network_CEN = Network;
Network_GST = Network;
for k=1:Global.T
    if k~=1
        for i = 1:Network.NumNodes
            Network_GMD.Node(i).Prior(:,k) = Network_GMD.Node(i).Post(:,k-1);
            Network_GCF.Node(i).Prior(:,k) = Network_GCF.Node(i).Post(:,k-1);
            Network_CEN.Node(i).Prior(:,k) = Network_CEN.Node(i).Post(:,k-1);
            Network_GST.Node(i).Prior(:,k) = Network_GST.Node(i).Post(:,k-1);
        end
    end
    Network_GMD = GMD(Global,Network_GMD,k);
    Network_GCF = GCF(Global,Network_GCF,k);
    Network_CEN = CEN(Global,Network_CEN,k);
    Network_GST = GST(Global,Network_GST,k);
end

PM_GMD_CEN = PerfMeas_CEN(Global,Network_GMD,Network_CEN);
PM_GCF_CEN = PerfMeas_CEN(Global,Network_GCF,Network_CEN);
PM_GMD_GST = PerfMeas_GST(Global,Network_GMD,Network_GST);
PM_GCF_GST = PerfMeas_GST(Global,Network_GCF,Network_GST);
%% PLOT CEN 
figure
subplot(321)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
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
    if any(Network.isConnected(:,i)==1)
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
    if any(Network.isConnected(:,i)==1)
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
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_CEN.Node(1).Post;
b=Network_GMD.Node(1).Post;
c=Network_GCF.Node(1).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('CEN')
legend([gm,cf,cf2],'CEN Post_1','GMD Post_1','GCF Post_1')

subplot(324)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_CEN.Node(2).Post;
b=Network_GMD.Node(2).Post;
c=Network_GCF.Node(2).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('CEN')
legend([gm,cf,cf2],'CEN Post_2','GMD Post_2','GCF Post_2')

subplot(326)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_CEN.Node(3).Post;
b=Network_GMD.Node(3).Post;
c=Network_GCF.Node(3).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('CEN')
legend([gm,cf,cf2],'CEN Post_3','GMD Post_3','GCF Post_3')

%% PLOT CEN2 
figure
subplot(321)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0.96 0.96],'g','EdgeColor','none','FaceAlpha',.5);
    end   
end
hold on;
gm = plot(PM_GMD_CEN.ProjMetric(1,:),'*-'); hold on ; cf = plot(PM_GCF_CEN.ProjMetric(1,:),'*-'); hold on; %plot(Network.isConnected(1,:),'.k');
xlabel('step')
ylabel('ProjMetric')
legend([gm,cf],'N1_{GMD}','N1_{GCF}')


subplot(323)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
gm = plot(PM_GMD_CEN.ProjMetric(2,:),'*-'); hold on ; cf=plot(PM_GCF_CEN.ProjMetric(2,:),'*-'); hold on
xlabel('step')
ylabel('ProjMetric')
legend([gm,cf],'N2_{GMD}','N2_{GCF}')

subplot(325)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
gm = plot(PM_GMD_CEN.ProjMetric(3,:),'*-'); hold on ; cf=plot(PM_GCF_CEN.ProjMetric(3,:),'*-'); hold on
xlabel('step')
ylabel('ProjMetric')
legend([gm,cf],'N3_{GMD}','N3_{GCF}')

subplot(322)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_CEN.Node(1).Post;
b=Network_GMD.Node(1).Post;
c=Network_GCF.Node(1).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('CEN')
legend([gm,cf,cf2],'CEN Post_1','GMD Post_1','GCF Post_1')

subplot(324)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_CEN.Node(2).Post;
b=Network_GMD.Node(2).Post;
c=Network_GCF.Node(2).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('CEN')
legend([gm,cf,cf2],'CEN Post_2','GMD Post_2','GCF Post_2')

subplot(326)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_CEN.Node(3).Post;
b=Network_GMD.Node(3).Post;
c=Network_GCF.Node(3).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('CEN')
legend([gm,cf,cf2],'CEN Post_3','GMD Post_3','GCF Post_3')

%% PLOT GST 
figure
subplot(321)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0.96 0.96],'g','EdgeColor','none','FaceAlpha',.5);
    end   
end
hold on;
gm = plot(PM_GMD_GST.BCS(1,:),'*-'); hold on ; cf = plot(PM_GCF_GST.BCS(1,:),'*-'); hold on; %plot(Network.isConnected(1,:),'.k');
xlabel('step')
ylabel('BC distance')
legend([gm,cf],'N1_{GMD}','N1_{GCF}')


subplot(323)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
gm = plot(PM_GMD_GST.BCS(2,:),'*-'); hold on ; cf=plot(PM_GCF_GST.BCS(2,:),'*-'); hold on
xlabel('step')
ylabel('BC distance')
legend([gm,cf],'N2_{GMD}','N2_{GCF}')

subplot(325)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
gm = plot(PM_GMD_GST.BCS(3,:),'*-'); hold on ; cf=plot(PM_GCF_GST.BCS(3,:),'*-'); hold on
xlabel('step')
ylabel('BC distance')
legend([gm,cf],'N3_{GMD}','N3_{GCF}')

subplot(322)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_GST.Node(1).Post;
b=Network_GMD.Node(1).Post;
c=Network_GCF.Node(1).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('GST')
legend([gm,cf,cf2],'GST Post_1','GMD Post_1','GCF Post_1')

subplot(324)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_GST.Node(2).Post;
b=Network_GMD.Node(2).Post;
c=Network_GCF.Node(2).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('GST')
legend([gm,cf,cf2],'GST Post_2','GMD Post_2','GCF Post_2')

subplot(326)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_GST.Node(3).Post;
b=Network_GMD.Node(3).Post;
c=Network_GCF.Node(3).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('GST')
legend([gm,cf,cf2],'GST Post_3','GMD Post_3','GCF Post_3')

%% PLOT GST 2
figure
subplot(321)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0.96 0.96],'g','EdgeColor','none','FaceAlpha',.5);
    end   
end
hold on;
gm = plot(PM_GMD_GST.ProjMetric(1,:),'*-'); hold on ; cf = plot(PM_GCF_GST.ProjMetric(1,:),'*-'); hold on; %plot(Network.isConnected(1,:),'.k');
xlabel('step')
ylabel('ProjMetric')
legend([gm,cf],'N1_{GMD}','N1_{GCF}')


subplot(323)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
gm = plot(PM_GMD_GST.ProjMetric(2,:),'*-'); hold on ; cf=plot(PM_GCF_GST.ProjMetric(2,:),'*-'); hold on
xlabel('step')
ylabel('ProjMetric')
legend([gm,cf],'N2_{GMD}','N2_{GCF}')

subplot(325)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
gm = plot(PM_GMD_GST.ProjMetric(3,:),'*-'); hold on ; cf=plot(PM_GCF_GST.ProjMetric(3,:),'*-'); hold on
xlabel('step')
ylabel('ProjMetric')
legend([gm,cf],'N3_{GMD}','N3_{GCF}')

subplot(322)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_GST.Node(1).Post;
b=Network_GMD.Node(1).Post;
c=Network_GCF.Node(1).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('GST')
legend([gm,cf,cf2],'GST Post_1','GMD Post_1','GCF Post_1')

subplot(324)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_GST.Node(2).Post;
b=Network_GMD.Node(2).Post;
c=Network_GCF.Node(2).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('GST')
legend([gm,cf,cf2],'GST Post_2','GMD Post_2','GCF Post_2')

subplot(326)
for i = 1: size(Network.isConnected,2)
    if any(Network.isConnected(:,i)==1)
        patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
    end
end
hold on;
a=Network_GST.Node(3).Post;
b=Network_GMD.Node(3).Post;
c=Network_GCF.Node(3).Post;
 hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
xlabel('step')
ylabel('GST')
legend([gm,cf,cf2],'GST Post_3','GMD Post_3','GCF Post_3')


