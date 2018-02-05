function consenus_gold()
global opt_dist
%% centralized update
opt_dist.result.update.delta_i_cen = zeros(size(opt_dist.result.pred.x_cen));
opt_dist.result.update.delta_I_cen  = zeros(size(opt_dist.result.pred.P_cen));
[av_delta_I,av_delta_i] = calculate_aver_info_gold();
opt_dist.result.update.delta_I_cen = opt_dist.nAgents*av_delta_I;
opt_dist.result.update.delta_i_cen = opt_dist.nAgents*av_delta_i;
opt_dist.result.est{1}.Y_cen = opt_dist.result.pred.Y_cen + opt_dist.result.update.delta_I_cen;
opt_dist.result.est{1}.y_cen = opt_dist.result.pred.y_cen + opt_dist.result.update.delta_i_cen;



if opt_dist.FLAGS.our_method
    consensus_our_method()
end
if  opt_dist.FLAGS.compare_with_CI
    consensus_CI()
end
end
function consensus_our_method()
global opt_dist

% initializing consensus variables
size_comp = networkComponents(opt_dist.dataG.Graph.p);

for i_agent = 1 : opt_dist.nAgents
    opt_dist.result.consenus{i_agent}.Y_prior{1} = opt_dist.result.pred.Y_bar(:,:,i_agent) ;
    opt_dist.result.consenus{i_agent}.y_prior{1} = opt_dist.result.pred.y_bar(:,i_agent);
    H = opt_dist.result.obs.H{opt_dist.i_step,i_agent};
    z = opt_dist.sim.obs.z{opt_dist.i_step,i_agent};
    opt_dist.result.consenus{i_agent}.delta_I{1} = 1/(opt_dist.sim.obs.r_var{i_agent})*(H'*H);
    opt_dist.result.consenus{i_agent}.delta_i{1} =  1/(opt_dist.sim.obs.r_var{i_agent})*H'*z;
    opt_dist.result.consenus{i_agent}.group_set{1} = size_comp(i_agent);
    
end
% doing first iteration of consensus
i_consensus = 1;
for j_agent = 1 : opt_dist.nAgents
    
    opt_dist.result.est{i_consensus}.Y_bar(:,:,j_agent) = opt_dist.result.consenus{j_agent}.Y_prior{i_consensus}+...
        size_comp(j_agent)*opt_dist.result.consenus{j_agent}.delta_I{i_consensus};
    opt_dist.result.est{i_consensus}.y_bar(:,j_agent) = opt_dist.result.consenus{j_agent}.y_prior{i_consensus}+...
        size_comp(j_agent)*opt_dist.result.consenus{j_agent}.delta_i{i_consensus};
    
    det_cen = det(opt_dist.result.est{1}.Y_cen );
    det_bar(j_agent) = det(opt_dist.result.est{i_consensus}.Y_bar(:,:,j_agent));
    ratio_det(i_consensus,j_agent) = det_cen/det_bar(j_agent);
end

% main loop of consensus
for i_consensus = 2:opt_dist.nSteps
%     disp(['consensus step= ',num2str(i_consensus),' step = ',num2str(opt_dist.i_step )]);
    for j_agent = 1 : opt_dist.nAgents
        opt_dist.result.consenus{j_agent}.Y_prior{i_consensus} = zeros(size(opt_dist.result.consenus{j_agent}.Y_prior{i_consensus-1}));
        opt_dist.result.consenus{j_agent}.y_prior{i_consensus} = zeros(size(opt_dist.result.consenus{j_agent}.y_prior{i_consensus-1}));
        opt_dist.result.consenus{j_agent}.delta_I{i_consensus} = zeros(size(opt_dist.result.consenus{j_agent}.delta_I{i_consensus-1}));
        opt_dist.result.consenus{j_agent}.delta_i{i_consensus} = zeros(size(opt_dist.result.consenus{j_agent}.delta_i{i_consensus-1}));
        
        I_local=[];P_local=[];i_local = [];prev_delta_I=[];prev_delta_i=[];
        idx_neighbours = find(opt_dist.dataG.Graph.Adj(j_agent,:));
        
        for j_neigh=1:length(idx_neighbours)
            I_local(:,:,j_neigh) = (opt_dist.result.consenus{idx_neighbours(j_neigh)}.Y_prior{i_consensus-1});
            i_local(:,:,j_neigh) = (opt_dist.result.consenus{idx_neighbours(j_neigh)}.y_prior{i_consensus-1});
%             P_local(:,:,j_neigh) = inv(I_local(:,:,j_neigh));
            prev_delta_I(:,:,j_neigh) = opt_dist.result.consenus{j_neigh}.delta_I{i_consensus-1};
            prev_delta_i(:,:,j_neigh) = opt_dist.result.consenus{j_neigh}.delta_i{i_consensus-1};
        end
        log_message('our method CI')
        weights_ci = [];inf_mat = [];inf_vect=[];
        [weights_ci,inf_mat,inf_vect] =calc_ci_weights_ver3(I_local,i_local,'det');
        opt_dist.result.consenus{j_agent}.Y_prior{i_consensus} = inf_mat;
        opt_dist.result.consenus{j_agent}.y_prior{i_consensus} = inf_vect;
        %             mh_weights_row = opt_dist.dataG.Graph.p(j_agent,idx_neighbours);
        %             opt_dist.result.consenus{j_agent}.delta_I{i_consensus} = special_dot_sum(mh_weights_row,prev_delta_I,0);
        %             opt_dist.result.consenus{j_agent}.delta_i{i_consensus} =special_dot_sum(mh_weights_row,prev_delta_i,0);
        opt_dist.result.consenus{j_agent}.group_set{i_consensus}  = find( opt_dist.dataG.Graph.p(j_agent,:));
        updated_delta_I = []; updated_delta_i=[];
        for k_agent = 1 : opt_dist.nAgents
            p_jk = opt_dist.dataG.Graph.p(j_agent,k_agent);
            
            %             b_jk = covariance_intersection()
            updated_delta_I = opt_dist.result.consenus{j_agent}.delta_I{i_consensus} + p_jk*opt_dist.result.consenus{k_agent}.delta_I{i_consensus-1};
            updated_delta_i = opt_dist.result.consenus{j_agent}.delta_i{i_consensus} + p_jk*opt_dist.result.consenus{k_agent}.delta_i{i_consensus-1};
            opt_dist.result.consenus{j_agent}.delta_I{i_consensus} = updated_delta_I;
            opt_dist.result.consenus{j_agent}.delta_i{i_consensus} =updated_delta_i;
            if p_jk
            opt_dist.result.consenus{j_agent}.group_set{i_consensus} = union( opt_dist.result.consenus{j_agent}.group_set{i_consensus},...
                opt_dist.result.consenus{k_agent}.group_set{i_consensus-1});
            end
        end
        if opt_dist.dataG.is_connected
%                         diff_I = max(max((opt_dist.result.update.delta_I_cen  - opt_dist.result.consenus{j_agent}.delta_I{i_consensus})))
%                         diff_i = max((opt_dist.result.update.delta_i_cen  - opt_dist.result.consenus{j_agent}.delta_i{i_consensus}))
        end
        ratio = i_consensus/opt_dist.nSteps;
        opt_dist.result.est{i_consensus}.Y_bar(:,:,j_agent) = opt_dist.result.consenus{j_agent}.Y_prior{i_consensus}+...
            ratio*size_comp(j_agent)*opt_dist.result.consenus{j_agent}.delta_I{i_consensus};
        opt_dist.result.est{i_consensus}.y_bar(:,j_agent) = opt_dist.result.consenus{j_agent}.y_prior{i_consensus}+...
            ratio*size_comp(j_agent)*opt_dist.result.consenus{j_agent}.delta_i{i_consensus};
        
        
        %         ratio = i_consensus/opt_dist.nSteps;
        %                 opt_dist.result.est{i_consensus}.Y_bar(:,:,j_agent) = opt_dist.result.consenus{j_agent}.Y_prior{i_consensus}+...
        %                     numel(opt_dist.result.consenus{j_agent}.group_set{i_consensus})*opt_dist.result.consenus{j_agent}.delta_I{i_consensus};
        %                 opt_dist.result.est{i_consensus}.y_bar(:,j_agent) = opt_dist.result.consenus{j_agent}.y_prior{i_consensus}+...
        %                     numel(opt_dist.result.consenus{j_agent}.group_set{i_consensus})*opt_dist.result.consenus{j_agent}.delta_i{i_consensus};
        
        
        
%         det(opt_dist.result.est{1}.Y_cen)/det(opt_dist.result.est{i_consensus}.Y_bar(:,:,j_agent))
%         det_cen = det(opt_dist.result.est{1}.Y_cen )
%         det_bar(j_agent) = det(opt_dist.result.est{i_consensus}.Y_bar(:,:,j_agent));
% %         det_bar(j_agent)
%         ratio_det(i_consensus,j_agent) = det_cen/det_bar(j_agent);
%         ratio_det(i_consensus,j_agent)
        %         opt_dist.result.est{i_consensus}.Y_bar(:,:,j_agent) = opt_dist.result.consenus{j_agent}.Y_prior{i_consensus}+...
        %             opt_dist.result.consenus{j_agent}.delta_I{i_consensus};
        %         opt_dist.result.est{i_consensus}.y_bar(:,j_agent) = opt_dist.result.consenus{j_agent}.y_prior{i_consensus}+...
        %             opt_dist.result.consenus{j_agent}.delta_i{i_consensus};
        %         det(opt_dist.result.est{1}.Y_cen)/det(opt_dist.result.est{i_consensus}.Y_bar(:,:,j_agent))
        %
        
    end
    
    
    
end

% opt_dist.result.ratio_det_hyb = ratio_det;
end
function consensus_CI()
global opt_dist
for i_agent = 1 : opt_dist.nAgents
    
    opt_dist.result.consenus{i_agent}.Y_prior_CI{1} = opt_dist.result.pred.Y_bar_CI(:,:,i_agent) ;
    opt_dist.result.consenus{i_agent}.y_prior_CI{1} = opt_dist.result.pred.y_bar_CI(:,i_agent);
%     xx = (opt_dist.result.consenus{i_agent}.Y_prior_CI{1})\opt_dist.result.consenus{i_agent}.y_prior_CI{1}
    
    H_CI = opt_dist.result.obs.H_CI{opt_dist.i_step,i_agent};
    z_CI = opt_dist.sim.obs.z_CI{opt_dist.i_step,i_agent};
    opt_dist.result.consenus{i_agent}.delta_I_CI{1} = 1/(opt_dist.sim.obs.r_CI_var{i_agent})*(H_CI'*H_CI) +opt_dist.result.pred.Y_bar_CI(:,:,i_agent);
    opt_dist.result.consenus{i_agent}.delta_i_CI{1} =  1/(opt_dist.sim.obs.r_CI_var{i_agent})*H_CI'*z_CI+ opt_dist.result.pred.y_bar_CI(:,i_agent);
    
%      xx = (opt_dist.result.consenus{i_agent}.delta_I_CI{1})\opt_dist.result.consenus{i_agent}.delta_i_CI{1}

    
    opt_dist.result.consenus{i_agent}.group_set{1} = i_agent;
end

i_consensus = 1;
for j_agent = 1 : opt_dist.nAgents
    opt_dist.result.est{i_consensus}.Y_bar_CI(:,:,j_agent) = opt_dist.result.consenus{j_agent}.delta_I_CI{i_consensus};
    opt_dist.result.est{i_consensus}.y_bar_CI(:,j_agent) = opt_dist.result.consenus{j_agent}.delta_i_CI{i_consensus};
end

for i_consensus = 2:opt_dist.nSteps
    for j_agent = 1 : opt_dist.nAgents
            idx_neighbours = find(opt_dist.dataG.Graph.Adj(j_agent,:));

        I_local_CI =[];i_local_CI=[];P_local_CI=[];x_local_CI=[];
        for j_neigh=1:length(idx_neighbours)
            I_local_CI(:,:,j_neigh) = opt_dist.result.consenus{idx_neighbours(j_neigh)}.delta_I_CI{i_consensus-1};
            i_local_CI(:,:,j_neigh) = (opt_dist.result.consenus{idx_neighbours(j_neigh)}.delta_i_CI{i_consensus-1});
            P_local_CI = inv(I_local_CI(:,:,j_neigh));
%            x_local_CI(:,j_neigh)  = P_local_CI*squeeze(i_local_CI(:,:,j_neigh));
        end
%         x_local_CI
        log_message('Pure CI')
        weights_ci_all=[];inf_mat_ci=[];inf_vect_ci=[];
        [weights_ci_all,inf_mat_ci,inf_vect_ci] =calc_ci_weights_ver3(I_local_CI,(i_local_CI),'det');
%         yy = inf_mat_ci\inf_vect_ci
        opt_dist.result.consenus{j_agent}.Y_prior_CI{i_consensus} = inf_mat_ci;
        opt_dist.result.consenus{j_agent}.y_prior_CI{i_consensus} = inf_vect_ci;
        opt_dist.result.consenus{j_agent}.delta_I_CI{i_consensus} = inf_mat_ci;
        opt_dist.result.consenus{j_agent}.delta_i_CI{i_consensus} = inf_vect_ci;
        opt_dist.result.est{i_consensus}.Y_bar_CI(:,:,j_agent) = opt_dist.result.consenus{j_agent}.Y_prior_CI{i_consensus};
        opt_dist.result.est{i_consensus}.y_bar_CI(:,j_agent) = opt_dist.result.consenus{j_agent}.y_prior_CI{i_consensus};
    end
end

end
