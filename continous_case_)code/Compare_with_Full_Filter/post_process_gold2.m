function [error_results,opt_dist_result] =post_process_gold2()
global opt_dist

%% calculate error statistics
if opt_dist.FLAGS.compare_with_CI
    error_results.error_ICI =calc_error_stat('ICI');
end
if opt_dist.FLAGS.our_method
    error_results.error_Hybrid =calc_error_stat('Hybrid');
end


%% updating priors for the next step
for i_agent = 1 : opt_dist.nAgents
    if opt_dist.FLAGS.compare_with_CI
        P_ICI = inv(opt_dist.result.est{end}.Y_bar_CI(:,:,i_agent));
        x_ICI = P_ICI*(opt_dist.result.est{end}.y_bar_CI(:,i_agent));
        opt_dist.result.prior.x_bar_CI(:,i_agent) = x_ICI;
        opt_dist.result.prior.P_bar_CI(:,:,i_agent) = P_ICI;
        
    end
    if opt_dist.FLAGS.our_method
        P_Hyb = inv(opt_dist.result.est{end}.Y_bar(:,:,i_agent));
        x_Hyb = P_Hyb*(opt_dist.result.est{end}.y_bar(:,i_agent));
         opt_dist.result.prior.x_bar(:,i_agent) = x_Hyb;
        opt_dist.result.prior.P_bar(:,:,i_agent) = P_Hyb;
    end
end
P_cen = inv(opt_dist.result.est{1}.Y_cen);
x_cen = P_cen*(opt_dist.result.est{1}.y_cen);
opt_dist.result.prior.x_cen = x_cen;
opt_dist.result.prior.P_cen = P_cen;

opt_dist.result.graph = opt_dist.dataG.Graph;




% if opt_dist.FLAGS.debug
%     opt_dist.figures.fig_cov_debug
% end
if any(opt_dist.iter_interest==opt_dist.i_step)
    opt_dist_result = opt_dist.result.est;
else
    opt_dist_result = [];
end



end
function error_mean = calc_error_stat(method)
global opt_dist

max_it = opt_dist.nSteps;
start_step =max_it - 3;
P_cen = inv(opt_dist.result.est{1}.Y_cen);
x_cen = P_cen*(opt_dist.result.est{1}.y_cen);
x_gt =opt_dist.sim.gt.x_bar;

for i_agent=1:opt_dist.nAgents
    P_gold{i_agent} =  opt_dist.result.est_gold{i_agent}.P_bar ;
    x_gold{i_agent} = opt_dist.result.est_gold{i_agent}.x_bar ;
end

for j_agent = 1 : opt_dist.nAgents
    for i_consensus=start_step : max_it;
        error_struct.e_cen(i_consensus - start_step +1) = sqrt(immse(x_cen , x_gt));
        error_struct.con_perc_cen(i_consensus - start_step +1)  = consistency_percentage(x_cen ,x_gt, P_cen  );
        if opt_dist.FLAGS.our_method
            %% Getting the Estimate of Agent j_agent
            switch method
                case 'ICI'
                    P = inv(opt_dist.result.est{i_consensus}.Y_bar_CI(:,:,j_agent));
                    x = P*(opt_dist.result.est{i_consensus}.y_bar_CI(:,j_agent));
                case 'Hybrid'
                    P = inv(opt_dist.result.est{i_consensus}.Y_bar(:,:,j_agent));
                    x = P*(opt_dist.result.est{i_consensus}.y_bar(:,j_agent));
            end
            %% Error Gold vs. Ground Truth
            error_struct.e_gold(i_consensus - start_step +1,j_agent) = sqrt(immse(x_gold{j_agent} , x_gt));

           %% Error Gold vs. centralized
            error_struct.e_gold_vs_cent(i_consensus - start_step +1,j_agent) = sqrt(immse(x_gold{j_agent} , x_cen));
              
            
            %% Error vs. centralized
            error_struct.e_vs_cen(i_consensus - start_step +1,j_agent) = sqrt(immse(x ,  x_cen ));
            
            %% Error vs. gold
            error_struct.e_vs_gold(i_consensus - start_step +1,j_agent) = sqrt(immse(x ,  x_gold{j_agent} ));

            %% Error vs. Ground Truth
            error_struct.e_vs_gt(i_consensus - start_step +1,j_agent) = sqrt(immse(x ,  x_gt ));
            
            %% consistency
            error_struct.con_perc(i_consensus - start_step +1,j_agent)  = consistency_percentage(x,x_gt, P );
            
            %% root of det criteria
            error_struct.e_root_ratio_cent(i_consensus - start_step +1,j_agent) = (det( P_cen) / det(P))^(1/opt_dist.dimState) ;
            error_struct.e_root_ratio_gold(i_consensus - start_step +1,j_agent) = (det( P_gold{j_agent} )/ det(P))^(1/opt_dist.dimState) ;
            
            %% root of det values
            error_struct.e_cent_root(i_consensus - start_step +1,j_agent) = (det( P_cen) )^(1/opt_dist.dimState) ;
            error_struct.e_gold_root(i_consensus - start_step +1,j_agent) = (det( P_gold{j_agent} ))^(1/opt_dist.dimState) ;
            error_struct.e_root(i_consensus - start_step +1,j_agent) = (det( P ))^(1/opt_dist.dimState) ;
            
            %% trace criteria
            error_struct.e_trace_ratio_cent(i_consensus - start_step +1,j_agent) = (trace( P_cen) / trace(P)) ;
            error_struct.e_trace_ratio_gold(i_consensus - start_step +1,j_agent) = (trace( P_gold{j_agent} )/ trace(P)) ;
            
            %% trace values
            error_struct.e_trace_cen(i_consensus - start_step +1,j_agent) = trace( P_cen)  ;
            error_struct.e_trace_gold(i_consensus - start_step +1,j_agent) = trace( P_gold{j_agent})  ;
            error_struct.e_trace(i_consensus - start_step +1,j_agent) = trace( P)  ;
            
            %% Bhattacharya Distance
            error_struct.e_BC_dist_gold(i_consensus - start_step +1,j_agent) = BC_distance(x_gold{j_agent},P_gold{j_agent},x,P);
            error_struct.e_BC_dist_cent(i_consensus - start_step +1,j_agent) = BC_distance(x_cen,P_cen,x,P);
            error_struct.e_BC_dist_gold_vs_cent(i_consensus - start_step +1,j_agent) = BC_distance(x_cen,P_cen,x_gold{j_agent},P_gold{j_agent});

        end
        
    end
    
    
    error_mean.e_cen = mean( error_struct.e_cen(:));
    error_mean.con_perc_cen  = mean( error_struct.con_perc_cen(:) );
    
    %% Error Gold vs. Ground Truth
    error_mean.e_gold = mean(  error_struct.e_gold(:) );

    %% Error Gold vs. centralized
    error_mean.e_gold_vs_cent = mean(  error_struct.e_gold_vs_cent(:) );
    
    %% Error vs. centralized
    error_mean.e_vs_cen = mean( error_struct.e_vs_cen(:) );
    
    %% Error vs. gold
    error_mean.e_vs_gold = mean(  error_struct.e_vs_gold(:) );
    
    %% Error vs. Ground Truth
    error_mean.e_vs_gt = mean( error_struct.e_vs_gt(:) );
    
    %% consistency
    error_mean.con_perc  = mean( error_struct.con_perc(:) );
    
    %% root of det criteria
    error_mean.e_root_ratio_cent = mean( error_struct.e_root_ratio_cent(:) );
    error_mean.e_root_ratio_gold = mean( error_struct.e_root_ratio_gold(:) );
    
    %% root of det values
    error_mean.e_cent_root = mean( error_struct.e_cent_root(:) );
    error_mean.e_gold_root = mean( error_struct.e_gold_root(:) );
    error_mean.e_root = mean( error_struct.e_root(:) );
    
    %% trace criteria
    error_mean.e_trace_ratio_cent = mean( error_struct.e_trace_ratio_cent(:) );
    error_mean.e_trace_ratio_gold = mean( error_struct.e_trace_ratio_gold(:) );
    
    %% trace values
    error_mean.e_trace_cen = mean( error_struct.e_trace_cen(:) );
    error_mean.e_trace_gold = mean( error_struct.e_trace_gold(:) );
    error_mean.e_trace = mean( error_struct.e_trace(:) );
    
    %% Bhattacharya Distance
    error_mean.e_BC_dist_gold = mean( error_struct.e_BC_dist_gold(:) );
    error_mean.e_BC_dist_cent = mean( error_struct.e_BC_dist_cent(:) );
    error_mean.e_BC_dist_gold_vs_cent = mean( error_struct.e_BC_dist_gold_vs_cent(:) );

    
end
end