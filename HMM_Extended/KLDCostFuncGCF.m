function KLD_error = KLDCostFuncGCF(omega,Network,k)
    Post = ones(size(Network.Node(1).Post(:,k)));
    for i = 1:Network.NumNodes
        Post = Post.*Network.Node(i).Post(:,k).^omega(i);
    end
    Post = Post/sum(Post);
    D_kl = zeros(1,Network.NumNodes);
    for i = 1:Network.NumNodes
        D_kl(i) = KLD(Post,Network.Node(i).Post(:,k));
    end
    KLD_error = max(D_kl);
end