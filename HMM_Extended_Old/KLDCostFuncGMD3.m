function KLD_error = KLDCostFuncGMD3(omega,Network,k)
    Prior = ones(size(Network.Node(1).Prior(:,k)));
    for i = 1:Network.NumNodes
        Prior = Prior.*Network.Node(i).Prior(:,k).^omega(i);
    end
    Prior = Prior/sum(Prior);
    D_kl = zeros(1,Network.NumNodes);
    for i = 1:Network.NumNodes
        D_kl(i) = KLD(Prior,Network.Node(i).Prior(:,k));
    end
    KLD_error = (D_kl(1)+D_kl(2));
end