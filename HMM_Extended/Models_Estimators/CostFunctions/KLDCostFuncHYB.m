function KLD_error = KLDCostFuncHYB(omega,Network,k,con)
    NumConNodes = size(con,2);
    Prior = ones(size(Network.Node(1).HYB_Est.Prior(:,k)));
    for i = 1:NumConNodes
        Prior = Prior.*Network.Node(con(i)).HYB_Est.Prior(:,k).^omega(i);
    end
    Prior = Prior/sum(Prior);
    D_kl = zeros(1,NumConNodes);
    for i = 1:NumConNodes
        D_kl(i) = KLD(Prior,Network.Node(con(i)).HYB_Est.Prior(:,k));
    end
    KLD_error = max(D_kl);
end