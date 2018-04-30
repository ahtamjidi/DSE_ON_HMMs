function [Network] = NETstep_4(Sim,HMM,Network,k)
    %% Make Observation and update observation model
    for i = 1:Network.NumNodes        
        Network.Node(i) = UpdateNodeMotion(Sim,Network.Node(i),k);
        Network.Node(i) = UpdateNodeObservation(Sim.World,Network.Node(i),HMM.TrueStates(k),k);
        Network.Node(i).ObsMdl = GenNodeObsMdl(Sim.World,Network.Node(i),k);
        Network.Node(i).ObsMdlHist(:,:,k) = Network.Node(i).ObsMdl;
    end
    %% Update Network connectivity graph at time k stored in Network.graph{k}
    NumConComps = max(Network.Connectivity(:,k));
    for i = 1:NumConComps
        ConComp = find(Network.Connectivity(:,k) == i)';
        if size(ConComp,2) > 1
%             Network.graph{k} = addedge(Network.graph{k},ConComp(1)*ones(1,size(ConComp,2)-1),ConComp(2:end) ); 
            Network.graph{k} = simplify(addedge(Network.graph{k},ConComp,circshift(ConComp,length(ConComp)-1) ),'keepselfloops'); 
        end
    end
    %% Find and store the connected components of Network.graph{k,1}
    ConComps = conncomp(Network.graph{k},'OutputForm','cell');
    Network.ConComps{k} = ConComps;
end