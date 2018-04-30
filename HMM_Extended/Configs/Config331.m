function Sim = Config331()
    %% General
    Sim.EndTime = 27*2;
    Sim.seed = 1458;
    Sim.MarkovMdl = 3;
    Sim.NetworkMdl = 3;
    Sim.EstimatorMdl = 1;
    %% Markov Model
    Sim.NumStates = 3;
    Sim.ImageName = 'World_small2.bmp';
    Sim.InitState = 1;  
    %% Network Model
    Sim.NumNodes = 20; % Works for 1_Small-nNodes-2States and 2_Small-nNodes-mStates
    DiagRng = repmat([0.6 0.7],Sim.NumNodes,1);
    DiagRng(1,:) = [0.6 0.7];
    DiagRng(2,:) = [0.6 0.75];
    DiagRng(3,:) = [0.6 0.7];
    DiagRng(4,:) = [0.6 0.75];
    Sim.ObsMdlDiagRng = DiagRng;
    Sim.HomObsMdl = 1;
    Sim.ConnectivityPeriod = 6;
    Sim.RG_k = 2;
    Sim.RG_beta = 0.5;
    %% Estimator Model
    Sim.EstDoOpt = 0;
end