function [Sim,HMM] = HMMinit_1(Sim)
    HMM.MotMdl = [.25 .75; .65 .35; ]; % HMM transition probability matrix
    HMM.NumStates = size(HMM.MotMdl,1); % HMM number of states
    HMM.TrueStates = zeros(1,Sim.EndTime); % HMM true states vector
    HMM.TrueStates(1,1) = Sim.InitState; % HMM initial State
end