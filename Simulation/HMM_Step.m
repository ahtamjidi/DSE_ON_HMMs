function [Sim,Net] = HMM_Step(World,HMM,Net,Sim)    
    %% Update Markove States
    Sim.GT(Sim.MCtr+1) = SampleFromDist(HMM.TransProb(Sim.GT(Sim.MCtr),:),1);
    %% Update Observers 
    for i = 1:Net.NumOfNodes
        Net.Node(i) = UpdateNodeMotion(World,Sim,Net.Node(i));
        Net.Node(i) = UpdateNodeObservation(World,Net.Node(i),Sim.GT(Sim.MCtr+1),Sim.MCtr+1);
    end
    Sim.MCtr = Sim.MCtr+1;
end