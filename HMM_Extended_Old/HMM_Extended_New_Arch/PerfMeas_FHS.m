function PM_FHS = PerfMeas_FHS(Sim,Network,EstName)
    for k=1:Sim.EndTime 
        for i = 1:Network.NumNodes    
            if strcmp(EstName,'GMD')
                Est = Network.Node(i).GMD_Est;
            elseif strcmp(EstName,'GCF')
                Est = Network.Node(i).GCF_Est;
            else
                error('Given EstName does not exists');
            end
            PM_FHS.Node(i).CM(k) = ClosenessMeasures(Network.Node(i).FHS_Est.Post(:,k),Est.Post(:,k));
            PM_FHS.BCS(i,k) = PM_FHS.Node(i).CM(k).BCS;
            PM_FHS.HEL(i,k) = PM_FHS.Node(i).CM(k).HEL;
            PM_FHS.KLD(i,k) = KLD(Network.Node(i).FHS_Est.Post(:,k),Est.Post(:,k));
            PM_FHS.dcorr(i,k) = dcorr(Network.Node(i).FHS_Est.Post(:,k),Est.Post(:,k));
            PM_FHS.TVD(i,k) = 1/2*max(abs(Network.Node(i).FHS_Est.Post(:,k)-Est.Post(:,k)));
            temp = Network.Node(i).FHS_Est.Post(:,k)./Est.Post(:,k);
            PM_FHS.ProjMetric(i,k) = log(max(temp)/min(temp));
            PM_FHS.L1(i,k) = sum(abs(Network.Node(i).FHS_Est.Post(:,k)-Est.Post(:,k)));
        end
    end
    PM_FHS.meanBCS = mean(PM_FHS.BCS);
    PM_FHS.meanHEL = mean(PM_FHS.HEL);
    PM_FHS.meanKLD = mean(PM_FHS.KLD);
    PM_FHS.meandcorr = mean(PM_FHS.dcorr);
    PM_FHS.meanTVD = mean(PM_FHS.TVD);
    PM_FHS.meanProjMetric = mean(PM_FHS.ProjMetric);
end