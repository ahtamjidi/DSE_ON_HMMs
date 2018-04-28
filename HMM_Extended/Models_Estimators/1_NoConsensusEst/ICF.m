function [Network] = ICF(Sim,HMM,Network,k)
% Generalized Conservative Fusion(#6)
    for i = 1:Network.NumNodes
        Network.Node(i).ICF_Est.Pred(:,k) = HMM.MotMdl'*Network.Node(i).ICF_Est.Prior(:,k);
        Network.Node(i).ICF_Est.Post(:,k) = Network.Node(i).ICF_Est.Pred(:,k).*Network.Node(i).ObsMdl(:,Network.Node(i).z(k));
        Network.Node(i).ICF_Est.Post(:,k) = Network.Node(i).ICF_Est.Post(:,k)/sum(Network.Node(i).ICF_Est.Post(:,k));
    end
    ConnComps = Network.ConComps{k};
    for i = 1:size(ConnComps,2)
        ConComp = ConnComps{i};
        NumConnNodes = size(ConComp,2);
        if NumConnNodes > 1
            %% Optimization
            if Sim.EstDoOpt
                Cost = @(omega)KLDCostFuncICF(omega,Network,k,ConComp);
                omega_0 = ones(NumConnNodes,1)/NumConnNodes;
                A = [];
                b = [];
                Aeq = ones(1,NumConnNodes);
                beq = 1;
                lb = zeros(1,NumConnNodes);
                ub = ones(1,NumConnNodes);
                [omega,~] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub,[],optimoptions('fmincon','Display','notify-detailed'));
            else
                omega = ones(NumConnNodes,1)/NumConnNodes; 
            end
            %% Update
            Post = ones(size(Network.Node(ConComp(1)).ICF_Est.Prior(:,k)));
            for j = 1:NumConnNodes
                Post = Post.*Network.Node(ConComp(j)).ICF_Est.Post(:,k).^omega(j);
            end
            Post = Post/sum(Post);
            for j = 1:NumConnNodes
                Network.Node(ConComp(j)).ICF_Est.Post(:,k) = Post;
            end            
        end
    end
end