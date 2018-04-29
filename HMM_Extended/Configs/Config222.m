function Sim = Config222()
    %% General
    Sim.EndTime = 27*2;
    Sim.seed = 1458;
    Sim.MarkovMdl = 2;    
    Sim.NetworkMdl = 2;    
    Sim.EstimatorMdl = 2;
    %% Markov Model
    Sim.NumStates = 15;
    Sim.NoSelfLoop = false;
    Sim.TranPrMatZeros = 0.6;  
    Sim.InitState = 1;  
    %% Network Model
    Sim.NumNodes = 5; % Works for 1_Small-nNodes-2States and 2_Small-nNodes-mStates
    DiagRng = repmat([0.6 0.7],Sim.NumNodes,1);
    DiagRng(1,:) = [0.6 0.7];
    DiagRng(2,:) = [0.6 0.75];
    DiagRng(3,:) = [0.6 0.7];
    DiagRng(4,:) = [0.6 0.75];
    Sim.ObsMdlDiagRng = DiagRng;
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
    Sim.HomObsMdl = 1;
    %% Estimator Model
    Sim.EstDoOpt = 0;
    Sim.ConsensusIter = 50;    
end