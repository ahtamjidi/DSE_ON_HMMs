function [Network] = CEN(Global,Network,k)
% Centerlized (#2)
    Prior = Network.Node(1).Prior;
    Pred = Global.MotMdl'*Prior;
    Post = Pred; %ones(size(Network.Node(1).Prior));
    for i = 1:Network.NumNodes
        Post = Post.*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
    end
    Post = Post/sum(Post);
    for i = 1:Network.NumNodes
        Network.Node(i).Pred(:,k) = Pred;
        Network.Node(i).Post(:,k) = Post;
    end
end