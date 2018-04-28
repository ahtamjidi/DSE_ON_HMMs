function [Network] = HYB(Sim,HMM,Network,k) % Our approach: Conservative fusion of priors + Consensus over current
    %% Update Estimator Posteriors
    ConComps = Network.ConComps{k};
    for i = 1:size(ConComps,2)
    ConnComp = ConComps{i};
	NumConnNodes = size(ConnComp,2);
        if NumConnNodes == 1
            %% Update disconnected components
            Network.Node(ConnComp).HYB_Est.Pred(:,k) = HMM.MotMdl'*Network.Node(ConnComp).HYB_Est.Prior(:,k);
            Network.Node(ConnComp).HYB_Est.Post(:,k) = Network.Node(ConnComp).HYB_Est.Pred(:,k).*Network.Node(ConnComp).ObsMdl(:,Network.Node(ConnComp).z(k));
            Network.Node(ConnComp).HYB_Est.Post(:,k) = Network.Node(ConnComp).HYB_Est.Post(:,k)/sum(Network.Node(ConnComp).HYB_Est.Post(:,k));
        else
            %% Optimization
            if Sim.EstDoOpt
                Cost = @(omega)KLDCostFuncHYB(omega,Network,k,ConnComp);
                omega_0 = ones(NumConnNodes,1)/NumConnNodes;
                A = [];
                b = [];
                Aeq = ones(1,NumConnNodes);
                beq = 1;
                lb = zeros(1,NumConnNodes);
                ub = ones(1,NumConnNodes);
                [omega] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub,[],optimoptions('fmincon','Display','notify-detailed'));
            else
                omega = ones(NumConnNodes,1)/NumConnNodes; 
            end
            %% Update connected components
            Prior = ones(size(Network.Node(1).HYB_Est.Prior(:,k)));
            for j = 1:NumConnNodes
                Prior = Prior.*Network.Node(ConnComp(j)).HYB_Est.Prior(:,k).^omega(j);
            end
            Prior = Prior/sum(Prior);

            Pred = HMM.MotMdl'*Prior;
            Post = Pred;
            for j = 1:NumConnNodes
                Post = Post.*Network.Node(ConnComp(j)).ObsMdl(:,Network.Node(ConnComp(j)).z(k));
            end
            Post = Post/sum(Post);
            for j = 1:NumConnNodes
                Network.Node(ConnComp(j)).HYB_Est.Prior(:,k) = Prior;
                Network.Node(ConnComp(j)).HYB_Est.Pred(:,k) = Pred;
                Network.Node(ConnComp(j)).HYB_Est.Post(:,k) = Post;
            end
        end
    end
end