function PM_CEN = PerfMeas_CEN(Sim,Network,Network_CEN)
    for k=1:Sim.MCtr
        for i = 1:Network.NumOfNodes            
            PM_CEN.Node(i).CM(k) = ClosenessMeasures(Network_CEN.Node(i).Post(:,k),Network.Node(i).Post(:,k));
            PM_CEN.BCS(i,k) = PM_CEN.Node(i).CM(k).BCS;
            PM_CEN.HEL(i,k) = PM_CEN.Node(i).CM(k).HEL;
            PM_CEN.L1(i,k) = PM_CEN.Node(i).CM(k).L1;

        end        
    end
    PM_CEN.meanBCS = mean(PM_CEN.BCS);
    PM_CEN.meanHEL = mean(PM_CEN.HEL);
    PM_CEN.meanL1 = mean(PM_CEN.L1);

end