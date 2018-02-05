clc
global opt_dist
names = fieldnames(error_results{1}.error_ICI.mean);
for i_step=1:opt_dist.i_step
    for j_field = 1:numel(names)
        var_name = eval(['names(',num2str(j_field), ')']);
        ICI_field = ( ['error_results{',num2str(i_step),'}.error_ICI.mean.',var_name{1}]);
        Hyb_field = ( ['error_results{',num2str(i_step),'}.error_Hybrid.mean.',var_name{1}]);
        eval ([var_name{1},'(:,',num2str(i_step),') = [',Hyb_field,';',ICI_field,']']) ;
    end
end
clc
e_cen
e_gold
e_vs_cen
e_vs_gt
e_BC_dist_gold
e_BC_dist_cent
e_BC_dist_gold_vs_cent
close all
    for j_field = 1:numel(names)
        figure
        var_name = eval(['names(',num2str(j_field), ')']);
        eval(['plot(',var_name{1},'(1,:))'])
        hold on
        eval(['plot(',var_name{1},'(2,:))'])

        eval(['title(''',var_name{1},''')']);
        
        legend('Hybrid','ICI')
    end
    
figure
plot(e_BC_dist_gold_vs_cent(1,:),'LineWidth',3); hold on;
plot(e_BC_dist_cent(1,:),'LineWidth',3); hold on;
plot(e_BC_dist_cent(2,:),'LineWidth',3); hold on;
legend('Gold Standard','Hybrid','ICI')
title('Performance comparison vs. Full Infomration Estimator')
xlabel('Step')
xlabel('D_B (Bhattacharyya distance)')
grid on

    
% names = fieldnames(error_results{i}.error_ICI.mean)