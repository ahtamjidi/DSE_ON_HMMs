function AnimateSim(World,Sim)
    global Consts
    PL = Consts.PixelLen;
    xLen = PL*World.n_c;
    yLen = PL*World.n_r;
    figure;
    axis equal;
    axis([-.10 xLen+.1 -.1 yLen+.1]);
    colormap(gray);
    hold on;
    image([PL/2 -PL/2+xLen],[PL/2 -PL/2+yLen],flipud(World.ImageGrid));
    for i = 0:PL:xLen 
        plot([i i],[0 yLen],'k');
    end
    for i = 0:PL:yLen
        plot([0 xLen],[i i],'k');
    end

    [Pose(1,2),Pose(1,1)] = find(World.StatesGrid == Sim.GT(1));
    Target = rectangle('Position',[Pose(1,1)*PL-3*PL/4 yLen-PL*Pose(1,2)+1*PL/4 PL/2 PL/2],'Curvature',[1 1],'FaceColor','r');
    for t = 2:size(Sim.GT,2)
        [Pose(1,2),Pose(1,1)] = find(World.StatesGrid == Sim.GT(t));
        set(Target,'Position',[Pose(1,1)*PL-3*PL/4 yLen-PL*Pose(1,2)+1*PL/4 PL/2 PL/2]);
        pause(.1);
    end
end
% Target = line('XData',[Pose(1,1)*PL-3*PL/4 Pose(1,1)*PL-1*PL/4],'YData',[yLen-PL*Pose(1,2)+1*PL/4 yLen-PL*Pose(1,2)+3*PL/4],'Color','red','Marker','*');
% set(Target,'XData',[Pose(1,1)*PL-3*PL/4 Pose(1,1)*PL-1*PL/4],'YData',[yLen-PL*Pose(1,2)+1*PL/4 yLen-PL*Pose(1,2)+3*PL/4]);