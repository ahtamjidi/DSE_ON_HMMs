function Network = CalcLikelihood(Network,k)
    for i  = 1:Network.NumOfNodes
        Network.Node(i).Likelihood(:,k) = Network.Node(i).ObsMdl(:,Network.Node(i).z(k));
    end
end