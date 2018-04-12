function [Network] = FHS(Global,Network,k)
    %% Find the connected component
    con = find(Network.isConnected(:,k))';
    discon = find(~Network.isConnected(:,k))';
    NumConNodes = size(con,2);
    %% Update ConHist
    % At time k node i has the observations of node j up to the time given by Network.ConHist(i,j,k)
    if k ~= 1 
        % Initialize Network.ConHist for time k from time k-1
        Network.ConHist(:,:,k) = Network.ConHist(:,:,k-1);
        % Update the diagonal terms (each node has its own observation at least time k)
        Network.ConHist(:,:,k) = Network.ConHist(:,:,k)+eye(Network.NumNodes,Network.NumNodes);
    end
    if NumConNodes > 0 
        % Set up ConHist such that the i'th node observations are available 
        % to the connected component from start until the time in ConHist(i) 
        ConHist = max(Network.ConHist(con,:,k));
        Network.ConHist(con,:,k) = repmat(ConHist,NumConNodes,1);
    end
    %% Update disconnected nodes 
    for i = discon
        Network.Node(i).Pred(:,k) = Global.MotMdl'*Network.Node(i).Prior(:,k);
        Network.Node(i).Post(:,k) = Network.Node(i).Pred(:,k).*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,k));
        Network.Node(i).Post(:,k) = Network.Node(i).Post(:,k)/sum(Network.Node(i).Post(:,k));
    end
    %% Update connected nodes (if any!)
    if NumConNodes > 0 
        for t = 1:k
            if t==1
                Prior = Network.Node(con(1)).Prior(:,t);
            end
            Pred = Global.MotMdl'*Prior;
            Post = Pred;
            for i = 1:Network.NumNodes
                if t <= ConHist(i);
                    Post = Post.*Network.Node(i).ObsMdl(:,Network.Node(i).z(1,t));
                end
            end
            Post = Post/sum(Post);
            Prior = Post;
        end
        for i = 1:NumConNodes
            Network.Node(con(i)).Prior(:,k) = Prior;
            Network.Node(con(i)).Pred(:,k) = Pred;
            Network.Node(con(i)).Post(:,k) = Post;
        end
    end
end