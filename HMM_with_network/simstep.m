function [Graph,X_GT] = simstep(Network,Global,PorbLinkFailure)
% This function should simulate ground truth change and graph change.
% Observations are also made here and we put them in the appropriate
% structure. Here and for now we put them idn Network structure
%% Evolution of State (code for ground truth )

%% Making Observations

%% Simulating Graph Topology change
[flag_coon,Graph] = generate_graph_for_HMM(Global.Graph.Params.RegularityDegree,Global.Graph.Params.NumNodes,PorbLinkFailure);
Graph.flag_coon = flag_coon;
X_GT = [];
end
