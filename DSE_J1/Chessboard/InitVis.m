function Vis = InitVis(World,Sim,Net)
    %% Initialize
    global Config
    Vis.PL = Config.PixelLen;
    Vis.xLen = Vis.PL*World.n_c;
    Vis.yLen = Vis.PL*World.n_r;
    
    %% Setup Figure

        Vis.fig = gcf;

    axis square;
    axis([-.10 Vis.xLen+.1 -.1 Vis.yLen+.1]);
    colormap(gray);
    hold on;
    
    %% Vis.PLot World 
    image([Vis.PL/2 -Vis.PL/2+Vis.xLen],[Vis.PL/2 -Vis.PL/2+Vis.yLen],flipud(World.ImageGrid));
    for i = 0:Vis.PL:Vis.xLen
        plot([i i],[0 Vis.yLen],'k');
    end
    for i = 0:Vis.PL:Vis.yLen
        plot([0 Vis.xLen],[i i],'k');
    end
    
    %% Vis.PLot
    Vis.Obs = zeros(1,Net.NumOfNodes);
    Vis.ObsDir = zeros(1,Net.NumOfNodes);
    Vis.z = zeros(1,Net.NumOfNodes); 
    for i = 1:Net.NumOfNodes
        ObsPos(1,1) = Net.Node(i).Pos(1,2);
        ObsPos(1,2) = Net.Node(i).Pos(1,1);        
        Vis.Obs(i) = rectangle('Position',[ObsPos(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*ObsPos(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2],'Curvature',[.5 .5],'FaceColor','b');
        Vis.ObsDir(i) = line('XData',[ObsPos(1,1)*Vis.PL-2*Vis.PL/4 ObsPos(1,1)*Vis.PL-2*Vis.PL/4+Net.Node(i).ObsDir(1,2)*Vis.PL/2.5],'YData',[Vis.yLen-Vis.PL*ObsPos(1,2)+2*Vis.PL/4 Vis.yLen-Vis.PL*ObsPos(1,2)+2*Vis.PL/4-Net.Node(i).ObsDir(1,1)*Vis.PL/2.5],'Color','red','Marker','*');        
    end
    [TrPose(1,2),TrPose(1,1)] = find(World.StatesGrid == Sim.GT(1));
    Vis.Target = rectangle('Position',[TrPose(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*TrPose(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2],'Curvature',[1 1],'FaceColor','r');
    for i = 1:Net.NumOfNodes
        if Net.Node(i).z(1,1)~= World.NumStates+1
            [zPos(1,2),zPos(1,1)] = find(World.StatesGrid == Net.Node(i).z(1,1));
            Vis.z(i) = rectangle('Position',[zPos(1,1)*Vis.PL-3*Vis.PL/4 Vis.yLen-Vis.PL*zPos(1,2)+1*Vis.PL/4 Vis.PL/2 Vis.PL/2],'Curvature',[1 1],'FaceColor','green');
        else            
            Vis.z(i) = rectangle('Position',[0 0 Vis.PL/2 Vis.PL/2],'Curvature',[1 1],'FaceColor','green','Visible','off');
        end
    end
end