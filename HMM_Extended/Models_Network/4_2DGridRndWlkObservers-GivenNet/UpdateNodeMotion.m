function Node = UpdateNodeMotion(Sim,Node,k)
    switch Node.Config.MotionMdlType
        case 1
            Node = NodeLinearMove(Sim.World,Node,k);
        otherwise
            Error('There is no Motion Model for the observer node');
    end
end