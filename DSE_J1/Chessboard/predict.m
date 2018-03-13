function Network = predict(Network,HMM,k)
for i = 1:Network.NumOfNodes
    Network.Node(i).Pred(:,k) =  HMM.TransProb'*Network.Node(i).Prior(:,k);
end
end
