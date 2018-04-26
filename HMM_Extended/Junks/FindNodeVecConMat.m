function [NodeVecConnMat] = FindNodeVecConMat(NodeVec,Network)
    ConnComps = conncomp(Network.graph(k));
    NodeVecConnComps = ConnComps(NodeVec);
    i = 1;
    NodeVecConnMat = zeros(length(NodeVec));
    while ~isempty(NodeVec)
        temp = NodeVec(NodeVecConnComps == NodeVecConnComps(1));
        if length(temp) >= 2
            NodeVecConnMat(i,1:size(temp,2)) = temp;
        end
        NodeVec = NodeVec(NodeVecConnComps ~= NodeVecConnComps(1));
        NodeVecConnComps = NodeVecConnComps(NodeVecConnComps ~= NodeVecConnComps(1));
        i = i+1;
    end
    NodeVecConnMat( all(~NodeVecConnMat,2), : ) = [];
    NodeVecConnMat( :, all(~NodeVecConnMat,1) ) = [];
end