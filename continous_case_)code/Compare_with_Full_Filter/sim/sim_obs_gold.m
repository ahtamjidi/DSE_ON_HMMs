% function [z,h,H,id_vis] = h_calc(x_gt,x_pred,idx_agent,Con_Graph,flag_noise)
function  sim_obs_gold()
flag_noise = 1;
global opt_dist
% centralized observer

z = [];
id_vis = [];
H = [];
h = [];

opt_dist.sim.obs.z_cen = [];
opt_dist.sim.obs.r_var_cen = [];
opt_dist.sim.obs.id_vis_cen = [];


for idx_agent=1:opt_dist.nAgents
    idx_obs_agent = idx_agent;% find(opt_dist.Graphs.G_obs.Adj(idx_agent,:)~=0);
    z = [];
    id_vis = [];
    if opt_dist.FLAGS.compare_with_CI
        z_CI = [];
        id_vis_CI = [];
    end
    for i=idx_obs_agent
        z_temp = opt_dist.C(i,:) * opt_dist.sim.gt.x_bar;
        %         if norm(z_temp) <=opt_dist.obs.Range
        if flag_noise
            %             delta_noise = randn(opt_dist.dimObs,1)*sqrt(opt_dist.obs.R);
            switch opt_dist.FLAGS.obs_noise_type
                case 'absolute'
                    delta_noise = randn(opt_dist.dimObs,1).*sqrt(opt_dist.obs.R);
                case 'relative'
                    delta_noise = randn(opt_dist.dimObs,1).*sqrt(opt_dist.obs.rel_perc.*z_temp);
            end
            z_noise = z_temp + delta_noise;
            
            if opt_dist.FLAGS.debug
                percent_of_noise = 100*(delta_noise./z_temp);
                disp(['Percentage of o Noise = ', num2str(mean(percent_of_noise))])
                disp('---------------------')
                %                 disp(percent_of_noise)
                %                 disp('---------------------')
            end
        else
            z_noise = z_temp;
        end
        id_vis = [id_vis,i];
        z = [z;z_noise];
        switch opt_dist.FLAGS.obs_noise_type
            case 'absolute'
                r = opt_dist.obs.R;
            case 'relative'
                r = opt_dist.obs.rel_perc.*z_temp;
        end
        
    end
    if opt_dist.FLAGS.our_method
        opt_dist.sim.obs.z{opt_dist.i_step,idx_agent} = z;
        opt_dist.sim.obs.r_var{opt_dist.i_step,idx_agent} = r;
        opt_dist.sim.obs.id_vis{opt_dist.i_step,idx_agent} = id_vis;
    end
    opt_dist.sim.obs.z_cen = [opt_dist.sim.obs.z_cen;z];
    opt_dist.sim.obs.r_var_cen = [opt_dist.sim.obs.r_var_cen;r];
    opt_dist.sim.obs.id_vis_cen = [opt_dist.sim.obs.id_vis_cen;id_vis];
    
    if opt_dist.FLAGS.compare_with_CI
        opt_dist.sim.obs.z_CI{opt_dist.i_step,idx_agent} = z;
        opt_dist.sim.obs.r_CI_var{opt_dist.i_step,idx_agent} = r;
        opt_dist.sim.obs.id_vis_CI{opt_dist.i_step,idx_agent} = id_vis;
        %
    end
end

end

