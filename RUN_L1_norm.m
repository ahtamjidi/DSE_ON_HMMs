function [PM_NGMD_CEN,PM_NGCF_CEN,World,Net_NGMD,Net_NGCF,Net_CEN,Sim,HMM] = RUN()
    %% Creation of the world: World
    World = CreateWorld('World2.bmp');
    %% Define and chaeck constants as global var: Config
    global Config
    SetConfig(World);
    rng(05);
    %% Initialization of the Hiden Markov Model: HMM
    HMM = InitHMM(World);
    %% Initialization of the Simulation: Sim
    Sim = InitSim();
    %% Initialization of the Network: Net
    [Net,Net_NGMD,Net_NGCF,Net_CEN] = InitNet(World,HMM,Sim);
    %% Initialization of the Visualization: Vis
    Vis = InitVis(World,Sim,Net);
    %% Sampling from the HMM
    for t = Config.BaseRate:Config.BaseRate:Config.SimTime
        %% HMM STEP: Sampling from the HMM
        if mod(t,Config.MarkovRate) == 0
            [Sim,Net] = HMM_Step(World,HMM,Net,Sim);
            if Config.DoUpdate
                [Net_NGMD,Net_NGCF,Net_CEN] = Net_Step(HMM,Net,Net_NGMD,Net_NGCF,Net_CEN,Sim);
            end
        end
%         %% Network STEP: Sampling from the Network
%         if mod(t,Config.NetRate) == 0
%             
%         end
%         %% Update STEP: Processing the Distributions
%             
    end
    %% Performance Measures
    if Config.DoUpdate
        PM_NGMD_CEN = PerfMeas_CEN(Sim,Net_NGMD,Net_CEN);
        PM_NGCF_CEN = PerfMeas_CEN(Sim,Net_NGCF,Net_CEN);

        figure
        subplot(321)
        plot(PM_NGMD_CEN.L1(1,:)); hold on ; plot(PM_NGCF_CEN.L1(1,:)); hold on ;
        xlabel('step')
        ylabel('BC distance')
        legend('N1_{NGMD}','N1_{NGCF}')

        subplot(323)
        plot(PM_NGMD_CEN.L1(2,:)); hold on ; plot(PM_NGCF_CEN.L1(2,:)); 
        xlabel('step')
        ylabel('BC distance')
        legend('N2_{NGMD}','N2_{NGCF}')

        subplot(325)
        plot(PM_NGMD_CEN.meanL1); hold on ; plot(PM_NGCF_CEN.meanL1);
        xlabel('step')
        ylabel('BC distance')
        legend('Mean BC NGMD','Mean BC NGCF')

        subplot(322)
        plot(PM_NGMD_CEN.HEL(1,:)); hold on ; plot(PM_NGCF_CEN.HEL(1,:)); hold on
        xlabel('step')
        ylabel('HEL distance')
        legend('N1_{NGMD}','N1_{NGCF}')

        subplot(324)
        plot(PM_NGMD_CEN.HEL(2,:)); hold on ; plot(PM_NGCF_CEN.HEL(2,:)); hold on
        xlabel('step')
        ylabel('HEL distance')
        legend('N2_{NGMD}','N2_{NGCF}')

        subplot(326)
        plot(PM_NGMD_CEN.meanHEL); hold on ; plot(PM_NGCF_CEN.meanHEL);
        xlabel('step')
        ylabel('HEL distance')
        legend('Mean BC NGMD','Mean BC NGCF') 
    end
    %% Animation
    for t = 2:size(Sim.GT,2)
        VisStep(World,Sim,Net,Vis,t);
        pause(.25);
    end
end