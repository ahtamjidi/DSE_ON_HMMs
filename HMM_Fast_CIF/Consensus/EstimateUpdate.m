function Network = EstimateUpdate(Network,Global,Method,k)
size_comp = networkComponents(Network.Graph.p);

switch Method
    case 'GMD'
        for i  = 1:Network.NumNodes
            post =  Network.Node(i).Pred(:,k).* exp((size_comp(i)).*Network.Node(i).ConsesnsusData(k).IC(:,end));
            post = post./sum(post);
            Network.Node(i).Post(:,k) = post;
        end
        
    case 'GCF'
        for i  = 1:Network.NumNodes
            post =  Network.Node(i).ConsesnsusData(k).ICF(:,end);
            post = post./sum(post);
            Network.Node(i).Post(:,k) = post;
        end
end
end


