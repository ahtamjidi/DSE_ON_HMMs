Network.Node(i).Prior  = zeros(2,Sim.EndTime); 
        Network.Node(i).Pred   = zeros(2,Sim.EndTime);
        Network.Node(i).Post   = zeros(2,Sim.EndTime);        
        Network.omega(i) = 1/Network.NumNodes;