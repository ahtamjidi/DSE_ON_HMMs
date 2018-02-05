function [av_delta_I,av_delta_i] = calculate_aver_info_gold()
% result.consenus{i_agent}.delta_I{1}
global opt_dist
for i_agent = 1 : opt_dist.nAgents

   H = opt_dist.result.obs.H{opt_dist.i_step,i_agent};
    z = opt_dist.sim.obs.z{opt_dist.i_step,i_agent};
   delta_I{i_agent} = 1/(opt_dist.sim.obs.r_var{i_agent})*(H'*H);
    delta_i{i_agent} =  1/(opt_dist.sim.obs.r_var{i_agent})*H'*z;
end
av_delta_I = zeros(size(delta_I{1}));
av_delta_i = zeros(size(delta_i{1}));
for i_agent=1:9
    av_delta_I = av_delta_I + delta_I{i_agent};
    av_delta_i = av_delta_i + delta_i{i_agent};
end
av_delta_I = (1/9)*av_delta_I;
av_delta_i = (1/9)*av_delta_i;
end