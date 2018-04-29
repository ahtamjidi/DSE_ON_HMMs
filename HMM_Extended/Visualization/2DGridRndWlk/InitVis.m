function Vis = InitVis(Sim,HMM,Network,ax)
    %% Initialize
    World = Sim.World;
    Vis.PL = 1;
    Vis.xLen = Vis.PL*World.n_c;
    Vis.yLen = Vis.PL*World.n_r;
    
    %% Setup Figure
    if isempty(ax)        
        ax = axes;        
    end
    Vis.fig = ax.Parent;
    Vis.ax = ax;
    axis(ax,'square');
    axis(ax,[-.10 Vis.xLen+.1 -.1 Vis.yLen+.1]);
    colormap(gray);
    hold(ax);
    
    %% Vis.PLot World 
    image(ax,[Vis.PL/2 -Vis.PL/2+Vis.xLen],[Vis.PL/2 -Vis.PL/2+Vis.yLen],flipud(World.ImageGrid));
    for i = 0:Vis.PL:Vis.xLen
        plot(ax,[i i],[0 Vis.yLen],'k');
    end
    for i = 0:Vis.PL:Vis.yLen
        plot(ax,[0 Vis.xLen],[i i],'k');
    end
    
    %% Vis.PLot
    Vis.Obs = zeros(1,Network.NumNodes);
    Vis.ObsDir = zeros(1,Network.NumNodes);
    Vis.z = zeros(1,Network.NumNodes); 
    for i = 1:Network.NumNodes
        ObsPos(1,1) = Network.Node(i).Config.Pos(1,2);
        ObsPos(1,2) = Network.Node(i).Config.Pos(1,1);        
        Vis.Obs(i) = rectangle(ax,'Position',[ObsPos(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*ObsPos(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2],'Curvature',[.5 .5],'FaceColor','b');
        Vis.ObsDir(i) = line(ax,'XData',[ObsPos(1,1)*Vis.PL-2*Vis.PL/4 ObsPos(1,1)*Vis.PL-2*Vis.PL/4+Network.Node(i).Config.ObsDir(1,2)*Vis.PL/2.5],'YData',[Vis.yLen-Vis.PL*ObsPos(1,2)+2*Vis.PL/4 Vis.yLen-Vis.PL*ObsPos(1,2)+2*Vis.PL/4-Network.Node(i).Config.ObsDir(1,1)*Vis.PL/2.5],'Color','red','Marker','*');        
    end
    [TrPose(1,2),TrPose(1,1)] = find(World.StatesGrid == HMM.TrueStates(1));
    Vis.Target = rectangle(ax,'Position',[TrPose(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*TrPose(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2],'Curvature',[1 1],'FaceColor','r');
    for i = 1:Network.NumNodes
        if Network.Node(i).z(1,1)~= World.NumStates+1
            [zPos(1,2),zPos(1,1)] = find(World.StatesGrid == Network.Node(i).z(1,1));
            Vis.z(i) = rectangle(ax,'Position',[zPos(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*zPos(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2],'Curvature',[1 1],'FaceColor','green');
        else            
            Vis.z(i) = rectangle(ax,'Position',[0 0 Vis.PL/2 Vis.PL/2],'Curvature',[1 1],'FaceColor','green','Visible','off');
        end
    end
    Pos = cell2mat(get(Vis.Obs,'Position'));
    Vis.GraphPlt(1) = plot(Vis.ax ,Network.graph{1}.simplify,'XData',Pos(:,1)+Pos(:,3)/2,'YData',Pos(:,2)+Pos(:,4)/2,'NodeColor', [0 0 1],'EdgeColor', [0 1 0],'LineWidth',4.0);
end