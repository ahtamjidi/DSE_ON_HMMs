function Node = NodeLinearMove(World,Node,k)
    Node.Config.Pos(k+1,:) = Node.Config.Pos(k,:);
    NextPos = Node.Config.Pos(k+1,:) + Node.Config.MoveDir;
    if ~(any(NextPos(1,:)<1) || NextPos(1,1)>World.n_r || NextPos(1,2)>World.n_c || World.StatesGrid(NextPos(1,1),NextPos(1,2))==0)
        Node.Config.Pos(k+1,:) = NextPos;
    else
        Node.Config.MoveDir = -Node.Config.MoveDir;
        NextPos = Node.Config.Pos(k+1,:) + Node.Config.MoveDir;
        if ~(any(NextPos(1,:)<1) || NextPos(1,1)>World.n_r || NextPos(1,2)>World.n_c || World.StatesGrid(NextPos(1,1),NextPos(1,2))==0)
            Node.Config.Pos(k+1,:) = NextPos;
        end
    end
end