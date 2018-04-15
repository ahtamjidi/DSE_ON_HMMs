function [HMM] = HMMinit_2(Sim)
    mc = mcmix(Sim.NumStates);
    HMM.MotMdl = mc.P; % HMM transition probability matrix
    HMM.NumStates = size(HMM.MotMdl,1); % HMM number of states
    HMM.TrueStates = zeros(1,Sim.EndTime); % HMM true states vector
    HMM.TrueStates(1,1) = 1; % HMM initial State
end