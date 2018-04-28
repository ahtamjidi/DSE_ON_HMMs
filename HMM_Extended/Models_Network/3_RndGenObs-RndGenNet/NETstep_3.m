function [Network] = NETstep_3(Sim,HMM,Network,k)
    %% Make Observation 
    [Network] = ObservHMM(Sim,HMM,Network,k);
    %% Update Network connectivity graph at time k stored in Network.graph{k}
    if k == 1 || mod(k,Network.ConnectivityPeriod) == 0 
        Network.graph{k} = RewireRingLattice(Network.WS_RL,Network.WS_beta);
    %% Find and store the connected components of Network.graph{k,1}
        ConComps = conncomp(Network.graph{k},'OutputForm','cell');
        Network.ConComps{k} = ConComps;        
    else
        Network.graph{k} = Network.graph{k-1};
        Network.ConComps{k} = Network.ConComps{k-1};
    end
end