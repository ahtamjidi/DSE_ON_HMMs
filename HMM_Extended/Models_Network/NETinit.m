function [Network] = NETinit(Sim,HMM)
    %% First and formost is the number of nodes!
    Network.NumNodes = Sim.NumNodes;
    %% Initializing an estimator
    Est.Prior  = zeros(HMM.NumStates,Sim.EndTime);
    Est.Pred   = zeros(HMM.NumStates,Sim.EndTime);
    Est.Post   = zeros(HMM.NumStates,Sim.EndTime);
    Est.Prior(:,1) = Sim.Prior0;
    Est.omega = 1/Network.NumNodes;
    %% Building the estimators and graphs
    Network.CEN_Est = Est;
    for i = 1:Network.NumNodes
        Network.Node(i).z = zeros(1,Sim.EndTime);
        Network.Node(i).HYB_Est = Est;
        Network.Node(i).ICF_Est = Est;
        Network.Node(i).FHS_Est = Est;        
    end
    for k = 1:Sim.EndTime
        Network.graph{k} = graph(eye(Network.NumNodes)~=0);
        Network.ConComps{k} = {};
    end
end