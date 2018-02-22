function En  = Entropy(P)
    Pn0 = P(P~=0);
    En = sum(-Pn0.*log(Pn0));
end