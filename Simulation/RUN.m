function RUN()
    %% Creation of the world: World
    World = CreateWorld('World.bmp');
    %% Define and chaeck constants as global var: Config
    global Config
    SetConfig(World);
    addpath(genpath(pwd));
    %% Initialization of the Hiden Markov Model: HMM
    HMM = InitHMM(World);
    %% Initialization of the Network: Net
    Net = InitNet(World);
    %% Initialization of the Simulation: Sim
    Sim = InitSim();
    %% Initialization of the Visualization: Vis
    Vis = InitVis(World,Sim,Net);
    %% Sampling from the HMM
    for t = Config.BaseRate:Config.BaseRate:Config.SimTime
        %% HMM STEP: Sampling from the HMM
        if mod(t,Config.MarkovRate) == 0
            [Sim,Net] = HMM_Step(World,HMM,Net,Sim);
        end
        %% Network STEP: Sampling from the Network
        if mod(t,Config.NetRate) == 0
            
        end
        %% Update STEP: Processing the Distributions
            
    end
    %% Animation
    for t = 2:size(Sim.GT,2)
        VisStep(World,Sim,Net,Vis,t);
        pause(.25);
    end
end