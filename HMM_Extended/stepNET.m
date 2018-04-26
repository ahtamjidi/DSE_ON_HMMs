function [Network] = stepNET(Sim,~,Network,k)
    if Sim.NetworkMdl == 1
        [Network] = NETstep_1(Sim,Network,k);
    elseif Sim.NetworkMdl == 2
        [Network] = NETstep_2(Sim,Network,k);
    elseif Sim.NetworkMdl == 3
        [Network] = NETstep_3(Sim,Network,k);        
    else
        error('The given Sim.NetworkImp is unknown');
    end
end