function KLD_error = KLDCostFuncGCF(omega,Network,k,con)
    NumConNodes = size(con,2);
    Post = ones(size(Network.Node(1).GCF_Est.Post(:,k)));
    for i = 1:NumConNodes
        Post = Post.*Network.Node(con(i)).GCF_Est.Post(:,k).^omega(i);
    end
    Post = Post/sum(Post);
    D_kl = zeros(1,NumConNodes);
    for i = 1:NumConNodes
        D_kl(i) = KLD(Post,Network.Node(con(i)).GCF_Est.Post(:,k));
    end
    KLD_error = max(D_kl);
end