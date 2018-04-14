function [Sim,HMM,Network] = initSim(EndTime,seed,NetworkMdl,MarkovMdl,EstimatorMdl)        
    Sim.EndTime = EndTime;
    Sim.seed = seed;
    Sim.NetworkMdl = NetworkMdl;
    Sim.MarkovMdl = MarkovMdl;
    Sim.EstimatorMdl = EstimatorMdl;
    rng(seed);
    %% Markov Model
    switch Sim.MarkovMdl
        case 1
            HMM = HMMinit_1(Sim);            
            switch Sim.NetworkMdl
                case 1
                    Network = NETinit_1(Sim,HMM);
                otherwise
                    error('value not supported');
            end            
            Sim.NumNodes = 4;
        otherwise
            error('value not supported');
    end
end