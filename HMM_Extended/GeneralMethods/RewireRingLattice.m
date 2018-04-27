function g = RewireRingLattice(RL,beta)
    [N,K] = size(RL.s);
    for n=1:N    
        switchEdge = rand(K, 1) < beta;
        newTargets = rand(N, 1);
        newTargets(n) = 0;
        newTargets(RL.s(RL.t==n)) = 0;
        newTargets(RL.t(n, ~switchEdge)) = 0;
        [~, ind] = sort(newTargets, 'descend');
        RL.t(n, switchEdge) = ind(1:nnz(switchEdge));
    end
    g = graph(RL.s,RL.t);
end