function IC =  ConsensusMessagingProtocol(LocalNetwork,iConsensus,Method,k,Graph,iNeighbours,iNode)
IC = zeros(size(LocalNetwork(1).ConsesnsusData(k).IC(:,iConsensus-1)));
switch Method
    case 'UND' % undirected graph 
        for iNhbr = 1:length(iNeighbours)
            IC = IC +(Graph.p(iNode,iNeighbours(iNhbr)).*LocalNetwork(iNhbr).ConsesnsusData(k).IC(:,iConsensus-1));
        end
end