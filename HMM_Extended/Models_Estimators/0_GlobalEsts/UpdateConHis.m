function [Network] = UpdateConHis(Network,k)
    % At time k node i has the observations of node j up to the time given by Network.ConHist(i,j,k)    
     ConComps = Network.ConComps{k};    
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
end