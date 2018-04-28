function [Network] = NETinit_3(Sim,HMM)
    [Network] = NETinit(Sim,HMM);
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