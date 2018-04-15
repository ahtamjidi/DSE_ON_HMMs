function PlotNodesL1(NodesVec,Sim,Network,PM_GMD_FHS,PM_GCF_FHS)
    figure;
    for j = NodesVec
        subplot(size(NodesVec,2)*100+1*10+j);
        for i = 1:Sim.EndTime
            if Network.Connectivity(j,i)==1
                patch([i-1 i i i-1],[max(PM_GCF_FHS.L1(j,:))  max(PM_GCF_FHS.L1(j,:)) 0 0],'g','EdgeColor','none','FaceAlpha',.5);
            end
        end
        hold on;
        gm = plot(PM_GMD_FHS.L1(j,:),'*-');
        cf = plot(PM_GCF_FHS.L1(j,:),'*-');
        xlabel('step');
        ylabel(strcat('L',int2str(j)));
        legend([gm,cf],strcat('N',int2str(j),'_{GMD}'),strcat('N',int2str(j),'_{GCF}'));
    end
    figure;
    hold on;
    gm = plot(PM_GMD_FHS.meanL1,'*-'); 
    cf = plot(PM_GCF_FHS.meanL1,'*-'); 
    xlabel('step');
    ylabel(strcat('L',int2str(j)));  
    legend([gm,cf],strcat('Average L1 GMD'),strcat('Average L1 GCF'));    
end