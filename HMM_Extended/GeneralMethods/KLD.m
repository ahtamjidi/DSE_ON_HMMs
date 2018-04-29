function d = KLD(P,Q)
    k = 1;
    for i = 1:size(P,1)
        if Q(i,1) == 0
            if P(i,1)> eps
                d = inf;
                return
            end       
        else
            Pn0(k) = P(i,1);
            Qn0(k) = Q(i,1);
            k=k+1;
        end
    end
    Pn0 = Pn0(Pn0~=0);
    Qn0 = Qn0(Pn0~=0);
    d = sum(Pn0.*log(Pn0./Qn0));
end