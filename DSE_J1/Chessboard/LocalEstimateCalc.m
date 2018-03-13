function Network = LocalEstimateCalc(Network,Method,k)
switch Method
    case 'GCF'
        for i  = 1:Network.NumOfNodes
            post =  Network.Node(i).Pred(:,k).*Network.Node(i).Likelihood(:,k);
            post = post./sum(post);
            Network.Node(i).Post(:,k) = post;
        end
end
end