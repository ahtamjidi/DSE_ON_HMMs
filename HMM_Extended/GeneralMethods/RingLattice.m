function RL = RingLattice(N,K)
    RL.s = repelem((1:N)',1,K);
    RL.t = RL.s + repmat(1:K,N,1);
    RL.t = mod(RL.t-1,N)+1;
end