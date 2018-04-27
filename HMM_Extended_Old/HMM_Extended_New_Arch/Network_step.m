function [Network] = Network_step(Network,k)
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
    %% Update ConHist
    % At time k node i has the observations of node j up to the time given by Network.ConHist(i,j,k)
    if k ~= 1 
        % Initialize Network.ConHist for time k from time k-1
        Network.ConHist(:,:,k) = Network.ConHist(:,:,k-1);
        % Update the diagonal terms (each node has its own observation at least time k)
        Network.ConHist(:,:,k) = Network.ConHist(:,:,k)+eye(Network.NumNodes,Network.NumNodes);
    end
    for i = 1:size(ConComps,2)
        NumConNodes = size(ConComps{i},2);
        if NumConNodes > 1
            % Set up ConHist such that the i'th node observations are available 
            % to the connected component from start until the time in ConHist(i)
            ConHist = max(Network.ConHist(ConComps{i},:,k));
            Network.ConHist(ConComps{i},:,k) = repmat(ConHist,NumConNodes,1);
        end
    end
    %% Update the estimators' priors based on the previous step posteriors
    if k~=1
        for i = 1:Network.NumNodes
            Network.Node(i).GMD_Est.Prior(:,k) = Network.Node(i).GMD_Est.Post(:,k-1);
            Network.Node(i).GCF_Est.Prior(:,k) = Network.Node(i).GCF_Est.Post(:,k-1);
            Network.Node(i).FHS_Est.Prior(:,k) = Network.Node(i).FHS_Est.Post(:,k-1);
        end
    end
end