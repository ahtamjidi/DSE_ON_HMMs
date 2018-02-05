function Node = NodeLinearMove(World,Node,k)
    Node.Pos(k+1,:) = Node.Pos(k,:);
    NextPos = Node.Pos(k+1,:) + Node.MoveDir;
    if ~(any(NextPos(1,:)<1) || NextPos(1,1)>World.n_r || NextPos(1,2)>World.n_c || World.StatesGrid(NextPos(1,1),NextPos(1,2))==0)
        Node.Pos(k+1,:) = NextPos;
    else
        Node.MoveDir = -Node.MoveDir;
        NextPos = Node.Pos(k+1,:) + Node.MoveDir;
        if ~(any(NextPos(1,:)<1) || NextPos(1,1)>World.n_r || NextPos(1,2)>World.n_c || World.StatesGrid(NextPos(1,1),NextPos(1,2))==0)
            Node.Pos(k+1,:) = NextPos;
        end
    end
end