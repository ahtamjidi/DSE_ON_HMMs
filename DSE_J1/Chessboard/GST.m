function [Network] = GST(Network,HMM,k)
    if ~Network.a(k)
        % Connected
        for t = 1:k
            if t==1
                Prior = Network.Node(1).Prior(:,t);
            end
            Pred = HMM.TransProb'*Prior;
            Post = Pred;
            for i = 1:Network.NumOfNodes %NumConNodes
                Post = Post.*Network.Node(i).ObsMdl(:,Network.Node(i).z(t),t);
            end
            Post = Post/sum(Post);
            Prior = Post;
        end
        for i = 1:Network.NumOfNodes
            Network.Node(i).Prior(:,k) = Prior;
            Network.Node(i).Pred(:,k) = Pred;
            Network.Node(i).Post(:,k) = Post;
        end
    else
        % Disconnected
        Prior = Network.Node(1).Prior(:,k);
        Pred = HMM.TransProb'*Prior;
        Post = Pred; %ones(size(Network.Node(1).Prior));
        for i = 1:4
            Post = Post.*Network.Node(i).ObsMdl(:,Network.Node(i).z(k),k);
        end
        Post = Post/sum(Post);
        for i = 1:4
            Network.Node(i).Pred(:,k) = Pred;
            Network.Node(i).Post(:,k) = Post;
        end
        Prior = Network.Node(5).Prior(:,k);
        Pred = HMM.TransProb'*Prior;
        Post = Pred; %ones(size(Network.Node(1).Prior));
        for i = 5:6
            Post = Post.*Network.Node(i).ObsMdl(:,Network.Node(i).z(k),k);
        end
        Post = Post/sum(Post);
        for i = 5:6
            Network.Node(i).Pred(:,k) = Pred;
            Network.Node(i).Post(:,k) = Post;
        end
    end
end