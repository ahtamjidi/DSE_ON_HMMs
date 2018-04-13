function [Network] = FHS2(HMM,Network,k)
    ConComps = Network.ConComps{k};
    for i = 1:size(ConComps,2)
    ConComp = ConComps{i};
	NumConNodes = size(ConComp,2);
        if NumConNodes == 1            
            Network.Node(ConComp).FHS_Est.Pred(:,k) = HMM.MotMdl'*Network.Node(ConComp).FHS_Est.Prior(:,k);
            Network.Node(ConComp).FHS_Est.Post(:,k) = Network.Node(ConComp).FHS_Est.Pred(:,k).*Network.Node(ConComp).ObsMdl(:,Network.Node(ConComp).z(1,k));
            Network.Node(ConComp).FHS_Est.Post(:,k) = Network.Node(ConComp).FHS_Est.Post(:,k)/sum(Network.Node(ConComp).FHS_Est.Post(:,k));
        else
            ConHist = Network.ConHist(ConComp(1),:,k);
            for t = 1:k
                if t==1
                    Prior = Network.Node(ConComp(1)).FHS_Est.Prior(:,t);
                end
                Pred = HMM.MotMdl'*Prior;
                Post = Pred;
                for j = 1:Network.NumNodes
                    if t <= ConHist(j);
                        Post = Post.*Network.Node(j).ObsMdl(:,Network.Node(j).z(1,t));
                    end
                end
                Post = Post/sum(Post);
                Prior = Post;
            end
            for j = 1:NumConNodes
                Network.Node(ConComp(j)).FHS_Est.Prior(:,k) = Prior;
                Network.Node(ConComp(j)).FHS_Est.Pred(:,k) = Pred;
                Network.Node(ConComp(j)).FHS_Est.Post(:,k) = Post;
            end
        end
    end
end