function KLD_error = KLDCostFuncGMD(omega,Network,k,con)
    if k==3
        aaa=1;
    end
    NumConNodes = size(con,2);
    Prior = ones(size(Network.Node(1).Prior(:,k)));
    for i = 1:NumConNodes
        Prior = Prior.*Network.Node(con(i)).Prior(:,k).^omega(i);
    end
    Prior = Prior/sum(Prior);
    D_kl = zeros(1,NumConNodes);
    for i = 1:NumConNodes
        D_kl(i) = KLD(Prior,Network.Node(con(i)).Prior(:,k));
    end
    KLD_error = max(D_kl);
    
end