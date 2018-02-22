function PM_CEN = PerfMeas_CEN(Global,Network,Network_CEN)
    for k=1:Global.T
        for i = 1:Network.NumNodes            
            PM_CEN.Node(i).CM(k) = ClosenessMeasures(Network_CEN.Node(i).Post(:,k),Network.Node(i).Post(:,k));
            PM_CEN.BCS(i,k) = PM_CEN.Node(i).CM(k).BCS;
            PM_CEN.HEL(i,k) = PM_CEN.Node(i).CM(k).HEL;
            PM_CEN.KLD(i,k) = KLD(Network_CEN.Node(i).Post(:,k),Network.Node(i).Post(:,k));
            if any(Network_CEN.Node(i).Post(:,k)~=Network.Node(i).Post(:,k))
                temp = 1;
            end
            PM_CEN.dcorr(i,k) = dcorr(Network_CEN.Node(i).Post(:,k),Network.Node(i).Post(:,k));
            PM_CEN.TVD(i,k) = 1/2*max(abs(Network_CEN.Node(i).Post(:,k)-Network.Node(i).Post(:,k)));
        end
    end
    PM_CEN.meanBCS = mean(PM_CEN.BCS);
    PM_CEN.meanHEL = mean(PM_CEN.HEL);
    PM_CEN.meanKLD = mean(PM_CEN.KLD);
    PM_CEN.meandcorr = mean(PM_CEN.dcorr);
    PM_CEN.meanTVD = mean(PM_CEN.TVD);
end