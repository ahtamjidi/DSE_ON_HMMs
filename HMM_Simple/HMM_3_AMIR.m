clear;
clc;
close all
    clear;
    clc;
%% Initilization
    %Globals vars and the Field
    Global.T = 300;
    Global.MotMdl = [.7 .3; .05 .95;];
    %Network
    Network.NumNodes = 2;
    Network.Node(1).ObsMdl = [5/6, 1/6;3/12, 9/12];
    Network.Node(2).ObsMdl = [4/6, 2/6;4/12, 8/12];
    [z_a,x_t] = hmmgenerate(Global.T,Global.MotMdl,Network.Node(1).ObsMdl);
    Global.GT = x_t;
    Network.Node(1).z = z_a;
    
    for i = 2:Network.NumNodes
        Network.Node(i).Pred = zeros(2,Global.T);
        Network.Node(i).Post = zeros(2,Global.T);
        Network.Node(i).z = zeros(1,Global.T);
        for k=1:Global.T
           if rand <= Network.Node(i).ObsMdl(Global.GT(k),1)
               Network.Node(i).z(1,k) = 1;
           else
               Network.Node(i).z(1,k) = 2;
           end
        end
        Network.omega(i) = 1/Network.NumNodes;
    end
    Network.isConnected = ones(Global.T,1);
     Network.isConnected(1) = 1;
     Network.isConnected(5) = 1;
     Network.isConnected(10) = 1;
     Network.isConnected(45) = 1;
    for i = 1:Network.NumNodes        
        Network.Node(i).Prior = [1;0];
    end
%% Simulation
    %GMD
    Network_GMD = Network;
    for k=1:Global.T
        if k~=1
            for i = 1:Network.NumNodes  
                Network_GMD.Node(i).Prior = Network_GMD.Node(i).Post(:,k-1);
            end
        end
        Network_GMD = GMD(Global,Network_GMD,k);
    end
    PM_GMD_GT = PerfMeas_GT(Global,Network_GMD);
    
    %FDN: Fully Disconnected Netwrok
    Network_FDN = Network;
    for k=1:Global.T
        if k~=1
            for i = 1:Network.NumNodes
                Network_FDN.Node(i).Prior = Network_FDN.Node(i).Post(:,k-1);
            end
        end
        Network_FDN = FDN(Global,Network_FDN,k);
    end
    PM_FDN_GT = PerfMeas_GT(Global,Network_FDN);
    
    %GCF
    Network_GCF = Network;
    for k=1:Global.T
        if k~=1
            for i = 1:Network.NumNodes
                Network_GCF.Node(i).Prior = Network_GCF.Node(i).Post(:,k-1);
            end
        end
        Network_GCF = GCF(Global,Network_GCF,k);
    end
    PM_GCF_GT = PerfMeas_GT(Global,Network_GCF);
%% PLOT
    PM_GMD_GT
    PM_FDN_GT
    PM_GCF_GT

figure;
subplot(211); plot(PM_GMD_GT.Node(1).Post_Entropy)
hold on; plot(PM_FDN_GT.Node(1).Post_Entropy)
plot(PM_GCF_GT.Node(1).Post_Entropy)


subplot(212); plot(PM_GMD_GT.Node(2).Post_Entropy)
hold on; plot(PM_FDN_GT.Node(2).Post_Entropy)
plot(PM_GCF_GT.Node(2).Post_Entropy)
