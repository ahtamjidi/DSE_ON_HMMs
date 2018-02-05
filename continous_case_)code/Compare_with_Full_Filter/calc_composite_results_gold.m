function mean_ = calc_composite_results_gold(error_results,j_re_max,i_prob_max,i_step_max)
names = fieldnames(error_results{1,1,1}.error_ICI);

for j_field = 1:numel(names)
    for j_reg=1:j_re_max
        for i_prob=1:i_prob_max
            for i_step=1:i_step_max

                var_name = eval(['names(',num2str(j_field), ')']);
                ICI_field = ( ['error_results','{',num2str(j_reg),',',num2str(i_prob),',',num2str(i_step),'}.','error_ICI.',var_name{1},';']);
                Hyb_field = ( ['error_results','{',num2str(j_reg),',',num2str(i_prob),',',num2str(i_step),'}.','error_Hybrid.',var_name{1},';']);
                
                eval ([var_name{1},'(',num2str(j_reg),',',num2str(i_prob),',',num2str(i_step),',1) = ',Hyb_field])
                eval ([var_name{1},'(',num2str(j_reg),',',num2str(i_prob),',',num2str(i_step),',2) = ',ICI_field])
            end
        end
    end
end


for j_field = 1:numel(names)
    for j_reg=1:j_re_max
        for i_prob=1:i_prob_max
            for i_step=1:i_step_max

                var_name = eval(['names(',num2str(j_field), ')']);
                eval (['mean_.',var_name{1},'(',num2str(j_reg),',',num2str(i_prob),',1) = mean(squeeze(',...
                    var_name{1},'(',num2str(j_reg),',',num2str(i_prob),',:,1)));'])

                eval (['mean_.',var_name{1},'(',num2str(j_reg),',',num2str(i_prob),',2) = mean(squeeze(',...
                    var_name{1},'(',num2str(j_reg),',',num2str(i_prob),',:,2)));'])

            end
        end
    end
end

mean_
close all
 figure
 plot(squeeze(mean_.e_BC_dist_gold_vs_cent(1,:,1)),'LineWidth',3); hold on;
 plot(squeeze(mean_.e_BC_dist_cent(1,:,1)),'LineWidth',3); hold on;
 plot(squeeze(mean_.e_BC_dist_cent(1,:,2)),'LineWidth',3); hold on;
 legend('Gold Standard','Hybrid','ICI')
title('Average performance comparison vs. Full Infomration Estimator')
xlabel('Probability of Failure')
ylabel('D_B (Bhattacharyya distance)')
 grid on;
end