function KLD_error = KLDCostFuncOPT(omega,Network,Global,k)
Prior = ones(size(Network.Node(1).Prior(:,k)));
for i = 1:Network.NumNodes
    Prior = Prior.*Network.Node(i).Prior(:,k).^omega(i);
end
Prior = Prior/sum(Prior);

Pred = Global.MotMdl'*Prior;
Post = Pred;%ones(size(Network.Node(1).Prior));
likelihood =ones(size(Network.Node(1).Prior));
for i = 1:Network.NumNodes
    likelihood = likelihood.*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
end
Post = Post/sum(Post);
D_kl = zeros(1,Network.NumNodes);
for i = 1:Network.NumNodes
    D_kl(i) = KLD(Post,Global.MotMdl'*Network.Node(i).Prior(:,k).*likelihood);
end
KLD_error = max(D_kl);
end