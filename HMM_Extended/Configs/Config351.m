function Sim = Config351()
    %% General
    Sim.EndTime = 27*2;
    Sim.seed = 1458;
    Sim.MarkovMdl = 3;    
    Sim.NetworkMdl = 5;    
    Sim.EstimatorMdl = 1;
    %% Markov Model
    Sim.ImageName = 'World2.bmp';
    Sim.InitState = 11*25;
    %% Network Model
    Sim.NumNodes = 6;
    DiagRng = repmat([0.6 0.7],Sim.NumNodes,1);
    DiagRng(1,:) = [0.6 0.7];
    DiagRng(2,:) = [0.6 0.75];
    DiagRng(3,:) = [0.6 0.7];
    DiagRng(4,:) = [0.6 0.75];
    Sim.ObsMdlDiagRng = DiagRng;
    Sim.HomObsMdl = 0;
    Sim.ConnectivityPeriod = 6;
    Sim.RG_k = 1;
    Sim.RG_beta = 0.7;
    %% Node Config
    World = CreateWorld(Sim.ImageName);
    Sim.NodeConfig(1).MotionMdlType = 1;
    Sim.NodeConfig(1).ObsMdlType = 1;   
    Sim.NodeConfig(1).MoveDir = [0 1];
    Sim.NodeConfig(1).ObsDir = [1 0];
    Sim.NodeConfig(1).Pos(1,:) = [1 7];
    Sim.NodeConfig(1).ID = 1;
    
    Sim.NodeConfig(2).MotionMdlType = 1;
    Sim.NodeConfig(2).ObsMdlType = 1;
    Sim.NodeConfig(2).MoveDir = [0 -1];
    Sim.NodeConfig(2).ObsDir = [-1 0];
    Sim.NodeConfig(2).Pos(1,:) = [World.n_r World.n_c-5];
    Sim.NodeConfig(2).ID = 2;
    
    Sim.NodeConfig(3).MotionMdlType = 1;
    Sim.NodeConfig(3).ObsMdlType = 1;
    Sim.NodeConfig(3).MoveDir = [-1 0];
    Sim.NodeConfig(3).ObsDir = [0 1];
    Sim.NodeConfig(3).Pos(1,:) = [World.n_r-10 1];
    Sim.NodeConfig(3).ID = 3;
    
    Sim.NodeConfig(4).MotionMdlType = 1;            
    Sim.NodeConfig(4).MoveDir = [1 0];                
    Sim.NodeConfig(4).ObsDir = [0 -1];
    Sim.NodeConfig(4).Pos(1,:) = [6 World.n_c];
    Sim.NodeConfig(4).ID = 4;
    Sim.NodeConfig(4).ObsMdlType = 1;    
    
    Sim.NodeConfig(5).MotionMdlType = 1;
    Sim.NodeConfig(5).ObsMdlType = 1;   
    Sim.NodeConfig(5).MoveDir = [-1 1];
    Sim.NodeConfig(5).ObsDir = [-1 -1];
    Sim.NodeConfig(5).Pos(1,:) = [19 18];
    Sim.NodeConfig(5).ID = 1;    
    
    Sim.NodeConfig(6).MotionMdlType = 1;
    Sim.NodeConfig(6).MoveDir = [-1 1];
    Sim.NodeConfig(6).ObsDir = [1 1];
    Sim.NodeConfig(6).Pos(1,:) = [6 8];
    Sim.NodeConfig(6).ID = 6;
    Sim.NodeConfig(6).ObsMdlType = 1;
    %% Estimator Model
    Sim.EstDoOpt = 0;
end
