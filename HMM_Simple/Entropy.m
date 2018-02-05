function En  = Entropy(P)
    En = sum(-P.*log(P));
end