function PZ_S = PofZgivenS_Row_BeamMdl(World,Node,TargetState,k)
    [TargetCell(1,1),TargetCell(1,2)] = find(World.StatesGrid == TargetState);
    PZ_S = zeros(1,World.NumStates+1);
    ObsStates = -ones(1,World.DiagLen);
    Cell = Node.Config.Pos(k,:);
    TargetFound = false;
    i = 1;
    while ~(any(Cell(1,:)<1) || Cell(1,1)>World.n_r || Cell(1,2)>World.n_c || World.StatesGrid(Cell(1,1),Cell(1,2))==0)
        ObsStates(1,i) = World.StatesGrid(Cell(1,1),Cell(1,2));
        if all(Cell==TargetCell)
            TargetFound = true;
        end
        i = i+1;
        Cell = Cell + Node.Config.ObsDir;
    end
    if TargetFound
        TrPlace = find(ObsStates(1,:)==TargetState);
        %% Simple Observation Model
        PZ_S(1,TargetState) = .6;
        if ObsStates(TrPlace+1) ~= -1
            PZ_S(1,ObsStates(TrPlace+1)) = .2;
        end
        if TrPlace ~= 1
            PZ_S(1,ObsStates(TrPlace-1)) = .2;           
        end
        PZ_S = 1/sum(PZ_S)*PZ_S;
    else
        PZ_S(1,end) = 1;
    end
end