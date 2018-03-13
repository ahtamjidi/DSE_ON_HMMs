function [Network] = GMD(Global,Network,k)
% Our approach: Conservative fusion of priors + Consensus over current
% Observations (#4)
    con = find(Network.isConnected(:,k))';
    discon = find(~Network.isConnected(:,k))';
    NumConNodes = size(con,2);
    for i = discon
        Network.Node(i).Pred(:,k) = Global.MotMdl'*Network.Node(i).Prior(:,k);
        Network.Node(i).Post(:,k) = Network.Node(i).Pred(:,k).*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
        Network.Node(i).Post(:,k) = Network.Node(i).Post(:,k)/sum(Network.Node(i).Post(:,k));
    end
    if NumConNodes > 0 
        %% Optimization
        %Cost = @(omega)EntropyCostFuncGMD(omega,Network,k);
        Cost = @(omega)KLDCostFuncGMD(omega,Network,k,con);
        omega_0 = ones(NumConNodes,1)/NumConNodes;
        A = [];
        b = [];
        Aeq = ones(1,NumConNodes);
        beq = 1;
        lb = zeros(1,NumConNodes);
        ub = ones(1,NumConNodes);
        [omega] = fmincon(Cost,omega_0,A,b,Aeq,beq,lb,ub);  
         %omega = 0*ones(1,Global.NumStates);%[.5 ;.5];
        %%
        Prior = ones(size(Network.Node(1).Prior(:,k)));
        for i = 1:NumConNodes
            Prior = Prior.*Network.Node(con(i)).Prior(:,k).^omega(i);
        end
        Prior = Prior/sum(Prior);

        Pred = Global.MotMdl'*Prior;
        Post = Pred;
        for i = 1:NumConNodes
            Post = Post.*Network.Node(con(i)).ObsMdl(:,Network.Node(con(i)).z(1,k));
        end
        Post = Post/sum(Post);
        for i = 1:NumConNodes
            Network.Node(con(i)).Prior(:,k) = Prior;
            Network.Node(con(i)).Pred(:,k) = Pred;
            Network.Node(con(i)).Post(:,k) = Post;
        end
    end
end