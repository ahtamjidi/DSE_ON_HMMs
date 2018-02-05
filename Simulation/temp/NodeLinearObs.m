function Node = NodeLinearObs(World,Node,TargetState,k)
    [TargetCell(1,1),TargetCell(1,2)] = find(World.StatesGrid == TargetState);
    Node.ObsStates(k,:) = -ones(1,World.DiagLen);
    Node.ProbStates(k,:) = zeros(1,World.DiagLen);
    Node.z(k,1) = -1;
    ObsStates = Node.ObsStates(k,:);
    Cell = Node.Pos(k,:);
    TargetFound = false;
    i = 1;
    while ~(any(Cell(1,:)<1) || Cell(1,1)>World.n_r || Cell(1,2)>World.n_c || World.StatesGrid(Cell(1,1),Cell(1,2))==0)
        ObsStates(1,i) = World.StatesGrid(Cell(1,1),Cell(1,2));
        if all(Cell==TargetCell)
            TargetFound = true;
        end
        i = i+1;
        Cell = Cell + Node.ObsDir;
    end
    if TargetFound
        Node.ObsStates(k,:) = ObsStates;
        TrPlace = find(Node.ObsStates(k,:)==TargetState);
        %% Simple Observation Model
        Node.ProbStates(k,TrPlace) = .8;
        if ObsStates(TrPlace+1) ~= -1
            Node.ProbStates(k,TrPlace+1) = .1;            
        end
        if TrPlace ~= 1
            Node.ProbStates(k,TrPlace-1) = .1;            
        end
        Node.ProbStates(k,:) = 1/sum(Node.ProbStates(k,:))*Node.ProbStates(k,:);
        Node.z(k,1) = ObsStates(SampleFromDist(Node.ProbStates(k,:),1));
    end
end