function [Network] = initNetwork(Sim,HMM)
    %% First and formost is the number of nodes!
    Network.NumNodes = 4;    
    %% Initializing a distributed estimator
    DistEst.Prior  = zeros(HMM.NumStates,Sim.EndTime); 
    DistEst.Pred   = zeros(HMM.NumStates,Sim.EndTime);
    DistEst.Post   = zeros(HMM.NumStates,Sim.EndTime); 
    DistEst.Prior(HMM.TrueStates(1,1),1) = 1;
    DistEst.omega = 1/Network.NumNodes;
    %% Building the network    
    for i = 1:Network.NumNodes
        Network.Node(i).z = zeros(1,Sim.EndTime);
        Network.Node(i).GMD_Est = DistEst;
        Network.Node(i).GCF_Est = DistEst;
        Network.Node(i).FHS_Est = DistEst;
    end
    for k = 1:Sim.EndTime
        Network.graph{k} = graph(zeros(Network.NumNodes)~=0);
        Network.ConComps{k} = {};
    end
    Network.ConHist(:,:,1) = eye(Network.NumNodes);
    
    %% Assign Network parameters manually for small networks
    Network.Node(1).ObsMdl = [5/6, 1/6;3/12, 9/12];
    Network.Node(2).ObsMdl = [4/6, 2/6;4/12, 8/12];
    Network.Node(3).ObsMdl = [4/6, 2/6;3/12, 9/12];
    Network.Node(4).ObsMdl = [0.95, 0.05;0.05, 0.95];
    
    Network.Connectivity = zeros(Network.NumNodes,Sim.EndTime);
    Network.Connectivity([1 2],5:9) = 1;
    Network.Connectivity([2 3],13:20) = 1;
    Network.Connectivity([1 3],30:35) = 1;
    Network.Connectivity([1 2 3],40:end-5) = 1;
    Network.Connectivity([1 4],18:25) = 1;
end