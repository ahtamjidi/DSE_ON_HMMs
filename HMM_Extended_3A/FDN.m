function [Network] = FDN(Global,Network,k)
% Assumes fully disconnected network (#7)
    for i = 1:Network.NumNodes
        Network.Node(i).Pred(:,k) = Global.MotMdl'*Network.Node(i).Prior(:,k);
        Network.Node(i).Post(:,k) = Network.Node(i).Pred(:,k).*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
        Network.Node(i).Post(:,k) = Network.Node(i).Post(:,k)/sum(Network.Node(i).Post(:,k));
    end
end