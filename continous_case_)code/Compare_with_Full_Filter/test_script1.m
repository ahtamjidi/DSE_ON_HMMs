
 % checking additional information
 clc
 for ii_agent = 1:9

     if ii_agent<=7
         delta_I1{ii_agent} = 7*opt_dist.result.consenus{ii_agent}.delta_I{50};
     else
         delta_I1{ii_agent} =  opt_dist.result.consenus{ii_agent}.delta_I{50};
     end
     delta_I2{ii_agent} = opt_dist.result.consenus{ii_agent}.delta_I{50};
 
 % checking prediction information
     pred1{ii_agent} = opt_dist.result.pred.Y_bar(:,:,ii_agent);
     pred2{ii_agent} = result{ii_agent}.Y_pred_{3};
     
% checking updates
     update1{ii_agent} =  pred1{ii_agent} +   delta_I1{ii_agent} ;
     update2{ii_agent} =  pred2{ii_agent} +   delta_I2{ii_agent} ;

     update3{ii_agent} =  opt_dist.result.est{50}.Y_bar(:,:,ii_agent);
     update4{ii_agent} =  result{ii_agent}.Y_update_{3};
     
     max(max(pinv(update3{ii_agent}) - opt_dist.result.est_gold{ii_agent}.P_bar))
     
%  max(max(update1{ii_agent} - update2{ii_agent}))
%  max(max(update1{ii_agent} - update3{ii_agent}))
%  max(max(update1{ii_agent} - update4{ii_agent})) 
 end
 
 for i=1:9
     update1{i}
 end
 close all
 figure
 plot(squeeze(mean_.e_BC_dist_gold_vs_cent(1,:,1))); hold on;
 plot(squeeze(mean_.e_BC_dist_cent(1,:,1))); hold on;
 plot(squeeze(mean_.e_BC_dist_cent(1,:,2))); hold on;
 
 range_prob = [ 0 0.2  0.4 0.6 0.8 1];
% range_prob = [ 0.4 0.6 0.8 ];




% range_reg = [ 2 4 6 8];
range_reg = [ 4];

    range_step = 50;

 mean_ = calc_composite_results_gold(error_results,length(range_reg),length(range_prob),range_step)

 
 close all
 figure
 plot(squeeze(mean_.e_gold(1,:,1)),'LineWidth',3); hold on;
 plot(squeeze(mean_.e_vs_gt(1,:,1)),'LineWidth',3); hold on;
 plot(squeeze(mean_.e_vs_gt(1,:,2)),'LineWidth',3); hold on;
 legend('Gold Standard','Hybrid','ICI')
title('Average performance comparison vs. Full Infomration Estimator')
xlabel('Probability of Failure')
xlabel('D_B (Bhattacharyya distance)')
 grid on;
 
 
                     e_cen: [1x6x2 double]
              con_perc_cen: [1x6x2 double]
                    e_gold: [1x6x2 double]
            e_gold_vs_cent: [1x6x2 double]
                  e_vs_cen: [1x6x2 double]
                 e_vs_gold: [1x6x2 double]
                   e_vs_gt: [1x6x2 double]
                  con_perc: [1x6x2 double]
         e_root_ratio_cent: [1x6x2 double]
         e_root_ratio_gold: [1x6x2 double]
               e_cent_root: [1x6x2 double]
               e_gold_root: [1x6x2 double]
                    e_root: [1x6x2 double]
        e_trace_ratio_cent: [1x6x2 double]
        e_trace_ratio_gold: [1x6x2 double]
               e_trace_cen: [1x6x2 double]
              e_trace_gold: [1x6x2 double]
                   e_trace: [1x6x2 double]
            e_BC_dist_gold: [1x6x2 double]
            e_BC_dist_cent: [1x6x2 double]
    e_BC_dist_gold_vs_cent: [1x6x2 double]
 
 for i=1:50
  a(i) = error_results{j_reg,i_prob,i}.error_Hybrid.e_BC_dist_gold_vs_cent;
 end