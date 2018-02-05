function Node = UpdateNodeMotion(World,Sim,Node)
    switch Node.MotionMdlType
        case 1
            Node = NodeLinearMove(World,Node,Sim.MCtr);
        otherwise
            Error('There is no Motion Model for the observer node');
    end
end