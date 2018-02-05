function sim_disconnect_gold()
global opt_dist fail_prob reg_deg
switch opt_dist.scenario
    case '1'
%         disconnection_interval = (opt_dist.i_step > 2 && opt_dist.i_step<10) ||...
%             (opt_dist.i_step > 16 && opt_dist.i_step<20)||...
%             (opt_dist.i_step > 22 && opt_dist.i_step<30);

   disconnection_interval = (opt_dist.i_step > 2 && opt_dist.i_step<5) ||...
            (opt_dist.i_step > 16 && opt_dist.i_step<20)||...
            (opt_dist.i_step > 22 && opt_dist.i_step<30);
        if disconnection_interval
            opt_dist.dataG.Graph = opt_dist.Graphs.G_fault;
            opt_dist.Graphs.G_obs = opt_dist.Graphs.G_fault;
            flag_coon = isconnected(opt_dist.dataG.Graph.Adj);
            opt_dist.dataG.is_connected =flag_coon;
            
        end
        if ~disconnection_interval
            opt_dist.dataG.is_connected = 1;
            opt_dist.dataG.Graph = opt_dist.Graphs.G;
            opt_dist.Graphs.G_obs = opt_dist.Graphs.G;
            flag_coon = isconnected(opt_dist.dataG.Graph.Adj);
            opt_dist.dataG.is_connected =flag_coon;
 
        end
    case '2'
        [flag_coon,G] = generate_graph_for_diag(opt_dist.reg_degree,opt_dist.n_degree_graph,fail_prob);
        %         flag_coon
        opt_dist.Graphs.G_obs = G;
        opt_dist.dataG.Graph = G;
        opt_dist.dataG.is_connected = flag_coon;
    case '3'
        [flag_coon,G] = generate_graph_for_diag_shell(opt_dist.reg_degree,opt_dist.n_degree_graph,fail_prob);
        %         flag_coon
        opt_dist.Graphs.G_obs = G;
        opt_dist.dataG.Graph = G;
        opt_dist.dataG.is_connected = flag_coon;        
    otherwise
        disp('The scenario is not programmed')
end
opt_dist.Graph_History{opt_dist.i_step} = opt_dist.dataG.Graph.p; 


end