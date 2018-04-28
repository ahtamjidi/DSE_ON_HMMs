function [Network] = NETstep_2(Sim,HMM,Network,k)
    %% Make Observation 
    [Network] = ObserveHMM(Sim,HMM,Network,k);
    %% Update Network connectivity graph at time k stored in Network.graph{k}
    NumConComps = max(Network.Connectivity(:,k));
    for i = 1:NumConComps
        ConComp = find(Network.Connectivity(:,k) == i)';
        if size(ConComp,2) > 1
            Network.graph{k} = addedge(Network.graph{k},ConComp(1)*ones(1,size(ConComp,2)-1),ConComp(2:end) ); 
        end
    end
    %% Find and store the connected components of Network.graph{k,1}
    ConComps = conncomp(Network.graph{k},'OutputForm','cell');
    Network.ConComps{k} = ConComps;
end