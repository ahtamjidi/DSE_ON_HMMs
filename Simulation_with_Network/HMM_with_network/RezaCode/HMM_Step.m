function [Sim] = HMM_Step(HMM,Sim)    
    Sim.GT(Sim.MCtr+1) = SampleFromDist(HMM.TransProb(Sim.GT(Sim.MCtr),:),1);    
    Sim.MCtr = Sim.MCtr+1;
end