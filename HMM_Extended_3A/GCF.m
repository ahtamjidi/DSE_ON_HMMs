function [Network] = GCF(Global,Network,k)
% Generalized Conservative Fusion(#6)
    for i = 1:Network.NumNodes
        Network.Node(i).Pred(:,k) = Global.MotMdl'*Network.Node(i).Prior(:,k);
        Network.Node(i).Post(:,k) = Network.Node(i).Pred(:,k).*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
        Network.Node(i).Post(:,k) = Network.Node(i).Post(:,k)/sum(Network.Node(i).Post(:,k));
    end
    con = find(Network.isConnected(:,k))';
    NumConNodes = size(con,2);
    if NumConNodes > 0 
    %% Optimization
%         Cost = @(omega)EntropyCostFuncGCF(omega,Network,k);
        Cost = @(omega)KLDCostFuncGCF(omega,Network,k,con);
        omega_0 = ones(NumConNodes,1)/NumConNodes;
        A = [];
        b = [];
        Aeq = ones(1,NumConNodes);
        beq = 1;
        lb = zeros(1,NumConNodes);
        ub = ones(1,NumConNodes);
        [omega,~] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub);
        %omega = 0*ones(1,Global.NumStates);
     %%
        Post = ones(size(Network.Node(1).Prior(:,k)));
        for i = 1:NumConNodes
            Post = Post.*Network.Node(con(i)).Post(:,k).^omega(i);
        end
        Post = Post/sum(Post);
        for i = 1:NumConNodes
            Network.Node(con(i)).Post(:,k) = Post;
        end
    end
end