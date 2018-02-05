function [x_next,P_next] = f(x_current,P_current,flag_noise)
global opt_dist
if flag_noise
    delta_noise =  randn(size(x_current))*sqrt(opt_dist.motion.Q);
    x_next = opt_dist.A*x_current + opt_dist.B*( opt_dist.source.Q') + delta_noise;
    P_next = opt_dist.A*P_current*opt_dist.A' + (opt_dist.motion.Q)*eye(size(x_next,1));
    
    if opt_dist.FLAGS.debug
        percent_of_noise = 100*(delta_noise./x_next);
        disp(['Percentage of input Noise = ', num2str(mean(percent_of_noise))])
        disp('---------------------')
%         disp(percent_of_noise)
        disp('---------------------')
    end
    
else
    x_next = opt_dist.A*x_current + opt_dist.B* opt_dist.source.Q';
    P_next = opt_dist.A*P_current*opt_dist.A' +(opt_dist.motion.Q)*eye(size(x_next,1));

    
end
end


%% before correction 

% % % % function [x_next,P_next] = f(x_current,P_current,flag_noise)
% % % % global opt_dist
% % % % if flag_noise
% % % %     delta_noise = randn(size(opt_dist.source.Q')).*sqrt(opt_dist.motion.Q');
% % % %     u_noisy = opt_dist.source.Q' +delta_noise ;
% % % %     if opt_dist.FLAGS.debug 
% % % %         percent_of_noise = 100*(delta_noise./opt_dist.source.Q');
% % % %         disp(['Percentage of input Noise = ', num2str(mean(percent_of_noise))])
% % % %         disp('---------------------')
% % % %         disp(percent_of_noise)
% % % %         disp('---------------------')
% % % %     end
% % % %     x_next = opt_dist.A*x_current + opt_dist.B*( opt_dist.source.Q') + randn(size(x_current))*opt_dist.motion.Q);
% % % %     P_next = opt_dist.A*P_current*opt_dist.A'+opt_dist.B*diag(ones(1,length(opt_dist.source.Q'))*diag(opt_dist.motion.Q))*opt_dist.B';
% % % % else
% % % %     x_next = opt_dist.A*x_current + opt_dist.B* opt_dist.source.Q';
% % % % %     P_next = P_current;
% % % %     P_next = opt_dist.A*P_current*opt_dist.A'+opt_dist.B*diag(ones(1,length(opt_dist.source.Q'))*daig(opt_dist.motion.Q))*opt_dist.B';
% % % % 
% % % %     
% % % % end
% % % % end