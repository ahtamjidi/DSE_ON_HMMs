function Ent = EntropyCostFuncAMD(omega,Network,k)
    Prior = zeros(size(Network.Node(1).Prior(:,k)));
    for i = 1:Network.NumNodes
        Prior = Prior+Network.Node(i).Prior(:,k).*omega(i);
    end
    Prior = Prior/sum(Prior);
    Ent = Entropy(Prior);
end