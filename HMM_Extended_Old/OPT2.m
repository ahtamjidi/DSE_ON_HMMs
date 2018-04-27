function [Network] = OPT2(Global,Network,k)
% Our approach: Conservative fusion of priors + Consensus over current
% Observations (#4)
    if Network.isConnected(k) ~= 1
        for i = 1:Network.NumNodes
            Network.Node(i).Pred(:,k) = Global.MotMdl'*Network.Node(i).Prior(:,k);
            Network.Node(i).Post(:,k) = Network.Node(i).Pred(:,k).*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
            Network.Node(i).Post(:,k) = Network.Node(i).Post(:,k)/sum(Network.Node(i).Post(:,k));
        end
    else
        %% Optimization
%         Cost = @(omega)EntropyCostFuncOPT(omega,Network,Global,k);        
        Cost = @(omega)KLDCostFuncOPT(omega,Network,Global,k);
        omega_0 = ones(Network.NumNodes,1)/Network.NumNodes;
        A = [];
        b = [];
        Aeq = ones(1,Network.NumNodes);
        beq = 1;
        lb = zeros(1,Network.NumNodes);
        ub = ones(1,Network.NumNodes);
        [omega,~] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub);
        %%
        Prior = ones(size(Network.Node(1).Prior(:,k)));
        for i = 1:Network.NumNodes
            Prior = Prior.*Network.Node(i).Prior(:,k).^omega(i);
        end
        Prior = Prior/sum(Prior);

        Pred = Global.MotMdl'*Prior;
        Post = Pred;%ones(size(Network.Node(1).Prior));
        for i = 1:Network.NumNodes
            Post = Post.*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
        end
        Post = Post/sum(Post);
        for i = 1:Network.NumNodes
            Network.Node(i).Prior(:,k) = Prior;
            Network.Node(i).Pred(:,k) = Pred;
            Network.Node(i).Post(:,k) = Post;
        end
    end
end