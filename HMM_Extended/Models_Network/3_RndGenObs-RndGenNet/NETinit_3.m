function [Network] = NETinit_3(Sim,HMM)
    [Network] = NETinit(Sim,HMM);
    %% Nodes observation models (constant over time)
    for i = 1:Network.NumNodes
        Network.Node(i).ObsMdl = RndStMat(HMM.NumStates,Sim.ObsMdlDiagRng(i,:));
    end
    %% Ring lattice for Watts Strogatz small world network
    Network.ConHist(:,:,1) = eye(Network.NumNodes);
    Network.ConnectivityPeriod = Sim.ConnectivityPeriod;    
    Network.RG_RngLat = RingLattice(Sim.NumNodes,Sim.RG_k);    
end