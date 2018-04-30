function [Network] = ESTstep_2(Sim,HMM,Network,k)
    %% Update the 
    [Network.ConsWeightMat(:,:,k),Network.AdjMat] = EvalConsWeightMat(Network.graph{k});
    %% Update the estimators' priors based on the previous step posteriors
    if k~=1        
        Network.CEN_Est.Prior(:,k) = Network.CEN_Est.Post(:,k-1);
        for i = 1:Network.NumNodes
            Network.Node(i).HYB_Est.Prior(:,k) = Network.Node(i).HYB_Est.Post(:,k-1);
            Network.Node(i).ICF_Est.Prior(:,k) = Network.Node(i).ICF_Est.Post(:,k-1);
            Network.Node(i).FHS_Est.Prior(:,k) = Network.Node(i).FHS_Est.Post(:,k-1);
        end
    end
    %% Update the estimators' posteriors 
    Network = HYBwConsensus(Sim,HMM,Network,k);
    Network = ICFwConsensus(Sim,HMM,Network,k);
    Network = FHS(Sim,HMM,Network,k);
    Network = CEN(Sim,HMM,Network,k);
end