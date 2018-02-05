function Net = InitNet(World)
    global Config
    Net = Config.Network;    
    for i = 1:Net.NumOfNodes
        Net.Node(i).z(1,1) = Config.GT_InitState;
        Net.Node(i) = UpdateNodeObservation(World,Net.Node(i),Config.GT_InitState,1);
    end
end