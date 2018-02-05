function pred()
global opt_dist
% i_time = opt_dist.i_time;
[opt_dist.result.pred.x_cen ,opt_dist.result.pred.P_cen] = f(opt_dist.result.prior.x_cen,opt_dist.result.prior.P_cen,0);
% opt_dist.result.pred.x_cen = opt_dist.result.prior.x_cen;
% opt_dist.result.pred.P_cen = opt_dist.result.prior.P_cen;

opt_dist.result.pred.Y_cen = inv(opt_dist.result.pred.P_cen);
if opt_dist.FLAGS.debug
    disp(['RCOND P_cen prediction = ',num2str(rcond(opt_dist.result.pred.P_cen))])
    if rcond(opt_dist.result.pred.P_cen)<=0.0001
        figure(opt_dist.figures.fig_cov_debug)
    end
end

opt_dist.result.pred.y_cen = opt_dist.result.pred.Y_cen*opt_dist.result.pred.x_cen;

for i_agent = 1 : opt_dist.nAgents
    if opt_dist.FLAGS.our_method
        [opt_dist.result.pred.x_bar(:,i_agent),opt_dist.result.pred.P_bar(:,:,i_agent)] = ...
            f(opt_dist.result.prior.x_bar(:,i_agent),opt_dist.result.prior.P_bar(:,:,i_agent),0);
        
        opt_dist.result.pred.Y_bar(:,:,i_agent) = pinv(opt_dist.result.pred.P_bar(:,:,i_agent));
        opt_dist.result.pred.y_bar(:,i_agent) = opt_dist.result.pred.Y_bar(:,:,i_agent)*opt_dist.result.pred.x_bar(:,i_agent);
    end
    if opt_dist.FLAGS.compare_with_CI
        [opt_dist.result.pred.x_bar_CI(:,i_agent),opt_dist.result.pred.P_bar_CI(:,:,i_agent)] = ...
            f(opt_dist.result.prior.x_bar_CI(:,i_agent),opt_dist.result.prior.P_bar_CI(:,:,i_agent),0);
        opt_dist.result.pred.x_bar_CI(:,i_agent);
        opt_dist.result.pred.Y_bar_CI(:,:,i_agent) = pinv(opt_dist.result.pred.P_bar_CI(:,:,i_agent));
        opt_dist.result.pred.y_bar_CI(:,i_agent) = opt_dist.result.pred.Y_bar_CI(:,:,i_agent)*opt_dist.result.pred.x_bar_CI(:,i_agent);
    end
end
x_pred_cen = opt_dist.result.pred.x_cen;
[h_cen,H_cen,idx_vis_cen]=h_calc_ver2(x_pred_cen);
opt_dist.result.obs.h_cen = h_cen;
opt_dist.result.obs.H_cen = H_cen;
opt_dist.result.obs.id_vis_cen = idx_vis_cen;

% for idx_agent=1:opt_dist.nAgents
%     
%     if opt_dist.FLAGS.our_method
%         x_pred_bar = opt_dist.result.pred.x_bar(:,idx_agent);
%         [h,H,idx_vis]=h_calc_ver2(x_pred_bar,idx_agent);
%         opt_dist.result.obs.h{idx_agent} = h;
%         opt_dist.result.obs.H{idx_agent} = H;
%         opt_dist.result.obs.id_vis{idx_agent} = idx_vis;
%     end
%     if opt_dist.FLAGS.compare_with_CI
%         x_pred_CI  = opt_dist.result.pred.x_bar_CI(:,idx_agent) ;
%         [h_CI,H_CI,idx_vis_CI]=h_calc_ver2(x_pred_CI,idx_agent);
%         opt_dist.result.obs.h_CI{idx_agent} = h_CI;
%         opt_dist.result.obs.H_CI{idx_agent} = H_CI;
%         opt_dist.result.obs.id_vis_CI{idx_agent} = idx_vis_CI;
%     end
% end


h_calc_gold()
end