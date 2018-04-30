function d = KLD(P,Q)
    Pn0 = P(P~=0);
    Qn0 = Q(Q~=0);
    d = sum(Pn0.*log(Pn0./Qn0)); 
end

