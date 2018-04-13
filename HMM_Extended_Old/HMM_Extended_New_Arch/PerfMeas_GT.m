function PM_GT = PerfMeas_GT(Global,Network)
    for k=1:Global.T
        for i = 1:Network.NumNodes
            [~,PM_GT.Node(i).MAP(k)]= max(Network.Node(i).Post(:,k));
            PM_GT.Node(i).Post_Entropy(k) = Entropy(Network.Node(i).Post(:,k));
            PM_GT.Node(i).Prior_Entropy(k) = Entropy(Network.Node(i).Prior(:,k));
        end
    end
    PM_GT.NET_PER = 0;
    for i = 1:Network.NumNodes
        PM_GT.Node(i).PRF_EVL = PM_GT.Node(i).MAP(k) == Global.GT;
        PM_GT.Node(i).PRF_PER = sum(PM_GT.Node(i).PRF_EVL)/size(PM_GT.Node(i).PRF_EVL,2)*100;
        PM_GT.NET_PER = PM_GT.NET_PER + PM_GT.Node(i).PRF_PER;
    end
    PM_GT.NET_PER = PM_GT.NET_PER/Network.NumNodes;
end