function [Network] = NETinit_1(Sim,HMM)
    %% First and formost is the number of nodes!
    Network.NumNodes = Sim.NumNodes;
    %% Initializing an estimator
    Est.Prior  = zeros(HMM.NumStates,Sim.EndTime);
    Est.Pred   = zeros(HMM.NumStates,Sim.EndTime);
    Est.Post   = zeros(HMM.NumStates,Sim.EndTime);
    Est.Prior(:,1) = Sim.Prior0;
    Est.omega = 1/Network.NumNodes;
    %% Building the estimators and graphs
    for i = 1:Network.NumNodes
        Network.Node(i).z = zeros(1,Sim.EndTime);
        Network.Node(i).GMD_Est = Est;
        Network.Node(i).GCF_Est = Est;
        Network.Node(i).FHS_Est = Est;
    end
    for k = 1:Sim.EndTime
        Network.graph{k} = graph(zeros(Network.NumNodes)~=0);
        Network.ConComps{k} = {};
    end
    %% Nodes observation models (constant over time)
    Network.Node(1).ObsMdl = [5/6, 1/6;3/12, 9/12];
    Network.Node(2).ObsMdl = [4/6, 2/6;4/12, 8/12];
    Network.Node(3).ObsMdl = [4/6, 2/6;3/12, 9/12];
    Network.Node(4).ObsMdl = [0.95, 0.05;0.05, 0.95];
    
    %% Manually set network connectivity over time
    Network.ConHist(:,:,1) = eye(Network.NumNodes);    
    Network.Connectivity = Sim.NetConnectivity(1:Network.NumNodes,:);
end