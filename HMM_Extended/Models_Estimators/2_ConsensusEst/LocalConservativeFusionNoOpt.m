function ICF = LocalConservativeFusionNoOpt(LocalNetwork,iConsensus,Method,k, Graph, iNeighbours, iNode)
    if isempty(LocalNetwork)
        ICF = [];
    else
        switch Method
            case 'NGMD_ICF'
                %% No Optimization
                Prior = ones(size(LocalNetwork(1).HYB_Est.Prior(:,k)));
                for iNhbr = 1:length(iNeighbours)
                    Prior = Prior.*LocalNetwork(iNhbr).HYB_Est.ConsesnsusData(k).ICF(:,iConsensus-1).^(Graph.p(iNode,iNeighbours(iNhbr)));
                end
                ICF = Prior/sum(Prior);
            case 'NGCF_ICF'
                %% Optimization
                Post = ones(size(LocalNetwork(1).ICF_Est.Post(:,k)));
                for iNhbr = 1:length(iNeighbours)
                    Post = Post.*LocalNetwork(iNhbr).ICF_Est.ConsesnsusData(k).ICF(:,iConsensus-1).^(Graph.p(iNode,iNeighbours(iNhbr)));
                end
                ICF = Post/sum(Post);
        end
    end
end