function SetConfig(World)
    global Config
    %% Set Config   
    Config.BaseRate = 1;
    Config.SimTime = 4; %70
    Config.PixelLen = 1;
    Config.GT_InitState = 11*25;
    Config.DoUpdate = 1;
    
    Config.Network.ConsensusIter = 50; 
    Config.Network.PorbLinkFailure = 0.3;
    Config.Network.NumOfNodes = 6;
    Config.Network.CoonectivityPercentage = 0.1; % a number between 0 and 1. 1 means full connectivity and 0 meanse full disconnection
    Config.Network.RegularityDegree = max([min(2,Config.Network.NumOfNodes-1),floor(Config.Network.CoonectivityPercentage*Config.Network.NumOfNodes)]); % Every node is connected to ... percent of other nodes
             
    Config.Network.Node(1).MotionMdlType = 1;
    Config.Network.Node(1).ObsMdlType = 1;   
    Config.Network.Node(1).MoveDir = [0 1];
    Config.Network.Node(1).ObsDir = [1 0];
    Config.Network.Node(1).Pos(1,:) = [1 7];
    Config.Network.Node(1).ID = 1;
    
    Config.Network.Node(2).MotionMdlType = 1;
    Config.Network.Node(2).ObsMdlType = 1;
    Config.Network.Node(2).MoveDir = [0 -1];
    Config.Network.Node(2).ObsDir = [-1 0];
    Config.Network.Node(2).Pos(1,:) = [World.n_r World.n_c-5];
    Config.Network.Node(2).ID = 2;
    
    Config.Network.Node(3).MotionMdlType = 1;
    Config.Network.Node(3).ObsMdlType = 1;
    Config.Network.Node(3).MoveDir = [-1 0];
    Config.Network.Node(3).ObsDir = [0 1];
    Config.Network.Node(3).Pos(1,:) = [World.n_r-10 1];
    Config.Network.Node(3).ID = 3;
    
    Config.Network.Node(4).MotionMdlType = 1;            
    Config.Network.Node(4).MoveDir = [1 0];                
    Config.Network.Node(4).ObsDir = [0 -1];
    Config.Network.Node(4).Pos(1,:) = [6 World.n_c];
    Config.Network.Node(4).ID = 4;
    Config.Network.Node(4).ObsMdlType = 1;    
    
    Config.Network.Node(5).MotionMdlType = 1;
    Config.Network.Node(5).ObsMdlType = 1;   
    Config.Network.Node(5).MoveDir = [-1 1];
    Config.Network.Node(5).ObsDir = [-1 -1];
    Config.Network.Node(5).Pos(1,:) = [19 18];
    Config.Network.Node(5).ID = 1;    
    
    Config.Network.Node(6).MotionMdlType = 1;
    Config.Network.Node(6).MoveDir = [-1 1];
    Config.Network.Node(6).ObsDir = [1 1];
    Config.Network.Node(6).Pos(1,:) = [6 8];
    Config.Network.Node(6).ID = 6;
    Config.Network.Node(6).ObsMdlType = 1;      
end