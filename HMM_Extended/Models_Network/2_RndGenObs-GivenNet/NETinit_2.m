function [Network] = NETinit_2(Sim,HMM)
    [Network] = NETinit(Sim,HMM);
    %% Nodes observation models (constant over time)
    DiagRng = repmat([0.6 0.7],Network.NumNodes,1);
    DiagRng(1,:) = [0.6 0.7];
    DiagRng(2,:) = [0.6 0.75];
    DiagRng(3,:) = [0.6 0.7];
    DiagRng(4,:) = [0.6 0.75];
    for i = 1:Network.NumNodes
        Network.Node(i).ObsMdl = RndStMat(HMM.NumStates,Sim.ObsMdlDiagRng(i,:));
    end
    %% Manually set network connectivity over time
    Network.ConHist(:,:,1) = eye(Network.NumNodes);    
    Network.Connectivity = Sim.NetConnectivity;
end