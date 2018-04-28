function [Network] = HYBwConsensus(Sim,HMM,Network,k)
    AdjMat = Network.graph{k}.adjacency;
    Graph = generate_graph(AdjMat);
    %% iterative conservative fusion of priors
    for iConsensus=1:Sim.ConsensusIter
        for iNode=1:Network.NumNodes
            if iConsensus ==1
                Network.Node(iNode).HYB_Est.ConsesnsusData(k).ICF(:,iConsensus) = Network.Node(iNode).HYB_Est.Prior(:,k);
            else
%                 iNeighbours = find(Network.Graph.Adj(iNode,:));
                iNeighbours = find(AdjMat(iNode,:)~=0);
                LocalNetwork = Network.Node(iNeighbours);
                if Sim.EstDoOpt
                    ICF =  LocalConservativeFusionOpt(LocalNetwork,iConsensus,'NGMD_ICF',k);
                else
                    ICF = LocalConservativeFusionNoOpt(LocalNetwork,iConsensus,'NGMD_ICF',k, Graph, iNeighbours, iNode);
                end
                if isempty(ICF)
                    ICF = Network.Node(iNode).HYB_Est.ConsesnsusData(k).ICF(:,iConsensus-1);
                end
                Network.Node(iNode).HYB_Est.ConsesnsusData(k).ICF(:,iConsensus) = ICF;
            end
        end
    end    
    %% Prediction and Likelihood
    for i = 1:Network.NumNodes
        Network.Node(i).HYB_Est.Prior(:,k)= Network.Node(i).HYB_Est.ConsesnsusData(k).ICF(:,end);
        Network.Node(i).HYB_Est.Pred(:,k) =  HMM.MotMdl'*Network.Node(i).HYB_Est.Prior(:,k);
        Network.Node(i).Likelihood(:,k) = Network.Node(i).ObsMdl(:,Network.Node(i).z(k));
    end
    %% iterative consensus
    for iConsensus=1:Sim.ConsensusIter
        for iNode=1:Network.NumNodes
            if iConsensus == 1
                Network.Node(iNode).HYB_Est.ConsesnsusData(k).IC(:,iConsensus) = log(Network.Node(iNode).Likelihood(:,k));
            else
%                 iNeighbours = find(Network.Graph.Adj(iNode,:));
                iNeighbours = find(AdjMat(iNode,:)~=0);
                LocalNetwork = Network.Node(iNeighbours);              
                IC = zeros(size(LocalNetwork(1).HYB_Est.ConsesnsusData(k).IC(:,iConsensus-1)));
                for iNhbr = 1:length(iNeighbours)
                    IC = IC +(Graph.p(iNode,iNeighbours(iNhbr)).*LocalNetwork(iNhbr).HYB_Est.ConsesnsusData(k).IC(:,iConsensus-1));
                end
                Network.Node(iNode).HYB_Est.ConsesnsusData(k).IC(:,iConsensus) = IC;
            end
        end
    end
    %% update 
    size_comp = networkComponents(Graph.p);
    for i  = 1:Network.NumNodes
        post =  Network.Node(i).HYB_Est.Pred(:,k).* exp(size_comp(i)*Network.Node(i).HYB_Est.ConsesnsusData(k).IC(:,end));
        post = post./sum(post);
        Network.Node(i).HYB_Est.Post(:,k) = post;
    end
end