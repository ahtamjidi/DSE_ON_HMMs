function [Network] = CEN(~,HMM,Network,k)
    %% Update Estimator Posteriors
    Prior = Network.CEN_Est.Prior(:,k);
    Pred = HMM.MotMdl'*Prior;
    Post = Pred;
    for i = 1:Network.NumNodes
        Post = Post.*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
    end
    Post = Post/sum(Post);
    Network.CEN_Est.Pred(:,k) = Pred;
    Network.CEN_Est.Post(:,k) = Post;
end