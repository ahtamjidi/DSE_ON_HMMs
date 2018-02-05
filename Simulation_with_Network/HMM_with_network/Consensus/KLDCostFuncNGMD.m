function KLD_error = KLDCostFuncNGMD(omega,Network,k)
    Prior = ones(size(Network.Node(1).Prior(:,k)));
    for i = 1:Network.NumNodes
        Prior = Prior.*Network.Node(i).Prior(:,k).^omega(i);
    end
    Prior = Prior/sum(Prior);
    D_kl = zeros(1,Network.NumNodes);
    for i = 1:Network.NumNodes
        D_kl(i) = KLD(Prior,Network.Node(i).Prior(:,k));
    end
    KLD_error = max(D_kl);
end