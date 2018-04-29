function Vis = VisStep(Sim,HMM,Network,Vis,t)
    %%Vis.PLot Observers
    World = Sim.World;
    for i = 1:Network.NumNodes
        ObsPos(1,1) = Network.Node(i).Config.Pos(t,2);
        ObsPos(1,2) = Network.Node(i).Config.Pos(t,1);
        set(Vis.Obs(i),'Position',[ObsPos(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*ObsPos(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2]);    
        set(Vis.ObsDir(i),'XData',[ObsPos(1,1)*Vis.PL-2*Vis.PL/4 ObsPos(1,1)*Vis.PL-2*Vis.PL/4+Network.Node(i).Config.ObsDir(1,2)*Vis.PL/2.5],'YData',[Vis.yLen-Vis.PL*ObsPos(1,2)+2*Vis.PL/4 Vis.yLen-Vis.PL*ObsPos(1,2)+2*Vis.PL/4-Network.Node(i).Config.ObsDir(1,1)*Vis.PL/2.5]);
        if Network.Node(i).z(t) ~= World.NumStates+1
            [zPos(1,2),zPos(1,1)] = find(World.StatesGrid == Network.Node(i).z(t));
            set(Vis.z(i),'Position',[zPos(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*zPos(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2],'Visible','on');
        else                            
            set(Vis.z(i),'Visible','off');
        end
    end
    %%Vis.PLot Target
    [TrPose(1,2),TrPose(1,1)] = find(World.StatesGrid == HMM.TrueStates(t));
    set(Vis.Target,'Position',[TrPose(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*TrPose(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2]); 
    Pos = cell2mat(get(Vis.Obs,'Position'));
    Vis.GraphPlt.delete;
    Vis.GraphPlt = plot(Vis.ax ,Network.graph{t}.simplify,'XData',Pos(:,1)+Pos(:,3)/2,'YData',Pos(:,2)+Pos(:,4)/2,'NodeColor', [0 0 1],'EdgeColor', [0 1 0],'LineWidth',4.0);
end
