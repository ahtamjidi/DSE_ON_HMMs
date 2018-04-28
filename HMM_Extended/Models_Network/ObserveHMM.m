function [Network] = ObserveHMM(~,HMM,Network,k)
    for i = 1:Network.NumNodes
            ProbDistVec = Network.Node(i).ObsMdl(HMM.TrueStates(1,k),:);
            Network.Node(i).z(1,k) = SampleFromDist(ProbDistVec,1);
    end
end