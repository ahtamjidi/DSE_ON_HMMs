function [Network] = ICFwConsensus(Sim,HMM,Network,k)
    AdjMat = Network.graph{k}.adjacency;
    Graph = generate_graph(AdjMat);
    %% Local Posteriors
    for i  = 1:Network.NumNodes
        Network.Node(i).ICF_Est.Pred(:,k) =  HMM.MotMdl'*Network.Node(i).ICF_Est.Prior(:,k);
        Network.Node(i).Likelihood(:,k) = Network.Node(i).ObsMdl(:,Network.Node(i).z(k));
        post =  Network.Node(i).ICF_Est.Pred(:,k).*Network.Node(i).Likelihood(:,k);
        post = post./sum(post);
        Network.Node(i).ICF_Est.Post(:,k) = post;
    end
    %% Iterative Conservative Fusion of Posteriors
    for iConsensus=1:Sim.ConsensusIter
        for iNode=1:Network.NumNodes
            if iConsensus ==1
                Network.Node(iNode).ICF_Est.ConsesnsusData(k).ICF(:,iConsensus) = Network.Node(iNode).ICF_Est.Post(:,k);
            else
%                 iNeighbours = find(Network.Graph.Adj(iNode,:));
                iNeighbours = find(AdjMat(iNode,:)~=0);
                LocalNetwork = Network.Node(iNeighbours);
                if Sim.EstDoOpt
                    ICF =  LocalConservativeFusionOpt(LocalNetwork,iConsensus,'NGCF_ICF',k);
                else
                    ICF = LocalConservativeFusionNoOpt(LocalNetwork,iConsensus,'NGCF_ICF',k, Graph, iNeighbours, iNode);
                end                                
                if isempty(ICF)
                    ICF = Network.Node(iNode).ICF_Est.ConsesnsusData(k).ICF(:,iConsensus-1);
                end
                Network.Node(iNode).ICF_Est.ConsesnsusData(k).ICF(:,iConsensus) = ICF;
            end
        end
    end
    %% Updating the local Posteriors with the Consesnsus
    for i  = 1:Network.NumNodes
        post =  Network.Node(i).ICF_Est.ConsesnsusData(k).ICF(:,end);
        post = post./sum(post);
        Network.Node(i).ICF_Est.Post(:,k) = post;
    end
end