function [Net,Net_NGMD,Net_NGCF,Net_CEN] = InitNet(World,HMM,Sim)
    global Config
    Net = Config.Network;
        
    T = ceil(Config.SimTime/Config.MarkovRate);
    for i = 1:Net.NumOfNodes
        Net.Node(i).z(1,1) = Config.GT_InitState;
        Net.Node(i) = UpdateNodeObservation(World,Net.Node(i),Config.GT_InitState,1);
        Net.Node(i).ObsMdl = GenNodeObsMdl(World,Net.Node(i),1);
        Net.Node(i).Prior = zeros(World.NumStates,T);
        Net.Node(i).Prior(:,1) = 1/World.NumStates;           
        Net.Node(i).Pred   = zeros(World.NumStates,T);
        Net.Node(i).Post   = zeros(World.NumStates,T);
    end
    Net_NGMD = Net;
    Net_NGCF = Net;
    Net_CEN = Net;
    if Config.DoUpdate
        [Net_NGMD,Net_NGCF,Net_CEN] = Net_Step(HMM,Net,Net_NGMD,Net_NGCF,Net_CEN,Sim);
    end
end