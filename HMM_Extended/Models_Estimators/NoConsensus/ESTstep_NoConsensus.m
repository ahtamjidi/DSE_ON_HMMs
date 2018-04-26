function [Network] = ESTstep_NoConsensus(Sim,HMM,Network,k)
    %% Update the estimators' priors based on the previous step posteriors
    if k~=1
        for i = 1:Network.NumNodes
            Network.Node(i).GMD_Est.Prior(:,k) = Network.Node(i).GMD_Est.Post(:,k-1);
            Network.Node(i).GCF_Est.Prior(:,k) = Network.Node(i).GCF_Est.Post(:,k-1);
            Network.Node(i).FHS_Est.Prior(:,k) = Network.Node(i).FHS_Est.Post(:,k-1);
        end
    end
    %% Update the estimators' posteriors 
    Network = GMD(Sim,HMM,Network,k);
    Network = GCF(Sim,HMM,Network,k);
    Network = FHS(Sim,HMM,Network,k);
%     Network_CEN = CEN(Global,Network_CEN,k);    
end