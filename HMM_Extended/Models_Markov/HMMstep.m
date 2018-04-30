function HMM = HMMstep(HMM,k)
    if k > 1
        ProbDistVec = HMM.MotMdl(HMM.TrueStates(1,k-1),:);
        HMM.TrueStates(1,k) = SampleFromDist(ProbDistVec,1);
    end
end