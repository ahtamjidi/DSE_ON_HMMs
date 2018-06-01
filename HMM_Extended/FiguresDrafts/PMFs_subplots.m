figure;
k=1;
r= .2;
for n = [1 3 4 2 5 6]    
    for i = 1:Sim.NumStates
        if k<= 3
            t=21;
        else
            t=40;
        end
        [x,y] = find(Sim.World.StatesGrid == i);
        im1(x,y,k) = 1-Network.Node(n).HYB_Est.Post(i,t)^.2;        
    end
    pp = subplot(2,3,k);
    imagesc(im1(:,:,k),[0 1]);
    colormap gray
    axis square   
    hold on
    for j=1:6
        plot(Network.Node(j).Config.Pos(t,2),Network.Node(j).Config.Pos(t,1),'*','MarkerSize',10,'color','red');
    end
    xticklabels([]);yticklabels([]);
    hold off 

    k=k+1;
end