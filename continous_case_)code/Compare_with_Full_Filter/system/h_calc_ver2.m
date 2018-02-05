function [h,H,idx_vis]=h_calc_ver2(x_pred,varargin)
global opt_dist

if nargin>1
    idx_agent_range=varargin{1};
else
    idx_agent_range=1:opt_dist.nAgents;
end

idx_vis = [];
H = [];
h = [];
for idx_agent=idx_agent_range
    H_temp = zeros(opt_dist.dimObs,size(opt_dist.x_gt,1));
    h_temp = opt_dist.C(idx_agent,:) * x_pred;
    %         if norm(z_temp) <=opt_dist.obs.Range
    idx_vis = [idx_vis,idx_agent];
    h = [h;h_temp];
    H_temp = opt_dist.C(idx_agent,:);
    H = [H;H_temp];
end
end