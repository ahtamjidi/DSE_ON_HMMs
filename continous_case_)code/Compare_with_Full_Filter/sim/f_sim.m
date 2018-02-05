function x_next = f_sim(x_current,flag_noise)
global opt_dist
if flag_noise
    
     delta_noise =  randn(size(x_current))*sqrt(opt_dist.motion.Q);
    x_next = opt_dist.A*x_current + opt_dist.B*( opt_dist.source.Q') + delta_noise;
     if opt_dist.FLAGS.debug 
        percent_of_noise = 100*(delta_noise./x_next);
        disp(['Percentage of input Noise = ', num2str(mean(percent_of_noise))])
        disp('---------------------')
        disp(mean(percent_of_noise))
        disp('---------------------')
    end
    
else
    x_next = opt_dist.A*x_current + opt_dist.B*opt_dist.source.Q';
end
end







% % % % % % function x_next = f_sim(x_current,flag_noise)
% % % % % % global opt_dist
% % % % % % if flag_noise
% % % % % %     
% % % % % %      delta_noise =  randn(size(opt_dist.source.Q')).*sqrt(opt_dist.motion.Q');
% % % % % %     u_noisy = opt_dist.source.Q' +delta_noise ;
% % % % % %     if opt_dist.FLAGS.debug 
% % % % % %         percent_of_noise = 100*(delta_noise./opt_dist.source.Q');
% % % % % %         disp(['Percentage of input Noise = ', num2str(mean(percent_of_noise))])
% % % % % %         disp('---------------------')
% % % % % %         disp(percent_of_noise)
% % % % % %         disp('---------------------')
% % % % % %     end
% % % % % %     
% % % % % %     
% % % % % %     
% % % % % % %     x_next = opt_dist.A*x_current + opt_dist.B*(opt_dist.source.Q'+ randn(size(opt_dist.source.Q')).*sqrt((opt_dist.motion.Q)));
% % % % % %     x_next = opt_dist.A*x_current + opt_dist.B*(opt_dist.source.Q'+ randn(size(opt_dist.source.Q')).*sqrt((opt_dist.motion.Q)));
% % % % % % 
% % % % % %      if opt_dist.FLAGS.debug 
% % % % % %         percent_of_noise = 100*(u_noisy./opt_dist.source.Q');
% % % % % %         disp(['Percentage of input Noise = ', num2str(mean(percent_of_noise))])
% % % % % %         disp('---------------------')
% % % % % %         disp(percent_of_noise)
% % % % % %         disp('---------------------')
% % % % % %     end
% % % % % %     
% % % % % % else
% % % % % %     x_next = opt_dist.A*x_current + opt_dist.B*opt_dist.source.Q';
% % % % % % end
% % % % % % end
% % % % % % 
