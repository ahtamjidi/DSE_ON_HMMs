function HMM = InitHMM(World)
    HMM.NumStates = size(World.StatesGrid(World.StatesGrid~=0),1);
    HMM.TransProb = zeros(HMM.NumStates);
    for i = 1:HMM.NumStates
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
            HMM.TransProb(i,World.StatesGrid(ValidJumpCells(j,1),ValidJumpCells(j,2))) = 1/NumValidJumpCells;
        end
    end
end