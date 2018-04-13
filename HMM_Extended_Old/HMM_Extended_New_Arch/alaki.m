for i = 1: size(Network.isConnected,2)
    if Network.isConnected(i)==1
        patch([i-1 i i i-1],[1 1 0 0],'r','EdgeColor','none');
    end
end