function Node = UpdateNodeObservation(World,Node,TargetState,k)
    switch Node.Config.ObsMdlType
        case 1
            PZ_S = PofZgivenS_Row_BeamMdl(World,Node,TargetState,k);
            Node.z(k) = SampleFromDist(PZ_S,1);
        otherwise
            Error('There is no ObsMdlType for the observer node');
    end
end