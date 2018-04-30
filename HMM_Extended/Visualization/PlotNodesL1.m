function PlotNodesL1(NodesVec,Sim,Network,PM)
    figure;
    N = size(NodesVec,2);
    for j = 1:N 
        subplot(N,1,j);
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
                    patch([i-1 i i i-1],[max(PM.ICF2FHS.L1(j,:))  max(PM.ICF2FHS.L1(j,:)) 0 0],[0 1-C C],'EdgeColor','none','FaceAlpha',.5);
                    break;
                end
            end
        end
        hold on;
        gm = plot(PM.HYB2FHS.L1(NodesVec(j),:),'*-');
        cf = plot(PM.ICF2FHS.L1(NodesVec(j),:),'*-');
        xlabel('step');
        ylabel(strcat('L',int2str(NodesVec(j))));
        legend([gm,cf],strcat('N',int2str(NodesVec(j)),'_{HYB}'),strcat('N',int2str(NodesVec(j)),'_{ICF}'));
    end
%     figure;
%     hold on;
%     gm = plot(PM_HYB_FHS.meanL1,'*-'); 
%     cf = plot(PM_ICF_FHS.meanL1,'*-'); 
%     xlabel('step');
%     ylabel(strcat('L',int2str(j)));  
%     legend([gm,cf],strcat('Average L1 HYB'),strcat('Average L1 ICF'));    
end

