function [Network] = stepEST(Sim,HMM,Network,k)
    if Sim.EstimatorMdl == 1
        [Network] = ESTstep_NoConsensus(Sim,HMM,Network,k);
    else
        error('The given Sim.NetworkImp is unknown');
    end
end