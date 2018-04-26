function [Sim,HMM,Network] = initSim(Sim)
    rng(Sim.seed);
    CheckSim(Sim);
    %% Check for legit combinations of HMM, Network and estimators and initilize accordingly
    if Sim.MarkovMdl == 1 && Sim.NetworkMdl == 1
        Sim.NumStates = 2;
        Sim.NumNodes = 4;
        [Sim,HMM] = HMMinit_1(Sim);
        Sim.Prior0 = ones(Sim.NumStates,1)/Sim.NumStates;
        Network = NETinit_1(Sim,HMM);
    elseif Sim.MarkovMdl == 2 && Sim.NetworkMdl == 1
        Sim.NumStates = 2;
        Sim.NumNodes = 4;
        [Sim,HMM] = HMMinit_2(Sim);
        Sim.Prior0 = ones(Sim.NumStates,1)/Sim.NumStates;
        Network = NETinit_1(Sim,HMM);
    elseif Sim.MarkovMdl == 1 && Sim.NetworkMdl == 2
        Sim.NumStates = 2;
        [Sim,HMM] = HMMinit_1(Sim);
        Sim.Prior0 = ones(Sim.NumStates,1)/Sim.NumStates;
        Network = NETinit_2(Sim,HMM);
    elseif Sim.MarkovMdl ==2 && Sim.NetworkMdl == 2
        [Sim,HMM] = HMMinit_2(Sim);
        Sim.Prior0 = ones(Sim.NumStates,1)/Sim.NumStates;
        Network = NETinit_2(Sim,HMM);        
    elseif Sim.MarkovMdl == 2 && Sim.NetworkMdl == 3
        [Sim,HMM] = HMMinit_2(Sim);
        Sim.Prior0 = ones(Sim.NumStates,1)/Sim.NumStates;
        Network = NETinit_3(Sim,HMM);
    elseif Sim.MarkovMdl == 1 && Sim.NetworkMdl == 3
        Sim.NumStates = 2;
        [Sim,HMM] = HMMinit_2(Sim);
        Sim.Prior0 = ones(Sim.NumStates,1)/Sim.NumStates;
        Network = NETinit_3(Sim,HMM);    
    elseif Sim.MarkovMdl ==3 && Sim.NetworkMdl == 2
        [Sim,HMM] = HMMinit_3(Sim);
        Sim.Prior0 = ones(Sim.NumStates,1)/Sim.NumStates;
        Network = NETinit_2(Sim,HMM);
    else
        WrongConfig();
    end
end
function CheckSim(Sim)
    if size(Sim.NetConnectivity,1) ~= Sim.NumNodes
        error('In this mode size of NetConnectivity must be equal to NumNodes');
    end
end
function WrongConfig
    error('Given simulation config is not feasible');
end