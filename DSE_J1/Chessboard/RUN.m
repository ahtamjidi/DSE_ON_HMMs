function [PM_NGMD_CEN,PM_NGCF_CEN,PM_NGMD_GST,PM_NGCF_GST,Net_GST,World,Net_NGMD,Net_NGCF,Net_CEN,Sim,HMM] = RUN()
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
    [Net,Net_NGMD,Net_NGCF,Net_CEN,Net_GST] = InitNet(World,HMM,Sim);
    %% Initialization of the Visualization: Vis
    Vis = InitVis(World,Sim,Net);
    %% Sampling from the HMM
    for t = Config.BaseRate:Config.BaseRate:Config.SimTime
        %% HMM STEP: Sampling from the HMM
        [Sim,Net] = HMM_Step(World,HMM,Net,Sim);
        if Config.DoUpdate
            [Net_NGMD,Net_NGCF,Net_CEN,Net_GST] = Net_Step(HMM,Net,Net_NGMD,Net_NGCF,Net_CEN,Net_GST,Sim);
        end
    end
    %% Performance Measures
    if Config.DoUpdate
        PM_NGMD_CEN = PerfMeas_CEN(Sim,Net_NGMD,Net_CEN);
        PM_NGCF_CEN = PerfMeas_CEN(Sim,Net_NGCF,Net_CEN);
        PM_NGMD_GST = PerfMeas_GST(Sim,Net_NGMD,Net_GST);
        PM_NGCF_GST = PerfMeas_GST(Sim,Net_NGCF,Net_GST);
        
        figure
        subplot(321)
        plot(PM_NGMD_GST.BCS(1,:)); hold on ; plot(PM_NGCF_GST.BCS(1,:)); hold on ;
        plot(PM_NGMD_CEN.BCS(1,:)); hold on ; plot(PM_NGCF_CEN.BCS(1,:)); hold on ;

        xlabel('step')
        ylabel('Performance Measure - Node 1')
        legend('BC(FHS,HYB)','BC(FHS,ICF)', 'BC(CEN,HYB)','BC(CEN,ICF)')

        subplot(323)
        plot(PM_NGMD_GST.BCS(2,:)); hold on ; plot(PM_NGCF_GST.BCS(2,:)); hold on ;
        plot(PM_NGMD_CEN.BCS(2,:)); hold on ; plot(PM_NGCF_CEN.BCS(2,:)); hold on ;

        xlabel('step')
        ylabel('Performance Measure - Node 2')
        legend('BC(FHS,HYB)','BC(FHS,ICF)', 'BC(CEN,HYB)','BC(CEN,ICF)')

        subplot(325)
        plot(PM_NGMD_GST.BCS(3,:)); hold on ; plot(PM_NGCF_GST.BCS(3,:)); hold on ;
        plot(PM_NGMD_CEN.BCS(3,:)); hold on ; plot(PM_NGCF_CEN.BCS(3,:)); hold on ;

        xlabel('step')
        ylabel('Performance Measure - Node 3')
        legend('BC(FHS,HYB)','BC(FHS,ICF)', 'BC(CEN,HYB)','BC(CEN,ICF)')


        subplot(322)
        plot(PM_NGMD_GST.BCS(4,:)); hold on ; plot(PM_NGCF_GST.BCS(4,:)); hold on ;
        plot(PM_NGMD_CEN.BCS(4,:)); hold on ; plot(PM_NGCF_CEN.BCS(4,:)); hold on ;

        xlabel('step')
        ylabel('Performance Measure - Node 4')
        legend('BC(FHS,HYB)','BC(FHS,ICF)', 'BC(CEN,HYB)','BC(CEN,ICF)')


        subplot(324)
        plot(PM_NGMD_GST.BCS(5,:)); hold on ; plot(PM_NGCF_GST.BCS(5,:)); hold on ;
        plot(PM_NGMD_CEN.BCS(5,:)); hold on ; plot(PM_NGCF_CEN.BCS(5,:)); hold on ;

        xlabel('step')
        ylabel('Performance Measure - Node 5')
        legend('BC(FHS,HYB)','BC(FHS,ICF)', 'BC(CEN,HYB)','BC(CEN,ICF)')



        subplot(326)
        plot(PM_NGMD_GST.BCS(6,:)); hold on ; plot(PM_NGCF_GST.BCS(6,:)); hold on ;
        plot(PM_NGMD_CEN.BCS(6,:)); hold on ; plot(PM_NGCF_CEN.BCS(6,:)); hold on ;

        xlabel('step')
        ylabel('Performance Measure - Node 6')
        legend('BC(FHS,HYB)','BC(FHS,ICF)', 'BC(CEN,HYB)','BC(CEN,ICF)')

    end
    %% Animation
    for t = 2:size(Sim.GT,2)
        VisStep(World,Sim,Net,Vis,t);
        pause(.25);
    end
end