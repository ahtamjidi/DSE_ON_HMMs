function [Network] = NETinit_3(Sim,HMM)
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
    DiagRng = repmat([0.8 0.95],Network.NumNodes,1);    
    for i = 1:Network.NumNodes
        Network.Node(i).ObsMdl = RndStMat(HMM.NumStates,DiagRng(i,:));
    end
    %% Ring lattice for Watts Strogatz small world network
    Network.ConHist(:,:,1) = eye(Network.NumNodes); 
    Network.ConnectivityPeriod = Sim.ConnectivityPeriod;
    Network.WS_beta = Sim.WS_beta;
    Network.WS_RL = RingLattice(Sim.NumNodes,Sim.WS_K);
    Network.WS_graph = RewireRingLattice(Network.WS_RL,Network.WS_beta);
    Network.WS_MinSpanTree = minspantree(Network.WS_graph);
end