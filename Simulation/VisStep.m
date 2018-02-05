function VisStep(World,Sim,Net,Vis,t)
    %%Vis.PLot Observers
    for i = 1:Net.NumOfNodes
        ObsPos(1,1) = Net.Node(i).Pos(t,2);
        ObsPos(1,2) = Net.Node(i).Pos(t,1);
        set(Vis.Obs(i),'Position',[ObsPos(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*ObsPos(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2]);    
        set(Vis.ObsDir(i),'XData',[ObsPos(1,1)*Vis.PL-2*Vis.PL/4 ObsPos(1,1)*Vis.PL-2*Vis.PL/4+Net.Node(i).ObsDir(1,2)*Vis.PL/2.5],'YData',[Vis.yLen-Vis.PL*ObsPos(1,2)+2*Vis.PL/4 Vis.yLen-Vis.PL*ObsPos(1,2)+2*Vis.PL/4-Net.Node(i).ObsDir(1,1)*Vis.PL/2.5]);
        if Net.Node(i).z(t,1) ~= World.NumStates+1
            [zPos(1,2),zPos(1,1)] = find(World.StatesGrid == Net.Node(i).z(t,1));
            set(Vis.z(i),'Position',[zPos(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*zPos(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2],'Visible','on');
        else                            
            set(Vis.z(i),'Visible','off');
        end
    end
    %%Vis.PLot Target
    [TrPose(1,2),TrPose(1,1)] = find(World.StatesGrid == Sim.GT(t));
    set(Vis.Target,'Position',[TrPose(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*TrPose(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2]);        
end
