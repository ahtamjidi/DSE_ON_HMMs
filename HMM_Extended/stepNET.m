function [Network] = stepNET(Sim,~,Network,k)
    if Sim.NetworkMdl == 1
        [Network] = NETstep_1(Sim,Network,k);
    else
        error('The given Sim.NetworkImp is unknown');
    end
end