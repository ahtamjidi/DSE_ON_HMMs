function result = calc_gold_update_debug()
global opt_dist
for i_agent = 1 : opt_dist.nAgents
    result{i_agent} = run_full_filter(i_agent);
end
end
function est_gold=run_full_filter(i_agent)
global opt_dist
% initialization
est_gold = [];
x_bar = opt_dist.result.initial.x_bar(:,i_agent);
P_bar =  opt_dist.result.initial.P_bar(:,:,i_agent);

x_update = x_bar;
P_update = P_bar;
Y_update = pinv(P_update);
y_update = Y_update*x_update;
for i_step = 1 : opt_dist.i_step
    
   [size_group,nComponents,members] = networkComponents_gold(opt_dist.Graph_History{i_step});
    neigbours=members{nComponents(i_agent)};    
    
    
    
    est_gold.Y_prior_{i_step} = Y_update;
    est_gold.y_prior_{i_step} = y_update;
    est_gold.P_prior_{i_step} = P_update;
    est_gold.x_prior_{i_step} = x_update;
    
    % predict
    [x_pred,P_pred] = f(x_update,P_update,0);
    Y_pred = pinv(P_pred);
    y_pred = Y_pred*x_pred;
    est_gold.Y_pred_{i_step} = Y_pred;
    est_gold.y_pred_{i_step} = y_pred;
    est_gold.P_pred_{i_step} = P_pred;
    est_gold.x_pred_{i_step} = x_pred;
    
    
    % calc update
    delta_I = zeros(size(Y_pred));
    delta_i = zeros(size(y_pred));
    for i_neighbour = 1:numel(neigbours)
       H = opt_dist.result.obs.H{i_step,neigbours(i_neighbour)};
        z = opt_dist.sim.obs.z{i_step,neigbours(i_neighbour)};
        delta_I = delta_I + 1/(opt_dist.sim.obs.r_var{i_step,neigbours(i_neighbour)})*(H'*H);
        delta_i = delta_i +  1/(opt_dist.sim.obs.r_var{i_step,neigbours(i_neighbour)})*H'*z;
    end
    est_gold.delta_I_{i_step} = delta_I;
    est_gold.delta_i_{i_step} = delta_i;
    
    
    
    % update
    Y_update = Y_pred + delta_I;
    y_update = y_pred + delta_i;
    
    P_update = pinv(Y_update);
    x_update = P_update*y_update;
    
    est_gold.Y_update_{i_step} = Y_update;
    est_gold.y_update_{i_step} = y_update;
    est_gold.P_update_{i_step} = P_update;
    est_gold.x_update_{i_step} = x_update;
    
    
end


x_update


end
