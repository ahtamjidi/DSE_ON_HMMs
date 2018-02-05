function calc_super_gold_update()
global opt_dist
for i_agent = 1 : opt_dist.nAgents
    run_full_filter(i_agent)
end
end
function run_full_filter(i_agent)
global opt_dist
persistent connection_history
 connection_history{i_agent,opt_dist.i_step}.history = zeros(1,opt_dist.nAgents);
[size_group,nComponents,members] = networkComponents_gold(opt_dist.Graph_History{opt_dist.i_step});
universe_of_agents = [1 : opt_dist.nAgents];
% for i_agent = 1 : opt_dist.nAgents
    % the agents that I am in contact with at the momemnt already give me
    % their most uptodate history of observations
    
    neigbours=members{nComponents(i_agent)};
    non_neighbours = setdiff(universe_of_agents,neigbours);
    for i_neighbour = 1:numel(neigbours)
        connection_history{i_agent,opt_dist.i_step}.history(neigbours(i_neighbour)) = opt_dist.i_step;
    end
    % check the history of the neighbours and yourself to find the most recent record of agents' observations
    % do this only for the agents not considered in the previous step.
    % They are already taken care of
    if opt_dist.i_step~=1
        for i_non_neighbour = 1:numel(non_neighbours) % for all non neighbours
            most_recent_seen = connection_history{i_agent,opt_dist.i_step-1}.history(non_neighbours(i_non_neighbour));
            for j_neighbour = 1:numel(neigbours)
                most_recent_seen = max(most_recent_seen,...
                                      connection_history{i_agent,opt_dist.i_step-1}.history(non_neighbours(i_non_neighbour)) );
            end
        connection_history{i_agent,opt_dist.i_step}.history(non_neighbours(i_non_neighbour)) = most_recent_seen;
        end
    end
% end

% initialization
x_bar = opt_dist.result.initial.x_bar(:,i_agent);
P_bar =  opt_dist.result.initial.P_bar(:,:,i_agent);

x_update = x_bar;
P_update = P_bar;

for i_step = 1 : opt_dist.i_step
    % predict
    [x_pred,P_pred] = f(x_update,P_update,0);
    Y_bar = pinv(P_pred);
    y_bar = Y_bar*x_pred;
    % calc update
    delta_I = zeros(size(Y_bar));
    delta_i = zeros(size(y_bar));
    
%     [size_group,nComponents,members] = networkComponents_gold(opt_dist.Graph_History{i_step});
%     neigbours=members{nComponents(i_agent)};
    [delta_I,delta_i] = collect_observations( connection_history{i_agent,opt_dist.i_step}.history,i_step,delta_I,delta_i);
    
%     for i_neighbour = 1:numel(neigbours)
%         H = opt_dist.result.obs.H{i_step,neigbours(i_neighbour)};
%         z = opt_dist.sim.obs.z{i_step,neigbours(i_neighbour)};
%         delta_I = delta_I + 1/(opt_dist.sim.obs.r_var{i_step,neigbours(i_neighbour)})*(H'*H);
%         delta_i = delta_i +  1/(opt_dist.sim.obs.r_var{i_step,neigbours(i_neighbour)})*H'*z;
%     end
    % update
    Y_update = Y_bar + delta_I;
    y_update = y_bar + delta_i;
    
    P_update = pinv(Y_update);
    x_update = P_update*y_update;
end
opt_dist.result.est_gold{i_agent}.Y_bar = Y_update;
opt_dist.result.est_gold{i_agent}.y_bar = y_update;
opt_dist.result.est_gold{i_agent}.P_bar = P_update;
opt_dist.result.est_gold{i_agent}.x_bar = x_update;

x_update

opt_dist.connection_history = connection_history;

end
function [delta_I,delta_i] = collect_observations(connection_history,i_step,delta_I,delta_i)

global  opt_dist
    for i_agent = 1: opt_dist.nAgents
        if connection_history(i_agent)>=i_step
        H = opt_dist.result.obs.H{i_step,i_agent};
        z = opt_dist.sim.obs.z{i_step,i_agent};
        delta_I = delta_I + 1/(opt_dist.sim.obs.r_var{i_step,i_agent})*(H'*H);
        delta_i = delta_i +  1/(opt_dist.sim.obs.r_var{i_step,i_agent})*H'*z;
        end
    end
end