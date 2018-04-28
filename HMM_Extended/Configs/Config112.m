function Sim = Config112()
    %% General
    Sim.EndTime = 27*2;
    Sim.seed = 1458;
    Sim.MarkovMdl = 1;
    Sim.NetworkMdl = 1;
    Sim.EstimatorMdl = 2;
    %% Markov Model
    Sim.MotMdl = [.25 .75; .65 .35; ];
    Sim.NumStates = size(Sim.MotMdl,1);
    Sim.InitState = 1;
    %% Network Model
    Sim.ObsMdl(:,:,1) = [5/6, 1/6;3/12, 9/12];
    Sim.ObsMdl(:,:,2) = [4/6, 2/6;4/12, 8/12];
    Sim.ObsMdl(:,:,3) = [4/6, 2/6;3/12, 9/12];
    Sim.ObsMdl(:,:,4) = [0.95, 0.05;0.05, 0.95];        
    Sim.NumNodes = size(Sim.ObsMdl,3);      
    NetConnectivity = zeros(Sim.NumNodes,Sim.EndTime);
    NetConnectivity([1 2],5:11) = 1;
    NetConnectivity([4 5],5:11) = 2;
    NetConnectivity([ 3 4],12:16) = 1;
    NetConnectivity([1 3 5],17:23) = 2;
    NetConnectivity([2 4],24:30) = 1;
    NetConnectivity([1 2 3 ],32:34) = 1;
    NetConnectivity([1 2 3 ],36:38) = 1;
    NetConnectivity([1 2 3 ],40:42) = 1;
    NetConnectivity([4 5],32:34) = 2;
    NetConnectivity([4 5],36:38) = 2;
    NetConnectivity([4 5],40:42) = 2;
    NetConnectivity([1 2 3 4 5],44:54) = 1;
    Sim.NetConnectivity = NetConnectivity(1:Sim.NumNodes,1:Sim.EndTime);
    %% Estimator Model
    Sim.EstDoOpt = 0;
    Sim.ConsensusIter = 50;
end