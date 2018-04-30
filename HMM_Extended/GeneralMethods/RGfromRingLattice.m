function g = RGfromRingLattice(RL,beta)
    [N,K] = size(RL.s);
    for n=1:N    
        switchEdge = rand(K, 1) < beta;
        RL.t(n,switchEdge) = N+1;
    end
    g = graph([RL.s (1:N)'],[RL.t (1:N)']);
    g = g.rmnode(N+1);
end