function [Network] = CEN(Network,HMM,k)
% Centerlized (#2)
    Prior = Network.Node(1).Prior(:,k);
    Pred = HMM.TransProb'*Prior;
    Post = Pred; %ones(size(Network.Node(1).Prior));
    for i = 1:Network.NumOfNodes
        Post = Post.*Network.Node(i).ObsMdl(:,Network.Node(i).z(k));
    end
    Post = Post/sum(Post);
    for i = 1:Network.NumOfNodes
        Network.Node(i).Pred(:,k) = Pred;
        Network.Node(i).Post(:,k) = Post;
    end
end