function PM_GST = PerfMeas_GST(Global,Network,Network_GST)
    for k=1:Global.T
        for i = 1:Network.NumNodes            
            PM_GST.Node(i).CM(k) = ClosenessMeasures(Network_GST.Node(i).Post(:,k),Network.Node(i).Post(:,k));
            PM_GST.BCS(i,k) = PM_GST.Node(i).CM(k).BCS;
            PM_GST.HEL(i,k) = PM_GST.Node(i).CM(k).HEL;
            PM_GST.KLD(i,k) = KLD(Network_GST.Node(i).Post(:,k),Network.Node(i).Post(:,k));
            PM_GST.dcorr(i,k) = dcorr(Network_GST.Node(i).Post(:,k),Network.Node(i).Post(:,k));
            PM_GST.TVD(i,k) = 1/2*max(abs(Network_GST.Node(i).Post(:,k)-Network.Node(i).Post(:,k)));
            temp = Network_GST.Node(i).Post(:,k)./Network.Node(i).Post(:,k);
            PM_GST.ProjMetric(i,k) = log(max(temp)/min(temp));
        end
    end
    PM_GST.meanBCS = mean(PM_GST.BCS);
    PM_GST.meanHEL = mean(PM_GST.HEL);
    PM_GST.meanKLD = mean(PM_GST.KLD);
    PM_GST.meandcorr = mean(PM_GST.dcorr);
    PM_GST.meanTVD = mean(PM_GST.TVD);
    PM_GST.meanProjMetric = mean(PM_GST.ProjMetric);
end