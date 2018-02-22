function x_t = SampleFromDist(ProbDistVec,NumSamples)
    edges = min([0 cumsum(ProbDistVec)],1); % protect against accumulated round-off
    edges(end) = 1;                         % get the upper edge exact
    [~, x_t] = histc(sort(rand(NumSamples,1)), edges);
end