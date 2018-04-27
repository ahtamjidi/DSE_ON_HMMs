function [Network,x_t] = HMM_SimpleSampling(T,MotMdl,initState,Network)
    x_t = zeros(1,T);
    x_t(1,1) = initState;
    
    for i = 1:Network.NumNodes
        Network.Node(i).z = zeros(1,T);
        ProbDistVec = Network.Node(i).ObsMdl(x_t(1,1),:);
        Network.Node(i).z(1,1) = SampleFromDist(ProbDistVec,1);
        Network.Node(i).Prior  = zeros(2,T); 
        Network.Node(i).Pred   = zeros(2,T);
        Network.Node(i).Post   = zeros(2,T);        
        Network.omega(i) = 1/Network.NumNodes;
    end
    
    
    for i = 1:T
        if rand <= Network.ProbOfLinkFail(i)
            Network.isConnected(i) = 0;
        else
            Network.isConnected(i) = 1;
        end
        if i > 1
            ProbDistVec = MotMdl(x_t(1,i-1),:);
            x_t(1,i) = SampleFromDist(ProbDistVec,1);
            for j = 1:Network.NumNodes
                ProbDistVec = Network.Node(j).ObsMdl(x_t(1,i),:);
                Network.Node(j).z(1,i) = SampleFromDist(ProbDistVec,1);
            end
        end
    end    
end
