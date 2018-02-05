function [Sim,Net] = HMM_Step(World,HMM,Net,Sim)    
    %% Update Markove States
    global Config
    Sim.GT(Sim.MCtr+1) = SampleFromDist(HMM.TransProb(Sim.GT(Sim.MCtr),:),1);
    %% Update Observers
    for i = 1:Net.NumOfNodes
        Net.Node(i) = UpdateNodeMotion(World,Sim,Net.Node(i));
            Net.Node(i) = UpdateNodeObservation(World,Net.Node(i),Sim.GT(Sim.MCtr+1),Sim.MCtr+1);
        if Config.DoUpdate  
            Net.Node(i).ObsMdl = GenNodeObsMdl(World,Net.Node(i),Sim.MCtr+1);
        end
    end
    Sim.MCtr = Sim.MCtr+1;
end