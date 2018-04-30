function Sim = InitSim()
    global Consts
    Sim.MCtr = 1;
    Sim.GT = zeros(1,floor(Consts.SimTime/Consts.MarkovRate));
    Sim.GT(Sim.MCtr) = Consts.GT_InitState;
end