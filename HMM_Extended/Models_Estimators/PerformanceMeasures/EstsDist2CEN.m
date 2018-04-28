function [HYB2CEN,ICF2CEN] = EstsDist2CEN(Sim,Network)
    for k = 1:Sim.EndTime 
        for i = 1:Network.NumNodes    
            temp = Network.CEN_Est.Post(:,k)./Network.Node(i).ICF_Est.Post(:,k);
            ICF2CEN.ProjMetric(i,k) = log(max(temp)/min(temp));
            ICF2CEN.L1(i,k) = sum(abs(Network.CEN_Est.Post(:,k)-Network.Node(i).ICF_Est.Post(:,k)));
            
            temp = Network.CEN_Est.Post(:,k)./Network.Node(i).HYB_Est.Post(:,k);
            HYB2CEN.ProjMetric(i,k) = log(max(temp)/min(temp));
            HYB2CEN.L1(i,k) = sum(abs(Network.CEN_Est.Post(:,k)-Network.Node(i).HYB_Est.Post(:,k)));
        end
    end
    ICF2CEN.meanProjMetric = mean(ICF2CEN.ProjMetric);
    ICF2CEN.meanL1 = mean(ICF2CEN.L1);
    HYB2CEN.meanProjMetric = mean(HYB2CEN.ProjMetric);
    HYB2CEN.meanL1 = mean(HYB2CEN.L1);
end