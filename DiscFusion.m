function pF = DiscFusion(p1,p2,omega)
    temp = p1.^omega.*p2.^(1-omega);
    pF = temp./sum(temp);
end