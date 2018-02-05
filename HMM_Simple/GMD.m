function [Network] = GMD(Global,Network,k)
% Our approach: Conservative fusion of priors + Consensus over current
% Observations (#4)
    if Network.isConnected(k) ~= 1
        for i = 1:Network.NumNodes
            Network.Node(i).Pred(:,k) = Global.MotMdl'*Network.Node(i).Prior;
            Network.Node(i).Post(:,k) = Network.Node(i).Pred(:,k).*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
            Network.Node(i).Post(:,k) = Network.Node(i).Post(:,k)/sum(Network.Node(i).Post(:,k));
        end
    else
        Prior = ones(size(Network.Node(1).Prior));
        for i = 1:Network.NumNodes
            Prior = Prior.*Network.Node(i).Prior.^Network.omega(i);
        end
        Prior = Prior/sum(Prior);
        Pred = Global.MotMdl'*Prior;
        Post = Pred;%ones(size(Network.Node(1).Prior));
        for i = 1:Network.NumNodes
            Post = Post.*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
        end
        Post = Post/sum(Post);
        for i = 1:Network.NumNodes
            Network.Node(i).Pred(:,k) = Pred;
            Network.Node(i).Post(:,k) = Post;
        end
    end
end