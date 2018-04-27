function PlotNodesL1(NodesVec,Sim,Network,PM_GMD_FHS,PM_GCF_FHS)
    figure;
    N = size(NodesVec,2);
    for j = 1:N 
        subplot(N*100+1*10+j);
        for i = 1:Sim.EndTime
            NumConComps = max(Network.Connectivity(:,i));
            for k = 1:NumConComps
                if NumConComps < 1
                    break;
                elseif NumConComps == 1
                    C = 0;
                else
                    C = (k-1)/(NumConComps-1);
                end                
                if Network.Connectivity(j,i)== k
                    patch([i-1 i i i-1],[max(PM_GCF_FHS.L1(j,:))  max(PM_GCF_FHS.L1(j,:)) 0 0],[0 1-C C],'EdgeColor','none','FaceAlpha',.5);
                    break;
                end
            end

        end
        hold on;
        gm = plot(PM_GMD_FHS.L1(NodesVec(j),:),'*-');
        cf = plot(PM_GCF_FHS.L1(NodesVec(j),:),'*-');
        xlabel('step');
        ylabel(strcat('L',int2str(NodesVec(j))));
        legend([gm,cf],strcat('N',int2str(NodesVec(j)),'_{GMD}'),strcat('N',int2str(NodesVec(j)),'_{GCF}'));
    end
%     figure;
%     hold on;
%     gm = plot(PM_GMD_FHS.meanL1,'*-'); 
%     cf = plot(PM_GCF_FHS.meanL1,'*-'); 
%     xlabel('step');
%     ylabel(strcat('L',int2str(j)));  
%     legend([gm,cf],strcat('Average L1 GMD'),strcat('Average L1 GCF'));    
end

