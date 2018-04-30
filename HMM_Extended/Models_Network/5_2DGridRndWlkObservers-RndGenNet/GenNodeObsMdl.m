function NodeObsMdl = GenNodeObsMdl(World,Node,k)
    NodeObsMdl = zeros(World.NumStates,World.NumStates+1);
    for i = 1:World.NumStates 
        NodeObsMdl(i,:) = PofZgivenS_Row_BeamMdl(World,Node,i,k);
    end
end