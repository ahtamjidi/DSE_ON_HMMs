function [Sim,HMM] = HMMinit_3(Sim)
    World = CreateWorld(Sim.ImageName);
    Sim.World = World;
    Sim.NumStates = World.NumStates;
    HMM.NumStates = Sim.NumStates;
    HMM.MotMdl = zeros(Sim.NumStates);
    for i = 1:Sim.NumStates 
        ValidJumpCells = [];
        [ValidJumpCells(1,1),ValidJumpCells(1,2)] = find(World.StatesGrid == i);
        AllJumpCells = [ValidJumpCells(1,1)   ,ValidJumpCells(1,2);...
                        ValidJumpCells(1,1)+1 ,ValidJumpCells(1,2)  ; ValidJumpCells(1,1)-1,ValidJumpCells(1,2);  ...
                        ValidJumpCells(1,1)   ,ValidJumpCells(1,2)+1; ValidJumpCells(1,1)  ,ValidJumpCells(1,2)-1;...
                        ValidJumpCells(1,1)+1 ,ValidJumpCells(1,2)+1; ValidJumpCells(1,1)-1,ValidJumpCells(1,2)-1;...
                        ValidJumpCells(1,1)+1 ,ValidJumpCells(1,2)-1; ValidJumpCells(1,1)-1,ValidJumpCells(1,2)+1];
        NumValidJumpCells = 1;
        for j = 2:size(AllJumpCells,1)
            if ~(any(AllJumpCells(j,:)<1) || AllJumpCells(j,1)>World.n_r || AllJumpCells(j,2)>World.n_c || World.StatesGrid(AllJumpCells(j,1),AllJumpCells(j,2))==0) 
                NumValidJumpCells = NumValidJumpCells+1;
                ValidJumpCells(NumValidJumpCells,:) = AllJumpCells(j,:);                
            end
        end
        for j = 1:NumValidJumpCells
            HMM.MotMdl(i,World.StatesGrid(ValidJumpCells(j,1),ValidJumpCells(j,2))) = 1/NumValidJumpCells;
        end
    end
    HMM.TrueStates = zeros(1,Sim.EndTime); % HMM true states vector
    HMM.TrueStates(1,1) = Sim.InitState; % HMM initial State    
end