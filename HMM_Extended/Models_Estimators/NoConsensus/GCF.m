function [Network] = GCF(HMM,Network,k)
% Generalized Conservative Fusion(#6)
    for i = 1:Network.NumNodes
        Network.Node(i).GCF_Est.Pred(:,k) = HMM.MotMdl'*Network.Node(i).GCF_Est.Prior(:,k);
        Network.Node(i).GCF_Est.Post(:,k) = Network.Node(i).GCF_Est.Pred(:,k).*Network.Node(i).ObsMdl(:,Network.Node(i).z(k));
        Network.Node(i).GCF_Est.Post(:,k) = Network.Node(i).GCF_Est.Post(:,k)/sum(Network.Node(i).GCF_Est.Post(:,k));
    end
    ConComps = Network.ConComps{k};
    for i = 1:size(ConComps,2)
        ConComp = ConComps{i};
        NumConNodes = size(ConComp,2);
        if NumConNodes > 1
            %% Optimization
            Cost = @(omega)KLDCostFuncGCF(omega,Network,k,ConComp);
            omega_0 = ones(NumConNodes,1)/NumConNodes;
            A = [];
            b = [];
            Aeq = ones(1,NumConNodes);
            beq = 1;
            lb = zeros(1,NumConNodes);
            ub = ones(1,NumConNodes);
            [omega,~] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub);
            %% Update
            Post = ones(size(Network.Node(ConComp(1)).GCF_Est.Prior(:,k)));
            for j = 1:NumConNodes
                Post = Post.*Network.Node(ConComp(j)).GCF_Est.Post(:,k).^omega(j);
            end
            Post = Post/sum(Post);
            for j = 1:NumConNodes
                Network.Node(ConComp(j)).GCF_Est.Post(:,k) = Post;
            end            
        end
    end
end