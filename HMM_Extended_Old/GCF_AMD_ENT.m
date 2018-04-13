function [Network] = GCF_AMD_ENT(Global,Network,k)
% Generalized Conservative Fusion(#6)
    for i = 1:Network.NumNodes
        Network.Node(i).Pred(:,k) = Global.MotMdl'*Network.Node(i).Prior(:,k);
        Network.Node(i).Post(:,k) = Network.Node(i).Pred(:,k).*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
        Network.Node(i).Post(:,k) = Network.Node(i).Post(:,k)/sum(Network.Node(i).Post(:,k));
    end
    if Network.isConnected(k) ~= 1
    else
    %% Optimization
        Cost = @(omega)EntropyCostFuncGCF_AMD(omega,Network,k);
%         Cost = @(omega)KLDCostFuncGCF_AMD(omega,Network,k);
        omega_0 = ones(Network.NumNodes,1)/Network.NumNodes;
        A = [];
        b = [];
        Aeq = ones(1,Network.NumNodes);
        beq = 1;
        lb = zeros(1,Network.NumNodes);
        ub = ones(1,Network.NumNodes);
        [omega,~] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub);
%         omega = .5*ones(1,Global.NumStates);
     %%
        Post = zeros(size(Network.Node(1).Prior(:,k)));
        for i = 1:Network.NumNodes
            Post = Post+Network.Node(i).Post(:,k).*omega(i);
        end
        Post = Post/sum(Post);
        for i = 1:Network.NumNodes
            Network.Node(i).Post(:,k) = Post;
        end
    end
end