function [PM_GMD_FHS,PM_GCF_FHS,Sim,HMM,Network] = SIM(Config)
    %% Initilization
    [Sim, HMM, Network] = initSim(Config);
    %% Simulation
    for k = 1:Sim.EndTime
        [HMM,Network] = stepHMM(Sim,HMM,Network,k);
        [Network] = stepNET(Sim,HMM,Network,k);
        [Network] = stepEST(Sim,HMM,Network,k);
        disp(char(strcat('Step time',{' '},num2str(k),' is done')));
    end
    %% Performance Measures
    PM_GMD_FHS = PerfMeas_FHS(Sim,Network,'GMD');
    PM_GCF_FHS = PerfMeas_FHS(Sim,Network,'GCF');
end