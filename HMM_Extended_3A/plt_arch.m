%% PLOT FHS ProjMetric

% figure
% subplot(321)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.96 0.96],'g','EdgeColor','none','FaceAlpha',.5);
%     end   
% end
% hold on;
% gm = plot(PM_GMD_FHS.ProjMetric(1,:),'*-'); hold on ; cf = plot(PM_GCF_FHS.ProjMetric(1,:),'*-'); hold on; %plot(Network.isConnected(1,:),'.k');
% xlabel('step')
% ylabel('ProjMetric')
% legend([gm,cf],'N1_{GMD}','N1_{GCF}')
% 
% 
% subplot(323)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% gm = plot(PM_GMD_FHS.ProjMetric(2,:),'*-'); hold on ; cf=plot(PM_GCF_FHS.ProjMetric(2,:),'*-'); hold on
% xlabel('step')
% ylabel('ProjMetric')
% legend([gm,cf],'N2_{GMD}','N2_{GCF}')
% 
% subplot(325)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% gm = plot(PM_GMD_FHS.ProjMetric(3,:),'*-'); hold on ; cf=plot(PM_GCF_FHS.ProjMetric(3,:),'*-'); hold on
% xlabel('step')
% ylabel('ProjMetric')
% legend([gm,cf],'N3_{GMD}','N3_{GCF}')
% 
% subplot(322)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_FHS.Node(1).Post;
% b=Network_GMD.Node(1).Post;
% c=Network_GCF.Node(1).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('FHS')
% legend([gm,cf,cf2],'FHS Post_1','GMD Post_1','GCF Post_1')
% 
% subplot(324)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_FHS.Node(2).Post;
% b=Network_GMD.Node(2).Post;
% c=Network_GCF.Node(2).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('FHS')
% legend([gm,cf,cf2],'FHS Post_2','GMD Post_2','GCF Post_2')
% 
% subplot(326)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_FHS.Node(3).Post;
% b=Network_GMD.Node(3).Post;
% c=Network_GCF.Node(3).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('FHS')
% legend([gm,cf,cf2],'FHS Post_3','GMD Post_3','GCF Post_3')


% subplot(322)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_FHS.Node(1).Post;
% b=Network_GMD.Node(1).Post;
% c=Network_GCF.Node(1).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('FHS')
% legend([gm,cf,cf2],'FHS Post_1','GMD Post_1','GCF Post_1')
% 
% subplot(324)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_FHS.Node(2).Post;
% b=Network_GMD.Node(2).Post;
% c=Network_GCF.Node(2).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('FHS')
% legend([gm,cf,cf2],'FHS Post_2','GMD Post_2','GCF Post_2')
% 
% subplot(326)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_FHS.Node(3).Post;
% b=Network_GMD.Node(3).Post;
% c=Network_GCF.Node(3).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('FHS')
% legend([gm,cf,cf2],'FHS Post_3','GMD Post_3','GCF Post_3')
%% PLOT CEN 
% figure
% subplot(321)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.96 0.96],'g','EdgeColor','none','FaceAlpha',.5);
%     end   
% end
% hold on;
% gm = plot(PM_GMD_CEN.BCS(1,:),'*-'); hold on ; cf = plot(PM_GCF_CEN.BCS(1,:),'*-'); hold on; %plot(Network.isConnected(1,:),'.k');
% xlabel('step')
% ylabel('BC distance')
% legend([gm,cf],'N1_{GMD}','N1_{GCF}')
% 
% 
% subplot(323)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% gm = plot(PM_GMD_CEN.BCS(2,:),'*-'); hold on ; cf=plot(PM_GCF_CEN.BCS(2,:),'*-'); hold on
% xlabel('step')
% ylabel('BC distance')
% legend([gm,cf],'N2_{GMD}','N2_{GCF}')
% 
% subplot(325)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% gm = plot(PM_GMD_CEN.BCS(3,:),'*-'); hold on ; cf=plot(PM_GCF_CEN.BCS(3,:),'*-'); hold on
% xlabel('step')
% ylabel('BC distance')
% legend([gm,cf],'N3_{GMD}','N3_{GCF}')
% 
% subplot(322)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_CEN.Node(1).Post;
% b=Network_GMD.Node(1).Post;
% c=Network_GCF.Node(1).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('CEN')
% legend([gm,cf,cf2],'CEN Post_1','GMD Post_1','GCF Post_1')
% 
% subplot(324)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_CEN.Node(2).Post;
% b=Network_GMD.Node(2).Post;
% c=Network_GCF.Node(2).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('CEN')
% legend([gm,cf,cf2],'CEN Post_2','GMD Post_2','GCF Post_2')
% 
% subplot(326)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_CEN.Node(3).Post;
% b=Network_GMD.Node(3).Post;
% c=Network_GCF.Node(3).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('CEN')
% legend([gm,cf,cf2],'CEN Post_3','GMD Post_3','GCF Post_3')

%% PLOT CEN2 
% figure
% subplot(321)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.96 0.96],'g','EdgeColor','none','FaceAlpha',.5);
%     end   
% end
% hold on;
% gm = plot(PM_GMD_CEN.ProjMetric(1,:),'*-'); hold on ; cf = plot(PM_GCF_CEN.ProjMetric(1,:),'*-'); hold on; %plot(Network.isConnected(1,:),'.k');
% xlabel('step')
% ylabel('ProjMetric')
% legend([gm,cf],'N1_{GMD}','N1_{GCF}')
% 
% 
% subplot(323)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% gm = plot(PM_GMD_CEN.ProjMetric(2,:),'*-'); hold on ; cf=plot(PM_GCF_CEN.ProjMetric(2,:),'*-'); hold on
% xlabel('step')
% ylabel('ProjMetric')
% legend([gm,cf],'N2_{GMD}','N2_{GCF}')
% 
% subplot(325)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% gm = plot(PM_GMD_CEN.ProjMetric(3,:),'*-'); hold on ; cf=plot(PM_GCF_CEN.ProjMetric(3,:),'*-'); hold on
% xlabel('step')
% ylabel('ProjMetric')
% legend([gm,cf],'N3_{GMD}','N3_{GCF}')
% 
% subplot(322)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_CEN.Node(1).Post;
% b=Network_GMD.Node(1).Post;
% c=Network_GCF.Node(1).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('CEN')
% legend([gm,cf,cf2],'CEN Post_1','GMD Post_1','GCF Post_1')
% 
% subplot(324)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_CEN.Node(2).Post;
% b=Network_GMD.Node(2).Post;
% c=Network_GCF.Node(2).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('CEN')
% legend([gm,cf,cf2],'CEN Post_2','GMD Post_2','GCF Post_2')
% 
% subplot(326)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_CEN.Node(3).Post;
% b=Network_GMD.Node(3).Post;
% c=Network_GCF.Node(3).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('CEN')
% legend([gm,cf,cf2],'CEN Post_3','GMD Post_3','GCF Post_3')

%% PLOT FHS 
% figure
% subplot(321)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.96 0.96],'g','EdgeColor','none','FaceAlpha',.5);
%     end   
% end
% hold on;
% gm = plot(PM_GMD_FHS.BCS(1,:),'*-'); hold on ; cf = plot(PM_GCF_FHS.BCS(1,:),'*-'); hold on; %plot(Network.isConnected(1,:),'.k');
% xlabel('step')
% ylabel('BC distance')
% legend([gm,cf],'N1_{GMD}','N1_{GCF}')
% 
% 
% subplot(323)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% gm = plot(PM_GMD_FHS.BCS(2,:),'*-'); hold on ; cf=plot(PM_GCF_FHS.BCS(2,:),'*-'); hold on
% xlabel('step')
% ylabel('BC distance')
% legend([gm,cf],'N2_{GMD}','N2_{GCF}')
% 
% subplot(325)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0.8 0.8],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% gm = plot(PM_GMD_FHS.BCS(3,:),'*-'); hold on ; cf=plot(PM_GCF_FHS.BCS(3,:),'*-'); hold on
% xlabel('step')
% ylabel('BC distance')
% legend([gm,cf],'N3_{GMD}','N3_{GCF}')
% 
% subplot(322)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_FHS.Node(1).Post;
% b=Network_GMD.Node(1).Post;
% c=Network_GCF.Node(1).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('FHS')
% legend([gm,cf,cf2],'FHS Post_1','GMD Post_1','GCF Post_1')
% 
% subplot(324)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_FHS.Node(2).Post;
% b=Network_GMD.Node(2).Post;
% c=Network_GCF.Node(2).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('FHS')
% legend([gm,cf,cf2],'FHS Post_2','GMD Post_2','GCF Post_2')
% 
% subplot(326)
% for i = 1: size(Network.isConnected,2)
%     if any(Network.isConnected(:,i)==1)
%         patch([i-1 i i i-1],[1 1 0. 0.],'g','EdgeColor','none','FaceAlpha',.5);
%     end
% end
% hold on;
% a=Network_FHS.Node(3).Post;
% b=Network_GMD.Node(3).Post;
% c=Network_GCF.Node(3).Post;
%  hold on ; cf=plot(b(1,:),'*-'); hold on; cf2=plot(c(1,:),'*-'); gm=plot(a(1,:),'*-');
% xlabel('step')
% ylabel('FHS')
% legend([gm,cf,cf2],'FHS Post_3','GMD Post_3','GCF Post_3')
