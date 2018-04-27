function PM_GST = PerfMeas_GST(Sim,Network,Network_GST)
    for k=1:Sim.MCtr
        for i = 1:Network.NumOfNodes            
            PM_GST.Node(i).CM(k) = ClosenessMeasures(Network_GST.Node(i).Post(:,k),Network.Node(i).Post(:,k));
            PM_GST.BCS(i,k) = PM_GST.Node(i).CM(k).BCS;
            PM_GST.HEL(i,k) = PM_GST.Node(i).CM(k).HEL;
            PM_GST.L1(i,k) = PM_GST.Node(i).CM(k).L1;

            
            temp = Network_GST.Node(i).Post(:,k)./Network.Node(i).Post(:,k);
            PM_GST.ProjMetric(i,k) = log(max(temp)/min(temp));              
        end        
    end
    PM_GST.meanBCS = mean(PM_GST.BCS);
    PM_GST.meanHEL = mean(PM_GST.HEL);
    PM_GST.meanL1 = mean(PM_GST.L1);
    PM_GST.meanProjMetric = mean(PM_GST.ProjMetric);  
end