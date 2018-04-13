function Ent = EntropyCostFuncOPT(omega,Network,Global,k)
    Prior = ones(size(Network.Node(1).Prior(:,k)));
    for i = 1:Network.NumNodes
        Prior = Prior.*Network.Node(i).Prior(:,k).^omega(i);
    end
    Prior = Prior/sum(Prior);
    
    Pred = Global.MotMdl'*Prior;
    Post = Pred; %ones(size(Network.Node(1).Prior));
    for i = 1:Network.NumNodes
        Post = Post.*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
    end
    Post = Post/sum(Post);
    Ent = Entropy(Post);
end