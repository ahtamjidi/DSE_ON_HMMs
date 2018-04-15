function [Sim,HMM,Network] = initSim(Config)        
    Sim.EndTime = Config.EndTime;
    Sim.seed = Config.seed;
    Sim.NetworkMdl = Config.NetworkMdl;
    Sim.MarkovMdl = Config.MarkovMdl;
    Sim.EstimatorMdl = Config.EstimatorMdl;    
    rng(Config.seed);
    %% Check for legit combinations of HMM, Network and estimators and initilize accordingly
    if Sim.MarkovMdl == 1 && Sim.NetworkMdl == 1
        Sim.NumStates = 2;
        Sim.NumNodes = 4;
        Sim.NetConnectivity = Config.NetConnectivity;
        CheckConfig(Config,Sim)
        HMM = HMMinit_1(Sim); 
        Network = NETinit_1(Sim,HMM);
    elseif Sim.MarkovMdl == 2 && Sim.NetworkMdl == 1
        Sim.NumStates = 2;
        Sim.NumNodes = 4;
        Sim.NetConnectivity = Config.NetConnectivity;
        CheckConfig(Config,Sim)
        HMM = HMMinit_2(Sim);
        Network = NETinit_1(Sim,HMM);
    elseif Sim.MarkovMdl == 1 && Sim.NetworkMdl == 2
        Sim.NumStates = 2;
        Sim.NumNodes = Config.NumNodes;
        Sim.NetConnectivity = Config.NetConnectivity;
        CheckConfig(Config,Sim)
        HMM = HMMinit_1(Sim);
        Network = NETinit_2(Sim,HMM);
    elseif Sim.MarkovMdl == 2 && Sim.NetworkMdl == 2
        Sim.NumStates = Config.NumStates;
        Sim.NumNodes = Config.NumNodes;
        Sim.NetConnectivity = Config.NetConnectivity;
        CheckConfig(Config,Sim)
        HMM = HMMinit_2(Sim);
        Network = NETinit_2(Sim,HMM);
    else
        WrongConfig();
    end
end
function CheckConfig(Config,Sim)
    if size(Config.NetConnectivity,1) ~= Sim.NumNodes
        error('Something wrong with the given config ');
    end
end
function WrongConfig
    error('Given simulation config is not feasible');
end