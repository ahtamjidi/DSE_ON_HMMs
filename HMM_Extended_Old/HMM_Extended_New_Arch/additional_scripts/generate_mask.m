function mask = generate_mask(szN,disNode)
mask = blkdiag(ones(disNode,disNode),ones(szN-disNode,szN-disNode));
end
% disNode = 3;
% szN = 6;