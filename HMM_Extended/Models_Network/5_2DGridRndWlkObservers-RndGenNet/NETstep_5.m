function [Network] = NETstep_5(Sim,HMM,Network,k)
    %% Make Observation and update observation model
    for i = 1:Network.NumNodes        
        Network.Node(i) = UpdateNodeMotion(Sim,Network.Node(i),k);
        Network.Node(i) = UpdateNodeObservation(Sim.World,Network.Node(i),HMM.TrueStates(k),k);
        Network.Node(i).ObsMdl = GenNodeObsMdl(Sim.World,Network.Node(i),k);
        Network.Node(i).ObsMdlHist(:,:,k) = Network.Node(i).ObsMdl;
    end
    %% Update Network connectivity graph at time k stored in Network.graph{k}
    if k == 1 || mod(k,Network.ConnectivityPeriod) == 0
        Network.graph{k} = RGfromRingLattice(Network.RG_RngLat,Sim.RG_beta);
    %% Find and store the connected components of Network.graph{k}
        ConComps = conncomp(Network.graph{k},'OutputForm','cell');
        Network.ConComps{k} = ConComps;
    else
        Network.graph{k} = Network.graph{k-1};
        Network.ConComps{k} = Network.ConComps{k-1};
    end
end