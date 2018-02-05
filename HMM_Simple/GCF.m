function [Network] = GCF(Global,Network,k)
% Generalized Conservative Fusion(#6)
    for i = 1:Network.NumNodes
        Network.Node(i).Pred(:,k) = Global.MotMdl'*Network.Node(i).Prior;
        Network.Node(i).Post(:,k) = Network.Node(i).Pred(:,k).*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
        Network.Node(i).Post(:,k) = Network.Node(i).Post(:,k)/sum(Network.Node(i).Post(:,k));
    end
    if Network.isConnected(k) ~= 1
    else
        Post = ones(size(Network.Node(1).Prior));
        for i = 1:Network.NumNodes
            Post = Post.*Network.Node(i).Post(:,k).^Network.omega(i);
        end
        Post = Post/sum(Post);
        for i = 1:Network.NumNodes
            Network.Node(i).Post(:,k) = Post;
        end
    end
end