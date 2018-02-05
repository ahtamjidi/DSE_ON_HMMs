close all
clc
figure
for j_agent=1:9
    subplot(3,3,j_agent)
    P = inv(opt_dist.result.est{i_consensus}.Y_bar(:,:,j_agent));
    x = P*(opt_dist.result.est{i_consensus}.y_bar(:,j_agent));
    plot(x_gt(1),x_gt(2),'+r', 'MarkerSize',3); hold on;
    error_ellipse(P,x); hold on
    error_ellipse(P_gold{j_agent},x_gold{j_agent})
    error_ellipse(P_cen,x_cen)
    legend('p','p_gold','p_cen')
    axis equal
    title(num2str(j_agent))
end


% close all
% clc
% figure
% for j_agent=2
%     % subplot(3,3,j_agent)
%     error_ellipse(P,x); hold on
%     error_ellipse(P_gold{j_agent},x_gold{j_agent})
%     error_ellipse(P_cen,x_cen)
%     legend('p','p_gold','p_cen')
% end
% 
% 
% close all
% clc
% figure
% subplot(211)
% for j_agent=1:9
%     % subplot(3,3,j_agent)
%     % error_ellipse(P,x); hold on
%     h(j_agent)=error_ellipse(P_gold{j_agent},x_gold{j_agent}); hold on
%     leg{j_agent} = num2str(j_agent);
%     legend(h,leg)
%     % error_ellipse(P_cen,x_cen)
%     % legend('p','p_gold','p_cen')
% end
% 
% subplot(212)
% for j_agent=1:9
%     % subplot(3,3,j_agent)
%     % error_ellipse(P,x); hold on
%     h(j_agent)=error_ellipse(P},x_gold{j_agent}); hold on
%     leg{j_agent} = num2str(j_agent);
%     legend(h,leg)
%     % error_ellipse(P_cen,x_cen)
%     % legend('p','p_gold','p_cen')
% end