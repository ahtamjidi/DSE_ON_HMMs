function H = calcEnthrop(p)
    H = -sum(p.*log(p));
end