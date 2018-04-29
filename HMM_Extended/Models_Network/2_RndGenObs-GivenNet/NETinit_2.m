function [Network] = NETinit_2(Sim,HMM)
    [Network] = NETinit(Sim,HMM);
    %% Nodes observation models (constant over time)
    for i = 1:Network.NumNodes
        Network.Node(i).ObsMdl = RndStMat(HMM.NumStates,Sim.ObsMdlDiagRng(i,:));
    end
    %% Manually set network connectivity over time
    Network.ConHist(:,:,1) = eye(Network.NumNodes);    
    Network.Connectivity = Sim.NetConnectivity;
end