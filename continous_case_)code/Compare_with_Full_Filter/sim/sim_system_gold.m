function sim_system_gold()
global opt_dist
sim_disconnect_gold()
opt_dist.sim.gt.x_bar = f_sim(opt_dist.result.gt.x_bar,1);
opt_dist.sim.gt.x_bar_history{ opt_dist.i_step} = opt_dist.sim.gt.x_bar;

opt_dist.result.gt.x_bar = opt_dist.sim.gt.x_bar ;

sim_obs_gold();