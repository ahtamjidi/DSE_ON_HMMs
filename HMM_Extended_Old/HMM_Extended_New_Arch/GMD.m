function [Network] = GMD(HMM,Network,k) % Our approach: Conservative fusion of priors + Consensus over current
    ConComps = Network.ConComps{k};
    for i = 1:size(ConComps,2)
    ConComp = ConComps{i};
	NumConNodes = size(ConComp,2);
        if NumConNodes == 1            
            Network.Node(ConComp).GMD_Est.Pred(:,k) = HMM.MotMdl'*Network.Node(ConComp).GMD_Est.Prior(:,k);
            Network.Node(ConComp).GMD_Est.Post(:,k) = Network.Node(ConComp).GMD_Est.Pred(:,k).*Network.Node(ConComp).ObsMdl(:,Network.Node(ConComp).z(1,k));
            Network.Node(ConComp).GMD_Est.Post(:,k) = Network.Node(ConComp).GMD_Est.Post(:,k)/sum(Network.Node(ConComp).GMD_Est.Post(:,k));
        else
            %% Optimization
            Cost = @(omega)KLDCostFuncGMD(omega,Network,k,ConComp);
            omega_0 = ones(NumConNodes,1)/NumConNodes;
            A = [];
            b = [];
            Aeq = ones(1,NumConNodes);
            beq = 1;
            lb = zeros(1,NumConNodes);
            ub = ones(1,NumConNodes);
            [omega] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub);  
            %% Update
            Prior = ones(size(Network.Node(1).GMD_Est.Prior(:,k)));
            for j = 1:NumConNodes
                Prior = Prior.*Network.Node(ConComp(j)).GMD_Est.Prior(:,k).^omega(j);
            end
            Prior = Prior/sum(Prior);

            Pred = HMM.MotMdl'*Prior;
            Post = Pred;
            for j = 1:NumConNodes
                Post = Post.*Network.Node(ConComp(j)).ObsMdl(:,Network.Node(ConComp(j)).z(1,k));
            end
            Post = Post/sum(Post);
            for j = 1:NumConNodes
                Network.Node(ConComp(j)).GMD_Est.Prior(:,k) = Prior;
                Network.Node(ConComp(j)).GMD_Est.Pred(:,k) = Pred;
                Network.Node(ConComp(j)).GMD_Est.Post(:,k) = Post;
            end            
        end
    end
end