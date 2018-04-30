function [WeightMat,AdjMat] = EvalConsWeightMat(G)
    AdjMat = G.adjacency;
    nv = G.numnodes;
    deg = G.degree;
    WeightMat = zeros(nv);
    for i=1:nv
        for j=1:nv
            if AdjMat(i,j)~=0 && i~=j            
                WeightMat(i,j) = min(1/deg(i),1/deg(j));
            end        
        end
        WeightMat(i,i) = 1 - sum(WeightMat(i,:));
    end
end