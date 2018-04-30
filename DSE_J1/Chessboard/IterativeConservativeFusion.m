function Network = IterativeConservativeFusion(Network,Method,k)
    switch Method
        case 'GMD'
            Network = NGMD_ICF(Network,k);
        case 'GCF'
            Network = NGCF_ICF(Network,k);
        case 'VGMD'
            Network = NGMD_VICF(Network,k);
        case 'VGCF'
            Network = NGCF_VICF(Network,k);            
    end
end
function Network = NGMD_ICF(Network,k)
    % initialzie consensus variables
    for iConsensus=1:Network.ConsensusIter
        for iNode=1:Network.NumOfNodes
            if iConsensus ==1
                Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus) = Network.Node(iNode).Prior(:,k);
            else
                % gather local information
                iNeighbours = find(Network.Graph.Adj(iNode,:));
                LocalNetwork = Network.Node(iNeighbours);
                ICF =  LocalConservativeFusion(LocalNetwork,iConsensus,'NGMD_ICF',k, Network.Graph,iNeighbours,iNode);
                if ~isempty(ICF)
                    ICF = Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus-1);
                end
                Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus) = ICF;
            end
        end
    end
    
    for iNode=1:Network.NumOfNodes
        Network.Node(iNode).Prior(:,k) = Network.Node(iNode).ConsesnsusData(k).ICF(:,Network.ConsensusIter);
    end

end

function Network = NGMD_VICF(Network,k)
    % initialzie consensus variables
    for iConsensus=1:Network.ConsensusIter
        for iNode=1:Network.NumOfNodes
            if iConsensus ==1
                Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus) = Network.Node(iNode).Prior(:,k);
            else
                % gather local information
                iNeighbours = find(Network.Graph.Adj(iNode,:));
                LocalNetwork = Network.Node(iNeighbours);
                ICF =  LocalConservativeFusion(LocalNetwork,iConsensus,'NGMD_VICF',k, Network.Graph,iNeighbours,iNode);
                if ~isempty(ICF)
                    ICF = Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus-1);
                end
                Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus) = ICF;
            end
        end
    end
    
    for iNode=1:Network.NumOfNodes
        Network.Node(iNode).Prior(:,k) = Network.Node(iNode).ConsesnsusData(k).ICF(:,Network.ConsensusIter);
    end
end


        
function Network = NGCF_ICF(Network,k)
    % initialzie consensus variables
    for iConsensus=1:Network.ConsensusIter
        for iNode=1:Network.NumOfNodes
            if iConsensus ==1
                Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus) = Network.Node(iNode).Post(:,k);
            else
                % gather local information
                iNeighbours = find(Network.Graph.Adj(iNode,:));
                LocalNetwork = Network.Node(iNeighbours);
                ICF =  LocalConservativeFusion(LocalNetwork,iConsensus,'NGCF_ICF',k, Network.Graph,iNeighbours,iNode);
                if ~isempty(ICF)
                    ICF = Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus-1);
                end
                Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus) = ICF;
            end
        end
    end
end

function Network = NGCF_VICF(Network,k)
    % initialzie consensus variables
    for iConsensus=1:Network.ConsensusIter
        for iNode=1:Network.NumOfNodes
            if iConsensus ==1
                Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus) = Network.Node(iNode).Post(:,k);
            else
                % gather local information
                iNeighbours = find(Network.Graph.Adj(iNode,:));
                LocalNetwork = Network.Node(iNeighbours);
                ICF =  LocalConservativeFusion(LocalNetwork,iConsensus,'NGCF_VICF',k, Network.Graph,iNeighbours,iNode);
                if ~isempty(ICF)
                    ICF = Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus-1);
                end
                Network.Node(iNode).ConsesnsusData(k).ICF(:,iConsensus) = ICF;
            end
        end
    end
end
