function [Sim,HMM] = HMMinit_2(Sim)
    n = Sim.NumStates;
    if Sim.NoSelfLoop == true
        P = ones(n)-eye(n);
        P(P==1)=nan;
        mc = mcmix(n,'Fix',P,'Zeros',floor(n*(n-1)*Sim.MCperTran));
    else
        mc = mcmix(n,'Zeros',floor(n*n*Sim.MCperTran));
    end
    HMM.MotMdl = mc.P; % HMM transition probability matrix
    HMM.NumStates = size(HMM.MotMdl,1); % HMM number of states
    HMM.TrueStates = zeros(1,Sim.EndTime); % HMM true states vector
    HMM.TrueStates(1,1) = Sim.InitState; % HMM initial State
end