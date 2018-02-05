function Network = predict(Network,Global,k)
for i = 1:Network.NumNodes
    Network.Node(i).Pred(:,k) =  Global.MotMdl'*Network.Node(i).Prior(:,k);
end
end
