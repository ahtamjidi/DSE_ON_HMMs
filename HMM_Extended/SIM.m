function [PM,Sim,HMM,Network] = SIM(Sim)
    %% General Initilizations
    CheckSim(Sim);
    rng(Sim.seed);
    %% Mode Specific Initilizations
    HMMinit = str2func(strcat('HMMinit_',int2str(Sim.MarkovMdl)));
    NETinit = str2func(strcat('NETinit_',int2str(Sim.NetworkMdl)));
    [Sim,HMM] = HMMinit(Sim);
    Sim.Prior0 = ones(Sim.NumStates,1)/Sim.NumStates;
    Network = NETinit(Sim,HMM);
    NETstep = str2func(strcat('NETstep_',int2str(Sim.NetworkMdl)));
    ESTstep = str2func(strcat('ESTstep_',int2str(Sim.EstimatorMdl)));
    %% Simulation
    for k = 1:Sim.EndTime
        HMM = HMMstep(HMM,k);
        Network = NETstep(Sim,HMM,Network,k);
        Network = ESTstep(Sim,HMM,Network,k);
        disp(char(strcat('Step time',{' '},num2str(k),' is done')));
    end
    %% Performance Measures
    [PM.HYB2FHS,PM.ICF2FHS] = EstsDist2FHS(Sim,Network);
    [PM.HYB2CEN,PM.ICF2CEN] = EstsDist2CEN(Sim,Network);    
end
function CheckSim(Sim) % There are lots of checks yet to be implemented!
    if size(Sim.NetConnectivity,1) ~= Sim.NumNodes
        error('In this mode size of NetConnectivity must be equal to NumNodes');
    end
end