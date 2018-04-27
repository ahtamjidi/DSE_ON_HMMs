function Sim = InitSim()
    global Config
    Sim.MCtr = 1;
    Sim.NCtr = 1;
    Sim.GT = zeros(1,Config.SimTime);
    Sim.GT(Sim.MCtr) = Config.GT_InitState;
end