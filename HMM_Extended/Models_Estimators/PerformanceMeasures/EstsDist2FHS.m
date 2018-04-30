function [HYB2FHS,ICF2FHS] = EstsDist2FHS(Sim,Network)
    for k=1:Sim.EndTime 
        for i = 1:Network.NumNodes    
            temp = Network.Node(i).FHS_Est.Post(:,k)./Network.Node(i).ICF_Est.Post(:,k);
            ICF2FHS.ProjMetric(i,k) = log(max(temp)/min(temp));
            ICF2FHS.L1(i,k) = sum(abs(Network.Node(i).FHS_Est.Post(:,k)-Network.Node(i).ICF_Est.Post(:,k)));
            
            temp = Network.Node(i).FHS_Est.Post(:,k)./Network.Node(i).HYB_Est.Post(:,k);
            HYB2FHS.ProjMetric(i,k) = log(max(temp)/min(temp));
            HYB2FHS.L1(i,k) = sum(abs(Network.Node(i).FHS_Est.Post(:,k)-Network.Node(i).HYB_Est.Post(:,k)));
        end
    end
    ICF2FHS.meanProjMetric = mean(ICF2FHS.ProjMetric);
    ICF2FHS.meanL1 = mean(ICF2FHS.L1);
    HYB2FHS.meanProjMetric = mean(HYB2FHS.ProjMetric);
    HYB2FHS.meanL1 = mean(HYB2FHS.L1);
end