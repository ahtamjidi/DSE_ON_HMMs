function Network = IterativeConsensus(Network,Method,k)
switch Method
    case 'GMD'
        % initialzie consensus variables
        for iConsensus=1:Network.ConsensusIter
            for iNode=1:Network.NumOfNodes
                if iConsensus ==1
                    Network.Node(iNode).ConsesnsusData(k).IC(:,iConsensus) = log(Network.Node(iNode).Likelihood(:,k));
                else
                    % gather local information
                    iNeighbours = find(Network.Graph.Adj(iNode,:));
                    LocalNetwork = Network.Node(iNeighbours);
                    IC =  ConsensusMessagingProtocol(LocalNetwork,iConsensus,'UND',k,Network.Graph,iNeighbours,iNode);
                    Network.Node(iNode).ConsesnsusData(k).IC(:,iConsensus) = IC;
                end
            end
        end
end
end

