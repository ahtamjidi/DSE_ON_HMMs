function problem_def_gold(A,x0)
global opt_dist


opt_dist.fid_log = fopen('log.txt','at');
fprintf(opt_dist.fid_log , 'text line number 1 \n');

% opt_dist.save_dir = uigetdir();
opt_dist.FLAGS.compare_with_CI = 1;
opt_dist.FLAGS.our_method = 1;
opt_dist.FLAGS.pure_CI = 0;
opt_dist.FLAGS.debug_CI = 0;
opt_dist.FLAGS.verbose = 0;
opt_dist.nAgents = 9;
opt_dist.dt = 1;
opt_dist.dimAgents = 1;
opt_dist.obs.Range = 1.2;
opt_dist.dimState = size(A,1);
q_var = 10*10^(-5);
r_var = 5*10^(-4);
% Q = q_var*eye(size(A));
% R = r_var*eye(size(C,1));
opt_dist.reg_degree = 4;
opt_dist.n_degree_graph = 9;
opt_dist.obs.rel_perc = 0.1;

opt_dist.obs.R = r_var;
opt_dist.figures.fig_cov_debug = figure;
opt_dist.FLAGS.debug = 0;
opt_dist.FLAGS.debug_consensus = 0;
opt_dist.iter_interest = [1];
opt_dist.FLAGS.obs_noise_type =  'absolute'; % ('absolute' | 'relative');
opt_dist.dimObs =1;%opt_dist.dimAgents;
opt_dist.nIterations = 60;
opt_dist.nSteps = 50;
opt_dist.scenario = '2';
opt_dist.motion.Q = q_var;%(opt_dist.source.Q.*0.1).^2;
% opt_dist.
NUM_SYS             = opt_dist.dimState;   %   DOF of system
L = 1;                      %   Length of the rod
alf = 4.2*1e-5;             %   thermal diffusivity
xlim = [0, L];
dx = (xlim(2) - xlim(1))/ (NUM_SYS-1);
nNodes = opt_dist.dimState ;
r = alf*opt_dist.dt/(dx^2);            % unstable if r > 0.5
x_nodes = x0;
x_state =x_nodes;


%%%% building the graph
full_Adj = ones(opt_dist.nAgents,opt_dist.nAgents);
topol_Adj = zeros(opt_dist.nAgents,opt_dist.nAgents);
for i=1:opt_dist.nAgents
    topol_Adj(i,max(1,i-3):min(opt_dist.nAgents,i+3)) =1;
end
obs_Adj = topol_Adj;
disNode1 = 7; disNode2 = 8; disNode3 = 9; disNode4 = 9;
mask = generate_mask(opt_dist.nAgents,disNode1).*generate_mask(opt_dist.nAgents,disNode2).*generate_mask(opt_dist.nAgents,disNode3).*generate_mask(opt_dist.nAgents,disNode4);
fault_Adj = mask.*obs_Adj;
opt_dist.A = A;
G_full = generate_graph(full_Adj);
G = generate_graph(topol_Adj);
G_fault = generate_graph(fault_Adj);
G_obs = generate_graph(obs_Adj);

opt_dist.Graphs.G_obs = G_obs;
opt_dist.Graphs.G_full = G_full;
opt_dist.Graphs.G = G;
opt_dist.Graphs.G_fault = G_fault;
nv = opt_dist.nAgents    ;
opt_dist.x_gt = x_state(:);%10.*rand(1,opt_dist.nAgents*opt_dist.dimAgents)';%[0  0 0.8 0  1.6 0  2.4 0 3.2 0 4 0 4.8 0 5.6 0 6.4 0 7.2 0 ]';
opt_dist.result.gt.x_bar = opt_dist.x_gt;

x0 = opt_dist.x_gt;
x_mean = mean(x0);
% figure
% imagesc(full(G_fault.Adj))
% imagesc(double(G.Adj))

for i=1:nv
    disp([i,sum(G.p(i,:))]);
end

i_time = 1;
opt_dist.i_time = i_time;

opt_dist.result.prior.x_cen =  x_state(:);
opt_dist.result.prior.P_cen =  0.05.*eye(opt_dist.dimState);
for i_agent = 1 : opt_dist.nAgents
    opt_dist.result.prior.x_bar(:,i_agent) = opt_dist.x_gt;% + randn(size(opt_dist.x_gt,1),1).*sqrt(0.05);
    opt_dist.result.prior.P_bar(:,:,i_agent) = 0.05*eye(opt_dist.dimState);
    if opt_dist.FLAGS.compare_with_CI
        opt_dist.result.prior.x_bar_CI(:,i_agent) = opt_dist.result.prior.x_bar(:,i_agent);
        opt_dist.result.prior.P_bar_CI(:,:,i_agent) = opt_dist.result.prior.P_bar(:,:,i_agent);
    end
    opt_dist.result.initial.x_bar(:,i_agent) = opt_dist.x_gt;% + randn(size(opt_dist.x_gt,1),1).*sqrt(0.05);
    opt_dist.result.initial.P_bar(:,:,i_agent) = 0.05*eye(opt_dist.dimState);
    if opt_dist.FLAGS.compare_with_CI
        opt_dist.result.initial.x_bar_CI(:,i_agent) = opt_dist.result.prior.x_bar(:,i_agent);
        opt_dist.result.initial.P_bar_CI(:,:,i_agent) = opt_dist.result.prior.P_bar(:,:,i_agent);
    end
    
end
